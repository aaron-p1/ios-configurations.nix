{
  eval,
  pkgs,
  lib,
}:
let
  inherit (lib) hasInfix;
  evalGetPlist = config: (eval { inherit config; }).config.profiles.plist;
in
{
  valid-xml =
    pkgs.runCommand "valid-xml"
      {
        buildInputs = [ pkgs.libxml2 ];
        content = (eval { }).config.profiles.plist;
      }
      ''
        echo "$content" > profiles.plist
        xmllint --noout profiles.plist

        touch $out
      '';

  generates-boilerplate =
    let
      plist = evalGetPlist { };
    in
    assert hasInfix "PayloadContent" plist;
    assert hasInfix "PayloadDisplayName" plist;
    assert hasInfix "PayloadIdentifier" plist;
    assert hasInfix "<string>com.example.manage-ios</string>" plist;
    assert hasInfix "PayloadUUID" plist;
    assert hasInfix "PayloadType" plist;
    assert hasInfix "PayloadVersion" plist;
    pkgs.runCommand "generates-boilerplate" { } "touch $out";

  does-not-gen-disabled-profile =
    let
      config.profiles.setupAssistant.managed.enable = false;
      plist = evalGetPlist config;
    in
    assert !hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "does-not-gen-disabled-profile" { } "touch $out";

  can-gen-enabled-empty-profile =
    let
      config.profiles.setupAssistant.managed.enable = true;
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-enabled-empty-profile" { } "touch $out";

  does-not-set-empty-props =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert !hasInfix "SkipSetupItems" plist;
    pkgs.runCommand "does-not-set-empty-props" { } "touch $out";

  empty-list-counts-as-empty-prop =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = evalGetPlist config;
    in
    assert !hasInfix "SkipSetupItems" plist;
    pkgs.runCommand "empty-list-counts-as-empty-prop" { } "touch $out";

  can-gen-setupassistant-managed =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ "SkipValue" ];
      };
      plist = evalGetPlist config;
    in
    # test with indentation to not match the global keys
    assert hasInfix "        <key>PayloadType</key>" plist;
    assert hasInfix "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert hasInfix "        <key>PayloadVersion</key>" plist;
    assert hasInfix "        <key>PayloadIdentifier</key>" plist;
    assert hasInfix "<string>com.example.manage-ios.SetupAssistant.managed</string>" plist;
    assert hasInfix "        <key>PayloadUUID</key>" plist;
    assert hasInfix "<string>SkipValue</string>" plist;
    pkgs.runCommand "can-gen-setupassistant-managed" { } "touch $out";

  can-gen-airplay =
    let
      config.profiles.airplay = {
        enable = true;
        AllowList = [
          {
            DeviceID = "00:11:22:33:44:55";
            DeviceName = "My AirPlay Device";
          }
        ];
        Passwords = [
          {
            DeviceName = "My AirPlay Device Password";
            Password = "MyPassword";
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.airplay</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.airplay</string>" plist;
    assert hasInfix "<string>00:11:22:33:44:55</string>" plist;
    assert hasInfix "<string>My AirPlay Device</string>" plist;
    assert hasInfix "<string>My AirPlay Device Password</string>" plist;
    assert hasInfix "<string>MyPassword</string>" plist;
    pkgs.runCommand "can-gen-airplay" { } "touch $out";

  can-gen-airprint =
    let
      config.profiles.airprint = {
        enable = true;
        AirPrint = [
          {
            IPAddress = "127.0.0.1";
            ResourcePath = "ipp/print";
            Port = 631;
            ForceTLS = true;
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.airprint</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.airprint</string>" plist;
    assert hasInfix "<string>127.0.0.1</string>" plist;
    assert hasInfix "<string>ipp/print</string>" plist;
    assert hasInfix "<integer>631</integer>" plist;
    assert hasInfix "<true/>" plist;
    pkgs.runCommand "can-gen-airprint" { } "touch $out";

  can-gen-apn-managed =
    let
      config.profiles.apn.managed = {
        enable = true;
        DefaultsData.apns = [
          {
            apn = "internet";
            username = "user";
            password = "password";
            proxy = "proxy.example.com";
            proxyPort = 8080;
          }
        ];
        DefaultsDomainName = "com.apple.managedCarrier";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.apn.managed</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.apn.managed</string>" plist;
    assert hasInfix "<string>internet</string>" plist;
    assert hasInfix "<data>" plist;
    assert hasInfix "cGFzc3dvcmQ=" plist;
    assert hasInfix "<integer>8080</integer>" plist;
    pkgs.runCommand "can-gen-apn-managed" { } "touch $out";

  can-gen-app-lock =
    let
      config.profiles.app.lock = {
        enable = true;
        App = {
          Identifier = "com.apple.app.lock";
          Options.EnableZoom = true;
        };
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.app.lock</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.app.lock</string>" plist;
    assert hasInfix "<key>App</key>" plist;
    assert hasInfix "<key>Identifier</key>" plist;
    assert hasInfix "<key>EnableZoom</key>" plist;
    pkgs.runCommand "can-gen-app-lock" { } "touch $out";

  can-gen-applicationaccess =
    let
      config.profiles.applicationaccess = {
        enable = true;
        allowAccountModification = true;
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.applicationaccess</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.applicationaccess</string>" plist;
    assert hasInfix "<key>allowAccountModification</key>" plist;
    pkgs.runCommand "can-gen-applicationaccess" { } "touch $out";

  can-gen-caldav-account =
    let
      config.profiles.caldav.account = {
        enable = true;
        CalDAVHostName = "caldav.example.com";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.caldav.account</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.caldav.account</string>" plist;
    assert hasInfix "<key>CalDAVHostName</key>" plist;
    pkgs.runCommand "can-gen-caldav-account" { } "touch $out";

  can-gen-carddav-account =
    let
      config.profiles.carddav.account = {
        enable = true;
        CardDAVHostName = "carddav.example.com";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.carddav.account</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.carddav.account</string>" plist;
    assert hasInfix "<key>CardDAVHostName</key>" plist;
    pkgs.runCommand "can-gen-carddav-account" { } "touch $out";

  can-gen-cellular =
    let
      config.profiles.cellular = {
        enable = true;
        AttachAPN.Name = "internet";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.cellular</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.cellular</string>" plist;
    assert hasInfix "<key>AttachAPN</key>" plist;
    assert hasInfix "<key>Name</key>" plist;
    pkgs.runCommand "can-gen-cellular" { } "touch $out";

  can-gen-cellularprivatenetwork-managed =
    let
      config.profiles.cellularprivatenetwork.managed = {
        enable = true;
        DataSetName = "Name";
        VersionNumber = "1.0";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.cellularprivatenetwork.managed</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.cellularprivatenetwork.managed</string>" plist;
    assert hasInfix "<key>DataSetName</key>" plist;
    assert hasInfix "<key>VersionNumber</key>" plist;
    pkgs.runCommand "can-gen-cellularprivatenetwork.managed" { } "touch $out";

  can-gen-declarations =
    let
      config.profiles.declarations = {
        enable = true;
        Declarations = [ "password" ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.declarations</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.declarations</string>" plist;
    assert hasInfix "<key>Declarations</key>" plist;
    pkgs.runCommand "can-gen-declarations" { } "touch $out";

  can-gen-dnsProxy-managed =
    let
      config.profiles.dnsProxy.managed = {
        enable = true;
        AppBundleIdentifier = "com.example.dnsproxy";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.dnsProxy.managed</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.dnsProxy.managed</string>" plist;
    assert hasInfix "<key>AppBundleIdentifier</key>" plist;
    pkgs.runCommand "can-gen-dnsProxy.managed" { } "touch $out";

  can-gen-dnsSettings-managed =
    let
      config.profiles.dnsSettings.managed = {
        enable = true;
        DNSSettings = {
          DNSProtocol = "HTTPS";
        };
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.dnsSettings.managed</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.dnsSettings.managed</string>" plist;
    assert hasInfix "<key>DNSSettings</key>" plist;
    pkgs.runCommand "can-gen-dnsSettings.managed" { } "touch $out";

  can-gen-domains =
    let
      config.profiles.domains = {
        enable = true;
        EmailDomains = [ "example.com" ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.domains</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.domains</string>" plist;
    assert hasInfix "<key>EmailDomains</key>" plist;
    pkgs.runCommand "can-gen-domains" { } "touch $out";

  can-gen-eas-account =
    let
      config.profiles.eas.account = {
        enable = true;
        EmailAddress = "test@example.com";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.eas.account</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.eas.account</string>" plist;
    assert hasInfix "<key>EmailAddress</key>" plist;
    pkgs.runCommand "can-gen-eas-account" { } "touch $out";

  can-gen-education =
    let
      config.profiles.education = {
        enable = true;
        OrganizationUUID = "208b6b0f-369c-4305-a06a-598005615ae5";
        OrganizationName = "Example School";
        UserIdentifier = "identifier";
        Groups = [ ];
        Users = [ ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.education</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.education</string>" plist;
    assert hasInfix "<key>OrganizationUUID</key>" plist;
    pkgs.runCommand "can-gen-education" { } "touch $out";

  can-gen-extensiblesso-kerberos =
    let
      config.profiles.extensiblesso-kerberos = {
        enable = true;
        ExtensionIdentifier = "com.apple.AppSSOKerberos.KerberosExtension";
        TeamIdentifier = "apple";
        Type = "Credential";
        Realm = "realm";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.extensiblesso</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.extensiblesso(kerberos)</string>" plist;
    assert hasInfix "<key>ExtensionIdentifier</key>" plist;
    pkgs.runCommand "can-gen-extensionsso-kerberos" { } "touch $out";

  can-gen-extensiblesso =
    let
      config.profiles.extensiblesso = {
        enable = true;
        ExtensionIdentifier = "com.example.ssoextension";
        Type = "Redirect";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.extensiblesso</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.extensiblesso</string>" plist;
    assert hasInfix "<key>ExtensionIdentifier</key>" plist;
    pkgs.runCommand "can-gen-extensionsso" { } "touch $out";

  can-gen-font =
    let
      config.profiles.font = {
        enable = true;
        Name = "ExampleFont";
        Font = "<font content>";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.font</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.font</string>" plist;
    assert hasInfix "<key>Name</key>" plist;
    pkgs.runCommand "can-gen-font" { } "touch $out";

  can-gen-globalethernet-managed =
    let
      config.profiles.globalethernet.managed = {
        enable = true;
        settings.EthernetMACAddress = "00:11:22:33:44:55";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.globalethernet.managed</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.globalethernet.managed</string>" plist;
    assert hasInfix "<key>EthernetMACAddress</key>" plist;
    pkgs.runCommand "can-gen-globalethernet.managed" { } "touch $out";

  can-gen-google-oauth =
    let
      config.profiles.google-oauth = {
        enable = true;
        EmailAddress = "test@example.com";
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.google-oauth</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.google-oauth</string>" plist;
    assert hasInfix "<key>EmailAddress</key>" plist;
    pkgs.runCommand "can-gen-google-oauth" { } "touch $out";

  can-gen-homescreenlayout =
    let
      config.profiles.homescreenlayout = {
        enable = true;
        Dock = [ { Type = "Folder"; } ];
        Pages = [ ];
      };
      plist = evalGetPlist config;
    in
    assert hasInfix "<string>com.apple.homescreenlayout</string>" plist;
    assert hasInfix "<string>com.example.manage-ios.homescreenlayout</string>" plist;
    assert hasInfix "<key>Dock</key>" plist;
    pkgs.runCommand "can-gen-homescreenlayout" { } "touch $out";

  stops-recursion-at-right-levels =
    let
      subOpts = opt: opt.type.getSubOptions [ ];
      resolveNullOrListOf = type: type.nestedTypes.elemType.nestedTypes.elemType;

      opts = (eval { }).options.profiles.homescreenlayout;
      # one recursion for dock and one for folders
      dockAny = (subOpts (subOpts opts.Dock).Pages).Pages.type;
      # first Pages is not the same as other Pages
      pagesAny = (subOpts (subOpts opts.Pages).Pages).Pages.type;
    in
    assert resolveNullOrListOf dockAny == lib.types.anything;
    assert resolveNullOrListOf pagesAny == lib.types.anything;
    pkgs.runCommand "stops-recursion-at-right-levels" { } "touch $out";

}
// (import ./assertions.nix { inherit eval pkgs lib; })
// (import ./types.nix { inherit eval pkgs lib; })
