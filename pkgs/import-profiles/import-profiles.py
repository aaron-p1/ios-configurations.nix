import os
import textwrap
from string import Template

import yaml

REF = "release"
TARBALL = f"https://codeload.github.com/apple/device-management/tar.gz/refs/heads/{REF}"

MODULE_PATH = "modules/profiles/generated"
PROFILE_IDENTIFIER_PREFIX = "com.example.manage-ios."

CACHE_DIR = "tmp"


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


def payload_key_supports_ios(payload_key):
    ios_version = payload_key.get("supportedOS", {}).get("iOS", {}).get("introduced")
    return ios_version != "n/a"


def is_array_definition(subkeys, key):
    return len(subkeys) == 1 and key == subkeys[0]["key"]


def get_support_data_in_ref(payload_key, definitions, key_path, support_data):
    if isinstance(payload_key, Ref):
        payload_key = definitions[payload_key.name]

    new_support_data = get_support_data(payload_key, support_data)

    key = "settings" if payload_key["key"] == "ANY" else payload_key["key"]
    key_path = key_path + [key]

    nested_support_data_list = []
    if payload_key.get("type") == "<dictionary>":
        subkeys = payload_key.get("subkeys", [])
        if isinstance(subkeys, Ref):
            subkeys = definitions.get(subkeys.name, [])

        if len(subkeys) != 1 or subkeys[0]["key"] != "ANY":
            nested_support_data_list = get_support_data_in_dict_ref(
                subkeys, definitions, key_path, new_support_data
            )

    if payload_key.get("type") == "<array>":
        nested_support_data_list = get_support_data_in_array_ref(
            payload_key["subkeys"], definitions, key_path, new_support_data
        )

    new_support_data_list = [{"path": key_path, "value": new_support_data}]

    return new_support_data_list + nested_support_data_list


def get_support_data_in_dict_ref(subkeys, definitions, key_path, support_data):
    if isinstance(subkeys, Ref):
        subkeys = definitions[subkeys.name]

    return [
        get_support_data_in_ref(subkey, definitions, key_path, support_data)
        for subkey in subkeys
    ]


def get_support_data_in_array_ref(subkeys, definitions, key_path, support_data):
    if isinstance(subkeys, Ref):
        subkeys = definitions[subkeys.name]

    subkey = subkeys[0]
    if subkey.get("type") == "<dictionary>":
        return get_support_data_in_dict_ref(
            subkey["subkeys"], definitions, key_path + ["*"], support_data
        )

    return []


def dictionary_to_nix_submodule(subkeys, definitions, key_path, support_data, indent):
    if len(subkeys) == 1 and subkeys[0]["key"] == "ANY":
        nix_type = key_type_to_nix_type(
            subkeys[0], definitions, key_path, support_data, indent + "  "
        )[2]
        return ([], [], f"(types.attrsOf {nix_type})")

    template = """
        (
          types.submodule (
            { ... }: {
              options = {
                $options
              };
            }
          )
        )
    """.lstrip(
        "\n"
    ).rstrip()

    indented_template = textwrap.indent(textwrap.dedent(template), indent).lstrip()

    new_indent = "        " + indent
    (def_types, support_data_list, options) = process_sub_keys(
        subkeys, definitions, key_path, support_data, new_indent
    )

    return (
        def_types,
        support_data_list,
        Template(indented_template).substitute(options="\n".join(options).strip()),
    )


def key_type_to_nix_type(payload_key, definitions, key_path, support_data, indent):
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
            if payload_key.get("range"):
                range_min = payload_key["range"]["min"]
                range_max = payload_key["range"]["max"]
                return ret_type(f"(types.ints.between {range_min} {range_max})")

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
                    subkeys, definitions, key_path, support_data
                )

                return (
                    [(subkeys.name, DefinitionType.ARRAY)],
                    support_data_list,
                    f"type-{subkeys.name}",
                )

            (def_types, support_data_list, item_nix_type) = key_type_to_nix_type(
                subkeys[0], definitions, key_path + ["*"], support_data, indent
            )
            return (def_types, support_data_list, f"types.listOf {item_nix_type}")
        case "<dictionary>":
            return dictionary_to_nix_submodule(
                payload_key["subkeys"], definitions, key_path, support_data, indent
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


def payload_key_to_option(payload_key, definitions, key_path, support_data, indent):
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
        payload_key, definitions, key_path, new_support_data, indent + "  "
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


def process_sub_keys(subkeys, definitions, key_path, support_data, indent):
    results = [
        payload_key_to_option(payload_key, definitions, key_path, support_data, indent)
        for payload_key in subkeys
        if payload_key_supports_ios(payload_key)
    ]

    def_types = [def_type for def_type, _, _ in results]
    support_data_list = [support_data_list for _, support_data_list, _ in results]
    options = [option for _, _, option in results]

    return (def_types, support_data_list, options)


def unique_by_key(pairs):
    out = {}
    for k, v in pairs:
        if k in out and out[k] != v:
            raise ValueError(f"conflict for {k!r}: {out[k]!r} != {v!r}")
        out[k] = v
    return list(out.items())


def define_definition(definitions, def_type):
    match def_type:
        case (name, DefinitionType.ARRAY):
            subkeys = definitions[name]
            (new_def_types, _, nix_type) = key_type_to_nix_type(
                subkeys[0], definitions, [], {}, ""
            )
            var_name = f"type-{name}"
            return (new_def_types, f"{var_name} = types.listOf {nix_type};")
        case _:
            raise ValueError(f"unknown definition type: {def_type}")


def define_definitions(definitions, def_types, prev_def_types=[]):
    def_types = unique_by_key(def_types)
    # check if no conflicts in prev_def_types
    unique_by_key(def_types + prev_def_types)

    def_types_and_vars = [
        define_definition(definitions, def_type) for def_type in def_types
    ]

    vars = [var for _, var in def_types_and_vars]
    new_def_types = [new_def_type for new_def_type, _ in def_types_and_vars]

    if new_def_types:
        new_def_types = list(flatten(new_def_types))
        new_vars = define_definitions(
            definitions, new_def_types, def_types + prev_def_types
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
          options = {
            enable = mkEnableOption "Enable the $payload_type profile";
            PayloadType = mkOption {
              type = types.str;
              default = "$payload_type";
            };
            PayloadIdentifier = mkOption {
              type = types.str;
              default = "$identifier";
            };
            PayloadUUID = mkOption {
              type = types.str;
            };
            PayloadVersion = mkOption {
              type = types.int;
              default = 1;
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

    definitions = profile["definitions"]
    profile = profile["document"]

    name = module_name.replace("com.apple.", "")
    payload_type = profile["payload"]["payloadtype"]

    ios_payload_keys = list(
        filter(payload_key_supports_ios, profile.get("payloadkeys", []))
    )

    global_support_data = get_support_data(profile["payload"])
    (def_types, support_data_list, options) = process_sub_keys(
        ios_payload_keys, definitions, [], global_support_data, "    "
    )

    var_def_list = define_definitions(definitions, list(flatten(def_types)))
    var_definitions = textwrap.indent("\n".join(var_def_list), "  ")
    var_definitions = "\n\n" + var_definitions if var_definitions else ""

    support_data_string = gen_support_data_string(
        support_data_list, global_support_data
    )

    return Template(textwrap.dedent(template)).substitute(
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

    for module_name, profile in profile_items[0:20]:
        module_content = profile_to_module(profile, module_name)
        write_module(module_name, module_content)
        print(f"Generated module for {module_name}")


if __name__ == "__main__":
    main()
