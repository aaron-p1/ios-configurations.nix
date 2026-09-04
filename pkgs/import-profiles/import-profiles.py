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


def dictionary_to_nix_submodule(subkeys, definitions, indent):
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

    def_types_and_options = [
        payload_key_to_option(payload_key, definitions, "        " + indent)
        for payload_key in subkeys
        if payload_key_supports_ios(payload_key)
    ]

    def_types = [def_type for def_type, _ in def_types_and_options]
    options = [option for _, option in def_types_and_options]

    return (
        def_types,
        Template(indented_template).substitute(options="\n".join(options).strip()),
    )


def key_type_to_nix_type(payload_key, definitions, indent):
    match payload_key["type"]:
        case "<boolean>":
            return ([], "types.bool")
        case "<string>":
            if payload_key.get("format"):
                return ([], f'(types.strMatching "{payload_key["format"]}")')

            return ([], "types.str")
        case "<integer>":
            if payload_key.get("range"):
                range_min = payload_key["range"]["min"]
                range_max = payload_key["range"]["max"]
                return ([], f"(types.ints.between {range_min} {range_max})")

            return ([], "types.int")
        case "<data>":
            return ([], "plistDataType")
        case "<array>":
            subkeys = payload_key["subkeys"]
            if isinstance(subkeys, Ref):
                return ([(subkeys.name, DefinitionType.ARRAY)], f"type-{subkeys.name}")

            (def_types, item_nix_type) = key_type_to_nix_type(
                subkeys[0], definitions, indent
            )
            return (def_types, f"types.listOf {item_nix_type}")
        case "<dictionary>":
            return dictionary_to_nix_submodule(
                payload_key["subkeys"], definitions, indent
            )
        case _:
            return ([], "unknown")


def payload_key_to_option(payload_key, definitions, indent):
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

    raw_description = payload_key.get("content", "")

    width = 80 - len(indent) - 4
    wrapper = textwrap.TextWrapper(width=width)
    description = "\n".join(wrapper.fill(line) for line in raw_description.split("\n"))
    description = textwrap.indent(description, indent + "    ").strip()

    (def_types, nix_type) = key_type_to_nix_type(
        payload_key, definitions, indent + "  "
    )

    required = (
        "true" if payload_key.get("presence", "optional") == "required" else "false"
    )

    return (
        def_types,
        Template(indented_template).substitute(
            key=payload_key["key"],
            nix_type=nix_type,
            description=description,
            required=required,
        ),
    )


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
            (new_def_types, nix_type) = key_type_to_nix_type(
                subkeys[0], definitions, ""
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
    return f'"{value}"'


def get_support_data(payload, prev_data={}):
    return {
        "minIos": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("introduced", prev_data.get("minIos")),
        "maxIos": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("removed", prev_data.get("maxIos")),
        "supervised": payload.get("supportedOS", {})
        .get("iOS", {})
        .get("supervised", prev_data.get("supervised")),
    }


def gen_payload_key_support_data(payload_key, definitions, global_values, prev_keys=[]):
    support_data = get_support_data(payload_key, global_values)

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

    cur_key = payload_key.get("key", "unknown")
    key_path = ".".join([to_nix_value(k) for k in prev_keys + [cur_key]])

    cur_entry = Template(indented_template).substitute(
        key=key_path,
        min_ios=to_nix_value(support_data["minIos"]),
        max_ios=to_nix_value(support_data["maxIos"]),
        supervised=to_nix_value(support_data["supervised"]),
    )

    return [cur_entry] + get_sub_key_support_data(
        payload_key, definitions, support_data, prev_keys
    )


def get_sub_key_support_data(payload_key, definitions, global_values, prev_keys=[]):
    subkeys = payload_key.get("subkeys", [])
    if isinstance(subkeys, Ref):
        subkeys = definitions.get(subkeys.name, [])

    keys = prev_keys + [payload_key["key"]]

    if payload_key["type"] == "<array>":
        subkeys = subkeys[0].get("subkeys", [])
        sub_entries = get_payload_keys_support_data(
            subkeys, definitions, global_values, keys + ["*"]
        )
        return sub_entries

    return get_payload_keys_support_data(subkeys, definitions, global_values, keys)


def get_payload_keys_support_data(
    payload_keys, definitions, global_values, prev_keys=[]
):

    ios_payload_keys = list(filter(payload_key_supports_ios, payload_keys))

    support_data = [
        gen_payload_key_support_data(payload_key, definitions, global_values, prev_keys)
        for payload_key in ios_payload_keys
    ]

    return support_data


def gen_support_data(profile, definitions):
    global_values = get_support_data(profile["payload"])

    root_template = """
        enable = {
          minIos = $min_ios;
          maxIos = $max_ios;
          supervised = $supervised;
        };
    """

    indented_root_template = (
        textwrap.indent(textwrap.dedent(root_template), "    ").lstrip("\n").rstrip()
    )

    main_support_data_str = Template(indented_root_template).substitute(
        min_ios=to_nix_value(global_values["minIos"]),
        max_ios=to_nix_value(global_values["maxIos"]),
        supervised=to_nix_value(global_values["supervised"]),
    )

    payload_keys = profile.get("payloadkeys", [])
    support_data = get_payload_keys_support_data(
        payload_keys, definitions, global_values
    )

    return "\n".join([main_support_data_str] + list(flatten(support_data)))


def profile_to_module(profile, module_name):
    template = """
        # Generated from import-profiles.py. Do not edit.
        { lib, utils, ... }:
        let
          inherit (lib) types mkEnableOption mkOption;
          inherit (utils) mkProfileOpt plistDataType;$var_definitions
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

    def_types_and_options = [
        payload_key_to_option(payload_key, definitions, "    ")
        for payload_key in ios_payload_keys
    ]

    def_types = [def_type for def_type, _ in def_types_and_options]
    var_def_list = define_definitions(definitions, list(flatten(def_types)))
    var_definitions = textwrap.indent("\n".join(var_def_list), "  ")
    var_definitions = "\n\n" + var_definitions if var_definitions else ""

    options = [option for _, option in def_types_and_options]
    support_data_string = gen_support_data(profile, definitions)

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

    for module_name, profile in profile_items[0:4]:
        module_content = profile_to_module(profile, module_name)
        write_module(module_name, module_content)
        print(f"Generated module for {module_name}")


if __name__ == "__main__":
    main()
