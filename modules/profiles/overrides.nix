{ ... }: {
  webcontent-filter = {
    assertions = { target, cfg, ... }: [
      {
        assertion = !(target.isSupervised == false && cfg.ContentFilterUUID == null);
        message = "Profile `webcontent-filter` requires `ContentFilterUUID` on unsupervised devices.";
      }
    ];
  };
  dnsSettings-managed = {
    assertions = { cfg, ... }: [
      {
        assertion = cfg.PayloadDisplayName != null;
        message = "Profile `dnsSettings-managed` requires `PayloadDisplayName` to be set.";
      }
    ];
  };
}
