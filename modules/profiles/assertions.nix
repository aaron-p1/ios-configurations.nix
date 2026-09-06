{ lib, config, ... }:
let
  inherit (lib) optional;

  target = config.target;
  cfg = config.profiles;
in
{
  _class = "ios";

  config.profiles.assertions =
    (optional cfg.webcontent-filter.enable {
      assertion = !(target.isSupervised == false && cfg.webcontent-filter.ContentFilterUUID == null);
      message = "Profile `webcontent-filter` requires `ContentFilterUUID` on unsupervised devices.";
    })
    ++ (optional cfg.dnsSettings.managed.enable {
      assertion = cfg.dnsSettings.managed.PayloadDisplayName != null;
      message = "Profile `dnsSettings.managed` requires `PayloadDisplayName` to be set.";
    });
}
