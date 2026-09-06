import os
import textwrap
from string import Template

import yaml

REF = "release"
TARBALL = f"https://codeload.github.com/apple/device-management/tar.gz/refs/heads/{REF}"

MODULE_PATH = "modules/profiles/generated"
PROFILE_IDENTIFIER_PREFIX = "com.example.manage-ios."

CACHE_DIR = "tmp"

GEN_OPTS = yaml.safe_load(open("pkgs/import-profiles/gen-options.yaml", "r"))


def fetch_tarball():
    # if already in cache, return bytes
    cache_path = os.path.join(CACHE_DIR, f"device-management.tar.gz")
    if os.path.exists(cache_path):
        with open(cache_path, "rb") as f:
            print(f"Using cached tarball from {cache_path}")
            return f.read()

    import urllib.request

    print(f"Fetching tarball from {TARBALL}")
    with urllib.request.urlopen(TARBALL) as response:
        blob = response.read()

    # save to cache
    os.makedirs(CACHE_DIR, exist_ok=True)
    with open(cache_path, "wb") as f:
        f.write(blob)

    return blob


# --- START OF LLM GENERATED CODE ---

from dataclasses import dataclass

from yaml.events import AliasEvent
from yaml.nodes import MappingNode, ScalarNode

STR = "tag:yaml.org,2002:str"
MAP = "tag:yaml.org,2002:map"


@dataclass(frozen=True)
class Ref:
    name: str


class RefLoader(yaml.SafeLoader):
    def __init__(self, stream):
        super().__init__(stream)
        self.definitions = {}  # Composer clears self.anchors per document

    def flatten_mapping(self, node):
        return  # keep '<<' as a literal key

    def compose_node(self, parent, index):
        # Case 1: '*name'. Base class would return the shared node here.
        # Consume the event ourselves and emit a marker node instead.
        # Unknown anchor -> do not intercept; super() raises with source marks.
        if self.check_event(AliasEvent) and self.peek_event().anchor in self.anchors:
            e = self.get_event()
            return ScalarNode("!ref", e.anchor, e.start_mark, e.end_mark)

        # Case 2: any other node. Read the anchor off the event before
        # super() consumes it. None for an unanchored node.
        anchor = self.peek_event().anchor

        # Builds the node and recurses into children through this same
        # override, so nested aliases become markers too. Also fills
        # self.anchors, which case 1 reads on the next alias.
        node = super().compose_node(parent, index)

        if anchor is None or node is None:
            return node

        # Case 3: '&name'. Move the real node into the side table and
        # leave a marker in the document, so the definition appears once.
        self.definitions[anchor] = node
        return ScalarNode("!ref", anchor, node.start_mark, node.end_mark)


RefLoader.add_constructor("!ref", lambda l, n: Ref(n.value))
RefLoader.add_constructor("tag:yaml.org,2002:merge", lambda l, n: "<<")


def load_yaml(stream):
    loader = RefLoader(stream)
    try:
        # Parse + compose only. No Python objects yet, just nodes.
        # get_single_node() returns None for an empty stream.
        doc = loader.get_single_node() or ScalarNode(STR, "")

        # Definitions are still nodes; wrap them as mapping key/value pairs.
        defs = [(ScalarNode(STR, k), v) for k, v in loader.definitions.items()]

        # Construct both trees in ONE pass under a synthetic root.
        # Two separate construct_document() calls would not work: the
        # constructor holds per-document generator state.
        data = loader.construct_document(
            MappingNode(
                MAP,
                [
                    (ScalarNode(STR, "definitions"), MappingNode(MAP, defs)),
                    (ScalarNode(STR, "document"), doc),
                ],
            )
        )
        return data
    finally:
        loader.dispose()  # frees the parser/scanner buffers


# --- END OF LLM GENERATED CODE ---


def extract_profiles(tarball_bytes):
    import io
    import sys
    import tarfile
    from pathlib import Path

    profiles = dict()
    with tarfile.open(fileobj=io.BytesIO(tarball_bytes), mode="r:gz") as tar:
        for member in tar.getmembers():
            # <repo>-<ref>/mdm/profiles/<file>.yaml
            parts = Path(member.name).parts
            if len(parts) != 4 or parts[1:3] != ("mdm", "profiles"):
                continue
            name = parts[3]
            if not name.startswith("com.apple.") or not name.endswith(".yaml"):
                continue
            handle = tar.extractfile(member)
            if handle is None:
                continue
            parsed_yaml = load_yaml(handle.read().decode("utf-8"))
            module_name = name.replace(".yaml", "")
            profiles[module_name] = parsed_yaml

    if not profiles:
        sys.exit("no com.apple.*.yaml files found in the tarball")

    return profiles


def profile_supports_ios(profile):
    ios_version = (
        profile.get("payload", {})
        .get("supportedOS", {})
        .get("iOS", {})
        .get("introduced")
    )
    return ios_version not in (None, "n/a")


from enum import Enum, auto


class DefinitionType(Enum):
    ARRAY = auto()
    DICTIONARY = auto()


def payload_key_supports_ios(payload_key):
    ios_version = payload_key.get("supportedOS", {}).get("iOS", {}).get("introduced")
    return ios_version != "n/a"


def is_array_definition(subkeys, key):
    return len(subkeys) == 1 and key == subkeys[0]["key"]


def maybe_resolve_ref(payload, definitions, refs_seen, gen_opts):
    if isinstance(payload, Ref):
        name = payload.name
        number_seen = refs_seen.get(payload.name, 0) + 1
        max_depth = gen_opts.get("maxRecursionDepth", {}).get(name)
        if max_depth is not None and number_seen > max_depth:
            return (False, None, refs_seen)

        payload = definitions[name]
        refs_seen = {**refs_seen, name: number_seen}

    return (True, payload, refs_seen)


def get_support_data_in_ref(
    payload_key, definitions, key_path, support_data, refs_seen, gen_opts
):
    (ok, payload_key, refs_seen) = maybe_resolve_ref(
        payload_key, definitions, refs_seen, gen_opts
    )
    if not ok or not payload_key:
        return []

    new_support_data = get_support_data(payload_key, support_data)

    key = "settings" if payload_key["key"] == "ANY" else payload_key["key"]
    key_path = key_path + [key]

    nested_support_data_list = []
    if payload_key.get("type") == "<dictionary>":
        subkeys = payload_key.get("subkeys", [])
        (ok, subkeys, refs_seen) = maybe_resolve_ref(
            subkeys, definitions, refs_seen, gen_opts
        )

        if not ok or not subkeys:
            nested_support_data_list = []
        elif len(subkeys) != 1 or subkeys[0]["key"] != "ANY":
            nested_support_data_list = get_support_data_in_dict_ref(
                subkeys, definitions, key_path, new_support_data, refs_seen, gen_opts
            )

    if payload_key.get("type") == "<array>":
        nested_support_data_list = get_support_data_in_array_ref(
            payload_key["subkeys"],
            definitions,
            key_path,
            new_support_data,
            refs_seen,
            gen_opts,
        )

    new_support_data_list = [{"path": key_path, "value": new_support_data}]

    return new_support_data_list + nested_support_data_list


def get_support_data_in_dict_ref(
    subkeys, definitions, key_path, support_data, refs_seen, gen_opts
):
    (ok, subkeys, refs_seen) = maybe_resolve_ref(
        subkeys, definitions, refs_seen, gen_opts
    )
    if not ok or not subkeys:
        return []

    return [
        get_support_data_in_ref(
            subkey, definitions, key_path, support_data, refs_seen, gen_opts
        )
        for subkey in subkeys
    ]


def get_support_data_in_array_ref(
    subkeys, definitions, key_path, support_data, refs_seen, gen_opts
):
    (ok, subkeys, refs_seen) = maybe_resolve_ref(
        subkeys, definitions, refs_seen, gen_opts
    )
    if not ok or not subkeys:
        return []

    subkey = subkeys[0]

    if subkey.get("type") == "<array>":
        return get_support_data_in_array_ref(
            subkey["subkeys"],
            definitions,
            key_path,
            support_data,
            refs_seen,
            gen_opts,
        )

    if subkey.get("type") == "<dictionary>":
        return get_support_data_in_dict_ref(
            subkey["subkeys"],
            definitions,
            key_path + ["*"],
            support_data,
            refs_seen,
            gen_opts,
        )

    return []


def dictionary_to_nix_submodule(
    subkeys, definitions, key_path, support_data, indent, opts
):
    if isinstance(subkeys, Ref):
        support_data_list = get_support_data_in_array_ref(
            subkeys, definitions, key_path, support_data, {}, opts["gen_opts"]
        )
        decr_counter = opts.get("decr_var_counters", False)

        return (
            [(subkeys.name, DefinitionType.DICTIONARY, support_data)],
            support_data_list,
            ref_var_name(subkeys.name, decr_counter),
        )

    if len(subkeys) == 1 and subkeys[0]["key"] == "ANY":
        nix_type = key_type_to_nix_type(
            subkeys[0], definitions, key_path, support_data, indent + "  ", opts
        )[2]
        return ([], [], f"(types.attrsOf {nix_type})")

    smaller_template = """
        (utils.subopts {
          $options
        })
    """

    indented_smaller_template = textwrap.indent(
        textwrap.dedent(smaller_template), indent
    ).strip()

    template = """
        (
          utils.subopts {
            $options
          }
        )
    """.lstrip(
        "\n"
    ).rstrip()

    indented_template = textwrap.indent(textwrap.dedent(template), indent).lstrip()

    use_smaller_template = opts.get("collapse_parentheses", False)
    opts = {k: v for k, v in opts.items() if k != "collapse_parentheses"}

    added_indent = "  " if use_smaller_template else "    "
    new_indent = added_indent + indent
    (def_types, support_data_list, options) = process_sub_keys(
        subkeys, definitions, key_path, support_data, new_indent, opts
    )

    template = indented_smaller_template if use_smaller_template else indented_template

    return (
        def_types,
        support_data_list,
        Template(template).substitute(options="\n".join(options).strip()),
    )


def gen_type_fn_lines(fn, param, indent):
    if "\n" in param:
        template = """
            (
            $indent  $fn $param
            $indent)
        """
        indented_template = textwrap.dedent(template).strip()
        param = textwrap.indent(param, "  ").lstrip()
        return Template(indented_template).substitute(fn=fn, param=param, indent=indent)

    return f"({fn} {param})"


def key_type_to_nix_type(
    payload_key, definitions, key_path, support_data, indent, opts
):
    def ret_type(nix_type):
        return ([], [], nix_type)

    if payload_key.get("rangelist"):
        enum_values = map(lambda s: to_nix_value(s), payload_key["rangelist"])
        value_lines = list(map(lambda s: "    " + s, enum_values))
        lines_below = map(
            lambda l: indent + l,
            ["  types.enum ["] + value_lines + ["  ]", ")"],
        )

        return ret_type(f"(\n{'\n'.join(lines_below)}")

    match payload_key["type"]:
        case "<boolean>":
            return ret_type("types.bool")
        case "<string>":
            if payload_key.get("format"):
                return ret_type(f'(types.strMatching "{payload_key["format"]}")')

            return ret_type("types.str")
        case "<integer>":
            intRange = payload_key.get("range")
            if intRange:
                if intRange.get("min") is not None:
                    if intRange.get("max") is not None:
                        return ret_type(
                            f"(types.ints.between {intRange['min']} {intRange['max']})"
                        )
                    return ret_type(f"(utils.intMin {intRange['min']})")
                return ret_type(f"(utils.intMax {intRange['max']})")

            return ret_type("types.int")
        case "<real>":
            if payload_key.get("range"):
                range_min = payload_key["range"]["min"]
                range_max = payload_key["range"]["max"]
                return ret_type(f"(utils.floatBetween ({range_min}) ({range_max}))")

            return ret_type("types.float")
        case "<data>":
            return ret_type("utils.plistDataType")
        case "<array>":
            subkeys = payload_key["subkeys"]
            if isinstance(subkeys, Ref):
                support_data_list = get_support_data_in_array_ref(
                    subkeys, definitions, key_path, support_data, {}, opts["gen_opts"]
                )
                decr_counter = opts.get("decr_var_counters", False)

                return (
                    [(subkeys.name, DefinitionType.ARRAY, support_data)],
                    support_data_list,
                    ref_var_name(subkeys.name, decr_counter),
                )

            (def_types, support_data_list, item_nix_type) = key_type_to_nix_type(
                subkeys[0],
                definitions,
                key_path + ["*"],
                support_data,
                indent,
                opts,
            )
            nix_type = gen_type_fn_lines("types.listOf", item_nix_type, indent)
            return (def_types, support_data_list, nix_type)
        case "<dictionary>":
            return dictionary_to_nix_submodule(
                payload_key["subkeys"],
                definitions,
                key_path,
                support_data,
                indent,
                opts,
            )
        case "<any>":
            return ret_type("types.anything")
        case _:
            return ret_type("unknown")


def get_support_description(support_data):
    ios_part = ""
    if support_data["minIos"] is not None or support_data["maxIos"] is not None:
        ios_parts = [
            f">= {support_data['minIos']}" if support_data["minIos"] else None,
            f"< {support_data['maxIos']}" if support_data["maxIos"] else None,
        ]
        ios_part = "iOS " + " and ".join(filter(None, ios_parts))

    supervised_part = "supervised device" if support_data["supervised"] else None

    if not ios_part and not supervised_part:
        return None

    result = "Requires: " + "; ".join(filter(None, [ios_part, supervised_part]))

    if support_data["deprecatedIos"]:
        result += f"\nDeprecated in iOS {support_data['deprecatedIos']}"

    return result


def payload_key_to_option(
    payload_key, definitions, key_path, support_data, indent, opts
):
    template = """
        "$key" = mkProfileOpt {
          type = $nix_type;
          description = ''
            $description
          '';
          required = $required;
        };
    """.lstrip(
        "\n"
    ).rstrip()

    indented_template = textwrap.indent(textwrap.dedent(template), indent)

    new_support_data = get_support_data(payload_key, support_data)

    raw_description = payload_key.get("content", "")

    support_description_string = get_support_description(new_support_data)
    if support_description_string:
        raw_description = f"{raw_description}\n\n{support_description_string}"

    width = 60
    wrapper = textwrap.TextWrapper(width=width)
    description = "\n".join(wrapper.fill(line) for line in raw_description.split("\n"))
    description = textwrap.indent(description, indent + "    ").strip()

    key = payload_key["key"]

    is_any = key == "ANY"

    if is_any:
        key = "settings"

    key_path = key_path + [key]
    (def_types, nested_support_data_list, nix_type) = key_type_to_nix_type(
        payload_key, definitions, key_path, new_support_data, indent + "  ", opts
    )

    if is_any:
        nix_type = f"(utils.settingsOf {nix_type})"

    required = (
        "true" if payload_key.get("presence", "optional") == "required" else "false"
    )

    new_support_data_list = [{"path": key_path, "value": new_support_data}]

    return (
        def_types,
        new_support_data_list + nested_support_data_list,
        Template(indented_template).substitute(
            key=key,
            nix_type=nix_type,
            description=description,
            required=required,
        ),
    )


def process_sub_keys(subkeys, definitions, key_path, support_data, indent, opts):
    results = [
        payload_key_to_option(
            payload_key, definitions, key_path, support_data, indent, opts
        )
        for payload_key in subkeys
        if payload_key_supports_ios(payload_key)
    ]

    def_types = [def_type for def_type, _, _ in results]
    support_data_list = [support_data_list for _, support_data_list, _ in results]
    options = [option for _, _, option in results]

    return (def_types, support_data_list, options)


def ref_var_name(name, decr_counter):
    if decr_counter:
        return f'(type-{name} (decrCounter "{name}"))'
    return f"(type-{name} {{ }})"


def define_definition(definitions, def_type, gen_opts):
    name = def_type[0]
    max_depth = gen_opts.get("maxRecursionDepth", {}).get(name, 10)

    single_line_template = textwrap.indent("$var_name = _: $nix_type;", "  ")

    simple_template = """
        $var_name =
          _:
          $nix_type;
    """

    indented_simple_template = textwrap.indent(
        textwrap.dedent(simple_template).lstrip(), ""
    )

    recursive_template = """
        $var_name =
          {
            $counter_name ? $max_depth,
            ...
          }@args:
          let
            counters = args // {
              inherit $counter_name;
            };
            decrCounter =
              name:
              if counters ? "counter-$${name}" then
                counters // { "counter-$${name}" = counters."counter-$${name}" - 1; }
              else
                counters;
          in
          if counters ? $counter_name && counters.$counter_name <= 0 then
            types.anything
          else
            $nix_type;
    """

    indented_rec_template = textwrap.dedent(recursive_template).lstrip()

    new_def_types = []
    nix_type = None

    match def_type:
        case (name, DefinitionType.ARRAY, support_data):
            subkeys = definitions[name]
            opts = {"gen_opts": gen_opts, "decr_var_counters": True}
            (new_def_types, _, nix_type) = key_type_to_nix_type(
                subkeys[0], definitions, [], support_data, "  ", opts
            )
            new_def_types = list(flatten(new_def_types))

            if new_def_types:
                nix_type = textwrap.indent(nix_type, "  ").lstrip()

            nix_type = f"(types.listOf {nix_type})"
        case (name, DefinitionType.DICTIONARY, support_data):
            subkeys = definitions[name]
            opts = {
                "gen_opts": gen_opts,
                "decr_var_counters": True,
                "collapse_parentheses": True,
            }
            (new_def_types, _, nix_type) = dictionary_to_nix_submodule(
                subkeys, definitions, [], support_data, "", opts
            )
        case _:
            raise ValueError(f"unknown definition type: {def_type}")

    template = indented_rec_template

    new_def_types = list(flatten(new_def_types))
    if not new_def_types:
        if "\n" in nix_type:
            template = indented_simple_template
        else:
            template = single_line_template

    var_def = Template(template).substitute(
        var_name=f"type-{name}",
        counter_name=f"counter-{name}",
        max_depth=max_depth,
        nix_type=nix_type,
    )

    return (
        new_def_types,
        textwrap.dedent(var_def),
    )


def parse_version(v):
    return tuple(int(x) for x in v.split("."))


def merge_versions(v1, v2, fn):
    if v1 is None:
        return v2
    if v2 is None:
        return v1
    if fn == "max":
        if parse_version(v1) > parse_version(v2):
            return v1
        return v2
    if fn == "min":
        if parse_version(v1) < parse_version(v2):
            return v1
        return v2
    if fn == "bool and":
        return v1 and v2


def merge_support_data(data1, data2):
    return {
        "minIos": merge_versions(data1.get("minIos"), data2.get("minIos"), "min"),
        "deprecatedIos": None,
        "maxIos": merge_versions(data1.get("maxIos"), data2.get("maxIos"), "max"),
        "supervised": merge_versions(
            data1.get("supervised"), data2.get("supervised"), "bool and"
        ),
    }


def merge_def_types(support_data_list):
    seen = {}
    for name, atype, data in support_data_list:
        if name in seen and seen[name][0] != atype:
            raise ValueError(
                f"Conflicting definition types for {name}: {seen[name][0]} vs {atype}"
            )
        merged = merge_support_data(seen[name][1], data) if name in seen else data
        seen[name] = (atype, merged)

    return [(name, atype, data) for name, (atype, data) in seen.items()]


def define_definitions(definitions, def_types, gen_opts, prev_def_types=[]):
    def_types = merge_def_types(def_types)
    # check if no conflicts in prev_def_types
    merge_def_types(def_types + prev_def_types)

    prev_names = set(name for name, _, _ in prev_def_types)
    def_types = [
        (name, def_type, support_data)
        for name, def_type, support_data in def_types
        if name not in prev_names
    ]

    def_types_and_vars = [
        define_definition(definitions, def_type, gen_opts) for def_type in def_types
    ]

    vars = [var for _, var in def_types_and_vars]
    new_def_types = [new_def_type for new_def_type, _ in def_types_and_vars]

    if new_def_types:
        new_def_types = list(flatten(new_def_types))
        new_vars = define_definitions(
            definitions,
            new_def_types,
            gen_opts,
            def_types + prev_def_types,
        )
        return vars + new_vars

    return vars


def flatten(obj):
    for item in obj:
        if isinstance(item, list):
            yield from flatten(item)
        else:
            yield item


def to_nix_value(value):
    if value is None:
        return "null"
    elif value is True:
        return "true"
    elif value is False:
        return "false"
    elif isinstance(value, (int, float)):
        return str(value)
    return f'"{value}"'


def get_support_data(payload, prev_data={}):
    return {
        "minIos": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("introduced", prev_data.get("minIos")),
        "deprecatedIos": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("deprecated", prev_data.get("deprecatedIos")),
        "maxIos": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("removed", prev_data.get("maxIos")),
        "supervised": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("supervised", prev_data.get("supervised")),
    }


def gen_support_data_string(support_data_list, global_values):
    template = """
        $key = {
          minIos = $min_ios;
          maxIos = $max_ios;
          supervised = $supervised;
        };
    """

    indented_template = (
        textwrap.indent(textwrap.dedent(template), "    ").lstrip("\n").rstrip()
    )

    main_support_data = {
        "path": ["enable"],
        "value": global_values,
    }

    all_support_data = [main_support_data] + list(flatten(support_data_list))

    support_strings = map(
        lambda entry: Template(indented_template).substitute(
            key=".".join([to_nix_value(k) for k in entry["path"]]),
            min_ios=to_nix_value(entry["value"]["minIos"]),
            max_ios=to_nix_value(entry["value"]["maxIos"]),
            supervised=to_nix_value(entry["value"]["supervised"]),
        ),
        all_support_data,
    )

    return "\n".join(support_strings)


def profile_to_module(profile, module_name):
    template = """
        # Generated from import-profiles.py. Do not edit.
        { lib, utils, ... }:
        let
          inherit (lib) types mkEnableOption mkOption;
          inherit (utils) mkProfileOpt;$var_definitions
        in
        {
          description = ''
            $description
          '';
          options = {
            enable = mkEnableOption "Enable the $payload_type profile";
            PayloadType = mkOption {
              type = types.str;
              default = "$payload_type";
              description = "The payload type for this profile";
            };
            PayloadIdentifier = mkOption {
              type = types.str;
              default = "$identifier";
              description = "The payload identifier for this profile";
            };
            PayloadUUID = mkOption {
              type = types.str;
              description = "The payload UUID for this profile";
            };
            PayloadVersion = mkOption {
              type = types.int;
              default = 1;
              description = "The payload version for this profile";
            };
            $options
          };
          supportData = {
            $support_data
          };
        }
    """.removeprefix(
        "\n"
    )

    gen_opts = GEN_OPTS.get(module_name, {})

    definitions = profile["definitions"]
    profile = profile["document"]

    name = module_name.replace("com.apple.", "")
    payload_type = profile["payload"]["payloadtype"]

    description_parts = [
        profile.get("description"),
        profile["payload"].get("content"),
        profile.get("notes", [{}])[0].get("content"),
    ]

    description_lines = "\n\n".join(filter(None, description_parts)).split("\n")
    formatted_descr_lines = [
        textwrap.fill(line, width=80) for line in description_lines
    ]

    description = textwrap.indent("\n".join(formatted_descr_lines), "    ").strip()

    ios_payload_keys = list(
        filter(payload_key_supports_ios, profile.get("payloadkeys", []))
    )

    global_support_data = get_support_data(profile["payload"])
    opts = {"gen_opts": gen_opts}
    (def_types, support_data_list, options) = process_sub_keys(
        ios_payload_keys, definitions, [], global_support_data, "    ", opts
    )

    var_def_list = define_definitions(definitions, list(flatten(def_types)), gen_opts)
    var_definitions = textwrap.indent("\n".join(var_def_list), "  ")
    var_definitions = "\n\n" + var_definitions if var_definitions else ""

    support_data_string = gen_support_data_string(
        support_data_list, global_support_data
    )

    return Template(textwrap.dedent(template)).substitute(
        description=description,
        payload_type=payload_type,
        identifier=f"{PROFILE_IDENTIFIER_PREFIX}{name}",
        options="\n".join(options).strip(),
        var_definitions=var_definitions,
        support_data=support_data_string.strip(),
    )


def write_module(module_name, module_content):
    module_path = os.path.join(MODULE_PATH, f"{module_name}.nix")
    with open(module_path, "w") as f:
        f.write(module_content)


def main():
    if not os.path.exists(MODULE_PATH):
        raise SystemExit(
            f"module path {MODULE_PATH} does not exist. May be executing in wrong directory?"
        )

    tarball_bytes = fetch_tarball()
    profiles = extract_profiles(tarball_bytes)

    profile_items = [
        (module_name, profile)
        for module_name, profile in profiles.items()
        if profile_supports_ios(profile["document"])
    ]

    print(f"Found {len(profile_items)} profiles for iOS.")

    for module_name, profile in profile_items:
        module_content = profile_to_module(profile, module_name)
        write_module(module_name, module_content)
        print(f"Generated module for {module_name}")


if __name__ == "__main__":
    main()
