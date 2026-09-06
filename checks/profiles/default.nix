{
  eval,
  pkgs,
  lib,
  testUtils,
}@testArgs:
let
  inherit (testUtils) assertContains assertDoesNotContain;
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
    assert assertContains "PayloadDisplayName" plist;
    assert assertContains "PayloadIdentifier" plist;
    assert assertContains "<string>ios-configurations</string>" plist;
    assert assertContains "PayloadUUID" plist;
    assert assertContains "PayloadType" plist;
    assert assertContains "PayloadVersion" plist;
    pkgs.runCommand "generates-boilerplate" { } "touch $out";

  does-not-gen-disabled-profile =
    let
      config.profiles.setupAssistant.managed.enable = false;
      plist = evalGetPlist config;
    in
    assert assertDoesNotContain "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "does-not-gen-disabled-profile" { } "touch $out";

  can-gen-enabled-empty-profile =
    let
      config.profiles.setupAssistant.managed.enable = true;
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.SetupAssistant.managed</string>" plist;
    pkgs.runCommand "can-gen-enabled-empty-profile" { } "touch $out";

  does-not-set-empty-props =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert assertDoesNotContain "SkipSetupItems" plist;
    pkgs.runCommand "does-not-set-empty-props" { } "touch $out";

  empty-list-counts-as-empty-prop =
    let
      config.profiles.setupAssistant.managed = {
        enable = true;
        SkipSetupItems = [ ];
      };
      plist = evalGetPlist config;
    in
    assert assertDoesNotContain "SkipSetupItems" plist;
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
    assert assertContains "        <key>PayloadType</key>" plist;
    assert assertContains "<string>com.apple.SetupAssistant.managed</string>" plist;
    assert assertContains "        <key>PayloadVersion</key>" plist;
    assert assertContains "        <key>PayloadIdentifier</key>" plist;
    assert assertContains "<string>ios-configurations.setupAssistant.managed</string>" plist;
    assert assertContains "        <key>PayloadUUID</key>" plist;
    assert assertContains "<string>SkipValue</string>" plist;
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
    assert assertContains "<string>com.apple.airplay</string>" plist;
    assert assertContains "<string>ios-configurations.airplay</string>" plist;
    assert assertContains "<string>00:11:22:33:44:55</string>" plist;
    assert assertContains "<string>My AirPlay Device</string>" plist;
    assert assertContains "<string>My AirPlay Device Password</string>" plist;
    assert assertContains "<string>MyPassword</string>" plist;
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
    assert assertContains "<string>com.apple.airprint</string>" plist;
    assert assertContains "<string>ios-configurations.airprint</string>" plist;
    assert assertContains "<string>127.0.0.1</string>" plist;
    assert assertContains "<string>ipp/print</string>" plist;
    assert assertContains "<integer>631</integer>" plist;
    assert assertContains "<true/>" plist;
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
    assert assertContains "<string>com.apple.apn.managed</string>" plist;
    assert assertContains "<string>ios-configurations.apn.managed</string>" plist;
    assert assertContains "<string>internet</string>" plist;
    assert assertContains "<data>" plist;
    assert assertContains "cGFzc3dvcmQ=" plist;
    assert assertContains "<integer>8080</integer>" plist;
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
    assert assertContains "<string>com.apple.app.lock</string>" plist;
    assert assertContains "<string>ios-configurations.app.lock</string>" plist;
    assert assertContains "<key>App</key>" plist;
    assert assertContains "<key>Identifier</key>" plist;
    assert assertContains "<key>EnableZoom</key>" plist;
    pkgs.runCommand "can-gen-app-lock" { } "touch $out";

  can-gen-applicationaccess =
    let
      config.profiles.applicationaccess = {
        enable = true;
        allowAccountModification = true;
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.applicationaccess</string>" plist;
    assert assertContains "<string>ios-configurations.applicationaccess</string>" plist;
    assert assertContains "<key>allowAccountModification</key>" plist;
    pkgs.runCommand "can-gen-applicationaccess" { } "touch $out";

  can-gen-caldav-account =
    let
      config.profiles.caldav.account = {
        enable = true;
        CalDAVHostName = "caldav.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.caldav.account</string>" plist;
    assert assertContains "<string>ios-configurations.caldav.account</string>" plist;
    assert assertContains "<key>CalDAVHostName</key>" plist;
    pkgs.runCommand "can-gen-caldav-account" { } "touch $out";

  can-gen-carddav-account =
    let
      config.profiles.carddav.account = {
        enable = true;
        CardDAVHostName = "carddav.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.carddav.account</string>" plist;
    assert assertContains "<string>ios-configurations.carddav.account</string>" plist;
    assert assertContains "<key>CardDAVHostName</key>" plist;
    pkgs.runCommand "can-gen-carddav-account" { } "touch $out";

  can-gen-cellular =
    let
      config.profiles.cellular = {
        enable = true;
        AttachAPN.Name = "internet";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.cellular</string>" plist;
    assert assertContains "<string>ios-configurations.cellular</string>" plist;
    assert assertContains "<key>AttachAPN</key>" plist;
    assert assertContains "<key>Name</key>" plist;
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
    assert assertContains "<string>com.apple.cellularprivatenetwork.managed</string>" plist;
    assert assertContains "<string>ios-configurations.cellularprivatenetwork.managed</string>" plist;
    assert assertContains "<key>DataSetName</key>" plist;
    assert assertContains "<key>VersionNumber</key>" plist;
    pkgs.runCommand "can-gen-cellularprivatenetwork-managed" { } "touch $out";

  can-gen-declarations =
    let
      config.profiles.declarations = {
        enable = true;
        Declarations = [ "password" ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.declarations</string>" plist;
    assert assertContains "<string>ios-configurations.declarations</string>" plist;
    assert assertContains "<key>Declarations</key>" plist;
    pkgs.runCommand "can-gen-declarations" { } "touch $out";

  can-gen-dnsProxy-managed =
    let
      config.profiles.dnsProxy.managed = {
        enable = true;
        AppBundleIdentifier = "com.example.dnsproxy";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.dnsProxy.managed</string>" plist;
    assert assertContains "<string>ios-configurations.dnsProxy.managed</string>" plist;
    assert assertContains "<key>AppBundleIdentifier</key>" plist;
    pkgs.runCommand "can-gen-dnsProxy-managed" { } "touch $out";

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
    assert assertContains "<string>com.apple.dnsSettings.managed</string>" plist;
    assert assertContains "<string>ios-configurations.dnsSettings.managed</string>" plist;
    assert assertContains "<key>DNSSettings</key>" plist;
    pkgs.runCommand "can-gen-dnsSettings-managed" { } "touch $out";

  can-gen-domains =
    let
      config.profiles.domains = {
        enable = true;
        EmailDomains = [ "example.com" ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.domains</string>" plist;
    assert assertContains "<string>ios-configurations.domains</string>" plist;
    assert assertContains "<key>EmailDomains</key>" plist;
    pkgs.runCommand "can-gen-domains" { } "touch $out";

  can-gen-eas-account =
    let
      config.profiles.eas.account = {
        enable = true;
        EmailAddress = "test@example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.eas.account</string>" plist;
    assert assertContains "<string>ios-configurations.eas.account</string>" plist;
    assert assertContains "<key>EmailAddress</key>" plist;
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
    assert assertContains "<string>com.apple.education</string>" plist;
    assert assertContains "<string>ios-configurations.education</string>" plist;
    assert assertContains "<key>OrganizationUUID</key>" plist;
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
    assert assertContains "<string>com.apple.extensiblesso</string>" plist;
    assert assertContains "<string>ios-configurations.extensiblesso-kerberos</string>" plist;
    assert assertContains "<key>ExtensionIdentifier</key>" plist;
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
    assert assertContains "<string>com.apple.extensiblesso</string>" plist;
    assert assertContains "<string>ios-configurations.extensiblesso</string>" plist;
    assert assertContains "<key>ExtensionIdentifier</key>" plist;
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
    assert assertContains "<string>com.apple.font</string>" plist;
    assert assertContains "<string>ios-configurations.font</string>" plist;
    assert assertContains "<key>Name</key>" plist;
    pkgs.runCommand "can-gen-font" { } "touch $out";

  can-gen-globalethernet-managed =
    let
      config.profiles.globalethernet.managed = {
        enable = true;
        settings.EthernetMACAddress = "00:11:22:33:44:55";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.globalethernet.managed</string>" plist;
    assert assertContains "<string>ios-configurations.globalethernet.managed</string>" plist;
    assert assertContains "<key>EthernetMACAddress</key>" plist;
    pkgs.runCommand "can-gen-globalethernet-managed" { } "touch $out";

  can-gen-google-oauth =
    let
      config.profiles.google-oauth = {
        enable = true;
        EmailAddress = "test@example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.google-oauth</string>" plist;
    assert assertContains "<string>ios-configurations.google-oauth</string>" plist;
    assert assertContains "<key>EmailAddress</key>" plist;
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
    assert assertContains "<string>com.apple.homescreenlayout</string>" plist;
    assert assertContains "<string>ios-configurations.homescreenlayout</string>" plist;
    assert assertContains "<key>Dock</key>" plist;
    pkgs.runCommand "can-gen-homescreenlayout" { } "touch $out";

  stops-recursion-at-right-levels =
    let
      subOpts = opt: opt.type.getSubOptions [ ];
      resolveNullOrListOf = type: type.nestedTypes.elemType.nestedTypes.elemType;

      opts = subOpts (eval { }).options.profiles.homescreenlayout;
      # one recursion for dock and one for folders
      dockAny = (subOpts (subOpts opts.Dock).Pages).Pages.type;
      # first Pages is not the same as other Pages
      pagesAny = (subOpts (subOpts opts.Pages).Pages).Pages.type;
    in
    assert resolveNullOrListOf dockAny == lib.types.anything;
    assert resolveNullOrListOf pagesAny == lib.types.anything;
    pkgs.runCommand "stops-recursion-at-right-levels" { } "touch $out";

  can-gen-ldap-account =
    let
      config.profiles.ldap.account = {
        enable = true;
        LDAPAccountHostName = "ldap.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.ldap.account</string>" plist;
    assert assertContains "<string>ios-configurations.ldap.account</string>" plist;
    assert assertContains "<key>LDAPAccountHostName</key>" plist;
    pkgs.runCommand "can-gen-ldap-account" { } "touch $out";

  can-gen-mail-managed =
    let
      config.profiles.mail.managed = {
        enable = true;
        EmailAccountType = "EmailTypeIMAP";
        IncomingMailServerAuthentication = "EmailAuthPassword";
        IncomingMailServerHostName = "imap.example.com";
        OutgoingMailServerAuthentication = "EmailAuthPassword";
        OutgoingMailServerHostName = "smtp.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.mail.managed</string>" plist;
    assert assertContains "<string>ios-configurations.mail.managed</string>" plist;
    assert assertContains "<key>IncomingMailServerHostName</key>" plist;
    pkgs.runCommand "can-gen-mail-managed" { } "touch $out";

  can-gen-mdm =
    let
      config.profiles.mdm = {
        enable = true;
        IdentityCertificateUUID = "b57e9a8d-b89f-420a-922e-99775a23a4ac";
        Topic = "com.apple.mgmt.test";
        ServerURL = "https://example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.mdm</string>" plist;
    assert assertContains "<string>ios-configurations.mdm</string>" plist;
    assert assertContains "<key>IdentityCertificateUUID</key>" plist;
    pkgs.runCommand "can-gen-mdm" { } "touch $out";

  can-gen-mobiledevice-passwordpolicy =
    let
      config.profiles.mobiledevice.passwordpolicy = {
        enable = true;
        allowSimple = false;
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.mobiledevice.passwordpolicy</string>" plist;
    assert assertContains "<string>ios-configurations.mobiledevice.passwordpolicy</string>" plist;
    assert assertContains "<key>allowSimple</key>" plist;
    pkgs.runCommand "can-gen-mobiledevice-passwordpolicy" { } "touch $out";

  can-networkusagerules =
    let
      config.profiles.networkusagerules = {
        enable = true;
        ApplicationRules = [
          {
            AppIdentifierMatches = [ "com.example.app" ];
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.networkusagerules</string>" plist;
    assert assertContains "<string>ios-configurations.networkusagerules</string>" plist;
    assert assertContains "<key>ApplicationRules</key>" plist;
    pkgs.runCommand "can-gen-networkusagerules" { } "touch $out";

  can-gen-notificationsettings =
    let
      config.profiles.notificationsettings = {
        enable = true;
        NotificationSettings = [ { BundleIdentifier = "com.example.app"; } ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.notificationsettings</string>" plist;
    assert assertContains "<string>ios-configurations.notificationsettings</string>" plist;
    assert assertContains "<key>NotificationSettings</key>" plist;
    pkgs.runCommand "can-gen-notificationsettings" { } "touch $out";

  can-gen-osxserver-account =
    let
      config.profiles.osxserver.account = {
        enable = true;
        HostName = "server.example.com";
        UserName = "user";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.osxserver.account</string>" plist;
    assert assertContains "<string>ios-configurations.osxserver.account</string>" plist;
    assert assertContains "<key>HostName</key>" plist;
    pkgs.runCommand "can-gen-osxserver-account" { } "touch $out";

  can-gen-profileRemovalPassword =
    let
      config.profiles.profileRemovalPassword = {
        enable = true;
        RemovalPassword = "password";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.profileRemovalPassword</string>" plist;
    assert assertContains "<string>ios-configurations.profileRemovalPassword</string>" plist;
    assert assertContains "<key>RemovalPassword</key>" plist;
    pkgs.runCommand "can-gen-profileRemovalPassword" { } "touch $out";

  can-gen-proxy-http-global =
    let
      config.profiles.proxy.http.global = {
        enable = true;
        ProxyType = "Auto";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.proxy.http.global</string>" plist;
    assert assertContains "<string>ios-configurations.proxy.http.global</string>" plist;
    assert assertContains "<key>ProxyType</key>" plist;
    pkgs.runCommand "can-gen-proxy-http-global" { } "touch $out";

  can-gen-relay-managed =
    let
      config.profiles.relay.managed = {
        enable = true;
        Relays = [ { HTTP3RelayURL = "https://relay.example.com"; } ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.relay.managed</string>" plist;
    assert assertContains "<string>ios-configurations.relay.managed</string>" plist;
    assert assertContains "<key>Relays</key>" plist;
    pkgs.runCommand "can-gen-relay-managed" { } "touch $out";

  can-gen-security-acme =
    let
      config.profiles.security.acme = {
        enable = true;
        DirectoryURL = "https://acme.example.com";
        ClientIdentifier = "client-id";
        KeySize = 2048;
        KeyType = "RSA";
        HardwareBound = false;
        Subject = [
          [
            [
              "C"
              "US"
            ]
          ]
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.acme</string>" plist;
    assert assertContains "<string>ios-configurations.security.acme</string>" plist;
    assert assertContains "<key>DirectoryURL</key>" plist;
    pkgs.runCommand "can-gen-security-acme" { } "touch $out";

  can-gen-security-certificaterevocation =
    let
      config.profiles.security.certificaterevocation = {
        enable = true;
        EnabledForCerts = [
          {
            Algorithm = "sha256";
            Hash = "plist";
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.certificaterevocation</string>" plist;
    assert assertContains "<string>ios-configurations.security.certificaterevocation</string>" plist;
    assert assertContains "<key>EnabledForCerts</key>" plist;
    pkgs.runCommand "can-gen-security-certificaterevocation" { } "touch $out";

  can-gen-security-certificatetransparency =
    let
      config.profiles.security.certificatetransparency = {
        enable = true;
        DisabledForCerts = [
          {
            Algorithm = "sha256";
            Hash = "plist";
          }
        ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.certificatetransparency</string>" plist;
    assert assertContains "<string>ios-configurations.security.certificatetransparency</string>" plist;
    assert assertContains "<key>DisabledForCerts</key>" plist;
    pkgs.runCommand "can-gen-security-certificatetransparency" { } "touch $out";

  can-gen-security-pem =
    let
      config.profiles.security.pem = {
        enable = true;
        PayloadCertificateFileName = "cert.pem";
        PayloadContent = "pem-content";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.pem</string>" plist;
    assert assertContains "<string>ios-configurations.security.pem</string>" plist;
    assert assertContains "<key>PayloadCertificateFileName</key>" plist;
    pkgs.runCommand "can-gen-security-pem" { } "touch $out";

  can-gen-security-pkcs1 =
    let
      config.profiles.security.pkcs1 = {
        enable = true;
        PayloadContent = "pkcs1-content";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.pkcs1</string>" plist;
    assert assertContains "<string>ios-configurations.security.pkcs1</string>" plist;
    assert assertContains "<key>PayloadContent</key>" plist;
    pkgs.runCommand "can-gen-security-pkcs1" { } "touch $out";

  can-gen-security-pkcs12 =
    let
      config.profiles.security.pkcs12 = {
        enable = true;
        PayloadContent = "pkcs12-content";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.pkcs12</string>" plist;
    assert assertContains "<string>ios-configurations.security.pkcs12</string>" plist;
    assert assertContains "<key>PayloadContent</key>" plist;
    pkgs.runCommand "can-gen-security-pkcs12" { } "touch $out";

  can-gen-security-root =
    let
      config.profiles.security.root = {
        enable = true;
        PayloadContent = "root-content";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.root</string>" plist;
    assert assertContains "<string>ios-configurations.security.root</string>" plist;
    assert assertContains "<key>PayloadContent</key>" plist;
    pkgs.runCommand "can-gen-security-root" { } "touch $out";

  can-gen-security-scep =
    let
      config.profiles.security.scep = {
        enable = true;
        PayloadContent.URL = "https://scep.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.security.scep</string>" plist;
    assert assertContains "<string>ios-configurations.security.scep</string>" plist;
    assert assertContains "<key>PayloadContent</key>" plist;
    pkgs.runCommand "can-gen-security-scep" { } "touch $out";

  can-gen-shareddeviceconfiguration =
    let
      config.profiles.shareddeviceconfiguration = {
        enable = true;
        AssetTagInformation = "asset-tag";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.shareddeviceconfiguration</string>" plist;
    assert assertContains "<string>ios-configurations.shareddeviceconfiguration</string>" plist;
    assert assertContains "<key>AssetTagInformation</key>" plist;
    pkgs.runCommand "can-gen-shareddeviceconfiguration" { } "touch $out";

  can-gen-sso =
    let
      config.profiles.sso = {
        enable = true;
        Name = "sso-name";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.sso</string>" plist;
    assert assertContains "<string>ios-configurations.sso</string>" plist;
    assert assertContains "<key>Name</key>" plist;
    pkgs.runCommand "can-gen-sso" { } "touch $out";

  can-gen-subscribedcalendar-account =
    let
      config.profiles.subscribedcalendar.account = {
        enable = true;
        SubCalAccountHostName = "subcal.example.com";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.subscribedcalendar.account</string>" plist;
    assert assertContains "<string>ios-configurations.subscribedcalendar.account</string>" plist;
    assert assertContains "<key>SubCalAccountHostName</key>" plist;
    pkgs.runCommand "can-gen-subscribedcalendar-account" { } "touch $out";

  can-gen-tvremote =
    let
      config.profiles.tvremote = {
        enable = true;
        AllowedTVs = [ { TVDeviceID = "00:11:22:33:44:55"; } ];
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.tvremote</string>" plist;
    assert assertContains "<string>ios-configurations.tvremote</string>" plist;
    assert assertContains "<key>AllowedTVs</key>" plist;
    pkgs.runCommand "can-gen-tvremote" { } "touch $out";

  can-gen-vpn-managed-applayer =
    let
      config.profiles.vpn.managed-applayer = {
        enable = true;
        VPNUUID = "fdeb9882-f3e1-4d13-8e03-b495eec1e5b7";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.vpn.managed.applayer</string>" plist;
    assert assertContains "<string>ios-configurations.vpn.managed-applayer</string>" plist;
    assert assertContains "<key>VPNUUID</key>" plist;
    pkgs.runCommand "can-gen-vpn-managed-applayer" { } "touch $out";

  can-gen-vpn-managed =
    let
      config.profiles.vpn.managed = {
        enable = true;
        VPNType = "L2TP";
        UserDefinedName = "My VPN";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.vpn.managed</string>" plist;
    assert assertContains "<string>ios-configurations.vpn.managed</string>" plist;
    assert assertContains "<key>VPNType</key>" plist;
    pkgs.runCommand "can-gen-vpn-managed" { } "touch $out";

  can-gen-webclip-managed =
    let
      config.profiles.webClip.managed = {
        enable = true;
        URL = "https://example.com";
        Label = "Example Web Clip";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.webClip.managed</string>" plist;
    assert assertContains "<string>ios-configurations.webClip.managed</string>" plist;
    assert assertContains "<key>URL</key>" plist;
    pkgs.runCommand "can-gen-webClip-managed" { } "touch $out";

  can-gen-webcontent-filter =
    let
      config.profiles.webcontent-filter = {
        enable = true;
        FilterType = "BuiltIn";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.webcontent-filter</string>" plist;
    assert assertContains "<string>ios-configurations.webcontent-filter</string>" plist;
    assert assertContains "<key>FilterType</key>" plist;
    pkgs.runCommand "can-gen-webcontent-filter" { } "touch $out";

  can-gen-wifi-managed =
    let
      config.profiles.wifi.managed = {
        enable = true;
        SSID_STR = "MyWiFi";
      };
      plist = evalGetPlist config;
    in
    assert assertContains "<string>com.apple.wifi.managed</string>" plist;
    assert assertContains "<string>ios-configurations.wifi.managed</string>" plist;
    assert assertContains "<key>SSID_STR</key>" plist;
    pkgs.runCommand "can-gen-wifi-managed" { } "touch $out";
}
// (import ./assertions.nix testArgs)
// (import ./types.nix testArgs)
