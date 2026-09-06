# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures a Mail account.

    An email payload creates an email account on the device.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.mail.managed profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.mail.managed";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "ios-configurations.mail.managed";
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
    "EmailAccountDescription" = mkProfileOpt {
      type = types.str;
      description = ''
        A user-visible description of the email account, shown in
        the Mail and Settings applications.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "EmailAccountName" = mkProfileOpt {
      type = types.str;
      description = ''
        The full user name for the account. The system displays this
        name in sent messages.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "EmailAccountType" = mkProfileOpt {
      type = (
        types.enum [
          "EmailTypeIMAP"
          "EmailTypePOP"
        ]
      );
      description = ''
        Defines the protocol to use for the account.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "EmailAddress" = mkProfileOpt {
      type = types.str;
      description = ''
        The full email address for the account. If this string isn't
        present in the payload, the device prompts the user for this
        string during interactive profile installation in Settings
        or System Preferences.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IncomingMailServerAuthentication" = mkProfileOpt {
      type = (
        types.enum [
          "EmailAuthNone"
          "EmailAuthPassword"
          "EmailAuthCRAMMD5"
          "EmailAuthNTLM"
          "EmailAuthHTTPMD5"
        ]
      );
      description = ''
        The authentication scheme for incoming mail.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "IncomingMailServerHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The incoming mail server host name.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "IncomingMailServerPortNumber" = mkProfileOpt {
      type = types.int;
      description = ''
        The incoming mail server port number. If not set, the system
        uses the default port for a given protocol.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IncomingMailServerUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL for authentication on the
        incoming mail server.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IncomingMailServerUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for the email account, usually the same as the
        email address up to the "@" character. If not set and the
        account requires authentication for incoming email, the
        device prompts the user for this string during interactive
        profile installation in Settings or System Preferences.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "IncomingPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password for the incoming mail server. Only use this in
        encrypted profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OutgoingPassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password for the outgoing mail server. Only use this in
        encrypted profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OutgoingPasswordSameAsIncomingPassword" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prompts the user only once for the
        password, which it uses for both outgoing and incoming mail.

        This setting is only supported by interactive profile
        installations. Not supported by non-interactive
        installations, such as MDM on iOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OutgoingMailServerAuthentication" = mkProfileOpt {
      type = (
        types.enum [
          "EmailAuthNone"
          "EmailAuthPassword"
          "EmailAuthCRAMMD5"
          "EmailAuthNTLM"
          "EmailAuthHTTPMD5"
        ]
      );
      description = ''
        The authentication scheme for outgoing mail.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "OutgoingMailServerHostName" = mkProfileOpt {
      type = types.str;
      description = ''
        The outgoing mail server host name.

        Requires: iOS >= 4.0
      '';
      required = true;
    };
    "OutgoingMailServerPortNumber" = mkProfileOpt {
      type = types.int;
      description = ''
        The outgoing mail server port number. If not set, the system
        uses ports 25, 587, and 465, in that order.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OutgoingMailServerUseSSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL authentication on the
        outgoing mail server.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OutgoingMailServerUsername" = mkProfileOpt {
      type = types.str;
      description = ''
        The user name for the email account, usually the same as the
        email address up to the "@" character. If not set and the
        account requires authentication for outgoing email, the
        device prompts the user for this string during interactive
        profile installation in Settings or System Preferences.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PreventMove" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prevents moving messages out of this
        email account and into another account. It also prevents
        forwarding or replying from an account other than the
        recipient of the message.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "PreventAppSheet" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prevents this account from sending
        mail in any app other than the Apple Mail app.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMEEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption. The system
        ignores this key in iOS 10.0 and later.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMESigningEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME signing for this
        account.

        Requires: iOS >= 10.0
      '';
      required = false;
    };
    "SMIMESigningCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The payload UUID of the identity certificate used to sign
        messages sent from this account.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMEEncryptionEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption for this
        account.

        Requires: iOS >= 10.0
      '';
      required = false;
    };
    "SMIMEEncryptionCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the identity certificate used to decrypt
        messages sent to this account. The system attaches the
        public certificate to outgoing mail to allow the user to
        receive encrypted mail. When the user sends encrypted mail,
        the system uses the public certificate to encrypt the copy
        of the mail in their Sent mailbox.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMEEnablePerMessageSwitch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system displays the per-message encryption
        switch in the Mail Compose UI. Deprecated in iOS 12.0. Use
        `SMIMEEnableEncryptionPerMessageSwitch` instead.

        Requires: iOS >= 8.0
        Deprecated in iOS 10.0
      '';
      required = false;
    };
    "disableMailRecentsSyncing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system excludes this account from Recent
        Addresses syncing.

        Requires: iOS >= 6.0
      '';
      required = false;
    };
    "allowMailDrop" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables this account to use Mail Drop.

        Requires: iOS >= 9.2
      '';
      required = false;
    };
    "IncomingMailServerIMAPPathPrefix" = mkProfileOpt {
      type = types.str;
      description = ''
        The path prefix for the IMAP mail server.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SMIMESigningUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can turn S/MIME signing on or off in
        Settings.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMESigningCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the signing identity.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptByDefault" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption by default.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptByDefaultUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can turn encryption by default on/off,
        and encryption is on.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptionCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the S/MIME encryption
        identity, and encryption is on.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEnableEncryptionPerMessageSwitch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system displays the per-message encryption
        switch in the Mail Compose UI.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "VPNUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The VPNUUID of the per-app VPN the account uses for network
        communication. Available in iOS 14 and later.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
  };
  supportData = {
    "enable" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EmailAccountDescription" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EmailAccountName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EmailAccountType" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "EmailAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerAuthentication" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerPortNumber" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerUseSSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "IncomingPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingPasswordSameAsIncomingPassword" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingMailServerAuthentication" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingMailServerHostName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingMailServerPortNumber" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingMailServerUseSSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OutgoingMailServerUsername" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "PreventMove" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "PreventAppSheet" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEnabled" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningEnabled" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningCertificateUUID" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptionEnabled" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptionCertificateUUID" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEnablePerMessageSwitch" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "disableMailRecentsSyncing" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "allowMailDrop" = {
      minIos = "9.2";
      maxIos = null;
      supervised = false;
    };
    "IncomingMailServerIMAPPathPrefix" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningUserOverrideable" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningCertificateUUIDUserOverrideable" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptByDefault" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptByDefaultUserOverrideable" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptionCertificateUUIDUserOverrideable" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEnableEncryptionPerMessageSwitch" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "VPNUUID" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
  };
}
