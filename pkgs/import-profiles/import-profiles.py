import os
import textwrap
from string import Template

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


def extract_profiles(tarball_bytes):
    import io
    import sys
    import tarfile
    from pathlib import Path

    import yaml

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
            parsed_yaml = yaml.safe_load(handle.read().decode("utf-8"))
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


def payload_key_supports_ios(payload_key):
    ios_version = payload_key.get("supportedOS", {}).get("iOS", {}).get("introduced")
    return ios_version not in (None, "n/a")


def payload_key_type_to_nix_type(payload_key):
    match payload_key["type"]:
        case "<boolean>":
            return "types.bool"
        case "<string>":
            return "types.str"
        case "<array>":
            items_type = payload_key.get("subkeys", [{}])[0].get("type")
            if items_type is None:
                return "list"
            item_nix_type = payload_key_type_to_nix_type({"type": items_type})
            return f"types.listOf {item_nix_type}"
        case _:
            return "unknown"


def payload_key_to_option(payload_key):
    template = """
        "$key" = mkProfileOpt {
          type = $nix_type;
          description = ''
            $description
          '';
        };
    """

    indented_template = textwrap.indent(textwrap.dedent(template), "    ")

    description = textwrap.fill(
        payload_key.get("content", ""), width=72, subsequent_indent="        "
    )

    return Template(indented_template).substitute(
        key=payload_key["key"],
        nix_type=payload_key_type_to_nix_type(payload_key),
        description=description,
    )


def profile_to_module(profile, module_name):
    name = module_name.replace("com.apple.", "")
    payload_type = profile["payload"]["payloadtype"]

    options = [
        payload_key_to_option(payload_key)
        for payload_key in profile.get("payloadkeys", [])
        if payload_key_supports_ios(payload_key)
    ]

    template = """
        # Generated from import-profiles.py. Do not edit.
        { lib, utils, ... }:
        let
          inherit (lib) types mkOption;
          inherit (utils) mkProfileOpt;
        in
        {
          options = {
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
        }
    """.removeprefix(
        "\n"
    )

    return Template(textwrap.dedent(template)).substitute(
        payload_type=payload_type,
        identifier=f"{PROFILE_IDENTIFIER_PREFIX}{name}",
        options="\n".join(options).strip(),
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
        if profile_supports_ios(profile)
    ]

    print(f"Found {len(profile_items)} profiles for iOS.")

    for module_name, profile in profile_items[:1]:
        module_content = profile_to_module(profile, module_name)
        write_module(module_name, module_content)
        print(f"Generated module for {module_name}")


if __name__ == "__main__":
    main()
