{ lib, ... }: {
  _class = "ios";

  options.build = {
    package = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
    };
  };
}
