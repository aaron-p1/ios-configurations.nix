# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures Exchange ActiveSync accounts.

    This payload configures an Exchange Active Sync account on an iOS device for
    Mail, Contacts, Calendars, Reminders, and Notes.
    Updating this payload overrides any settings that the user customized, such as
    EnableMail/Contacts/Calendars/Reminders/Notes and MailNumberOfPastDaysToSync.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.eas.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.eas.account";
      description = "The payload type for this profile";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
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
    "EmailAddress" = mkProfileOpt {
      type = types.str;
      description = ''
        The full email address for the account. If not present in
        the payload, the device prompts for this string during
        profile installation.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Host" = mkProfileOpt {
      type = types.str;
      description = ''
        The Exchange server host name or IP address.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL for authentication.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "OAuth" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, enables OAuth for authentication. If enabled,
        don't specify a password.

        Available only in iOS 12.0 and above.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "UserName" = mkProfileOpt {
      type = types.str;
      description = ''
        This user name for this Exchange account. Required for
        noninteractive installations like MDM in iOS.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The password of the account. Use only with encrypted
        profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "Certificate" = mkProfileOpt {
      type = utils.plistDataType;
      description = ''
        The `.p12` identity certificate in NSData blob format, for
        accounts that allow authentication via certificate.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "CertificateName" = mkProfileOpt {
      type = types.str;
      description = ''
        The name or description of the certificate.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "CertificatePassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password necessary for the `.p12` identity certificate.
        Used with mandatory encryption of profiles.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "PreventMove" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prevents moving messages from out of
        this email account into another account. This setting also
        prevents forwarding or replying from an account other than
        the recipient of the message.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "PreventAppSheet" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, prevents this account from sending mail in any
        app other than the Apple Mail app.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "PayloadCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the certificate payload within the same profile
        to use for the identity credential. If this field is
        present, the Certificate field isn't used.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "SMIMEEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption. In iOS 10.0
        and later, this key is ignored. Use `SMIMESigningEnabled`
        instead.

        Requires: iOS >= 5.0
        Deprecated in iOS 10.0
      '';
      required = false;
    };
    "SMIMESigningEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME signing for this
        account. Available in iOS 10.0 and later.

        Requires: iOS >= 10.3
      '';
      required = false;
    };
    "SMIMESigningCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the identity certificate used to sign messages
        sent from this account.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMEEncryptionEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption for this
        account. Available in iOS 10.0 and later. As of iOS 12.0,
        this key is deprecated. Use `SMIMEEncryptByDefault` instead.

        Requires: iOS >= 10.3
        Deprecated in iOS 12.0
      '';
      required = false;
    };
    "SMIMEEncryptionCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The payload UUID of the identity certificate used to decrypt
        messages sent to this account. The system attaches the
        public certificate to outgoing mail to allow the user to
        receive encrypted mail. When the user sends encrypted mail,
        the system uses the public certificate to encrypt the copy
        of the mail in the user's Sent mailbox.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "SMIMEEnablePerMessageSwitch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system displays the per-message encryption
        switch in the Mail Compose UI.

        Available in iOS 8.0 and later. As of iOS 12.0, this key is
        deprecated. Use `SMIMEEnableEncryptionPerMessageSwitch`
        instead.

        Requires: iOS >= 8.0
        Deprecated in iOS 12.0
      '';
      required = false;
    };
    "disableMailRecentsSyncing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system excludes this account from Recent
        Addresses syncing.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "MailNumberOfPastDaysToSync" = mkProfileOpt {
      type = (
        types.enum [
          0
          1
          3
          7
          14
          31
        ]
      );
      description = ''
        The number of days in the past to sync mail on the device.

        For no limit, use the value `0`.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "HeaderMagic" = mkProfileOpt {
      type = types.str;
      description = ''
        The value of the `X-Apple-Config-Magic` header in each EAS
        HTTP request.

        Requires: iOS >= 4.0
        Deprecated in iOS 7.0
      '';
      required = false;
    };
    "CommunicationServiceRules" = mkProfileOpt {
      type = (
        utils.subopts {
          "DefaultServiceHandlers" = mkProfileOpt {
            type = (
              utils.subopts {
                "AudioCall" = mkProfileOpt {
                  type = types.str;
                  description = ''
                    The bundle identifier of the default application to use for
                    audio calls made to contacts from this account.

                    Requires: iOS >= 10.0
                  '';
                  required = false;
                };
              }
            );
            description = ''
              The default handlers to use for contacts from this account.

              Requires: iOS >= 10.0
            '';
            required = false;
          };
        }
      );
      description = ''
        The communication service handler rules for this account.

        Requires: iOS >= 10.0
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
    "SMIMESigningUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can turn S/MIME signing on or off in
        Settings. Available in iOS 12.0 and later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMESigningCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the signing identity.
        Available in iOS 12.0 and later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptByDefault" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption by default.
        If `SMIMEEnableEncryptionPerMessageSwitch` is `false`, the
        user can't change this default. Available in iOS 12.0 and
        later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptByDefaultUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables encryption by default and the
        user can't change it. Available in iOS 12.0 and later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEncryptionCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the S/MIME encryption
        identity, and encryption is on.Available in iOS 12.0 and
        later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "SMIMEEnableEncryptionPerMessageSwitch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system displays the per-message encryption
        switch in the Mail Compose UI. Available in iOS 12.0 and
        later.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "EnableMail" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Mail service for this
        account. The user can reenable Mail service in Settings
        unless `EnableMailUserOverridable` is `false`.

        > Note:
        > At least of the following fields needs to be `true`:
        `EnableMail`, `EnableContacts`, `EnableCalendars`,
        `EnableReminders`, and `EnableNotes`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableContacts" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Contacts service for
        this account. The user can reenable Contacts service in
        Settings unless `EnableContactsUserOverridable` is `false`.

        > Note:
        > At least of the following fields needs to be `true`:
        `EnableMail`, `EnableContacts`, `EnableCalendars`,
        `EnableReminders`, and `EnableNotes`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableCalendars" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Calendars service for
        this account. The user can reenable Calendars service in
        Settings unless `EnableCalendarsUserOverridable` is `false`.

        > Note:
        > At least of the following fields needs to be `true`:
        `EnableMail`, `EnableContacts`, `EnableCalendars`,
        `EnableReminders`, and `EnableNotes`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableReminders" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Reminders service for
        this account. The user can reenable Reminders service in
        Settings unless `EnableRemindersUserOverridable` is `false`.

        > Note:
        > At least of the following fields needs to be `true`:
        `EnableMail`, `EnableContacts`, `EnableCalendars`,
        `EnableReminders`, and `EnableNotes`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableNotes" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Notes service for this
        account. The user can reenable Notes service in Settings
        unless `EnableNotesUserOverridable` is `false`.

        > Note:
        > At least of the following fields needs to be `true`:
        `EnableMail`, `EnableContacts`, `EnableCalendars`,
        `EnableReminders`, and `EnableNotes`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableMailUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Mail service for this account in Settings.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableContactsUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Contacts service for this account in Settings.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableCalendarsUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Calendars service for this account in Settings.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableRemindersUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Reminders service for this account in Settings.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "EnableNotesUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prevents the user from changing the state of the
        Notes service for this account in Settings.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "OAuthSignInURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL that this account should use for signing in through
        OAuth. Ignored unless `OAuth` is `true`. If you specify this
        URL, auto-discovery isn't used for this account, so you need
        to also specify a host.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "OAuthTokenRequestURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL that this account should use for token requests
        through OAuth. Ignored unless `OAuth` is `true`.

        Requires: iOS >= 13.0
      '';
      required = false;
    };
    "OverridePreviousPassword" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system overrides the previous user/EAS
        password with the new EAS password in the payload. Available
        in iOS 14 and later.

        Requires: iOS >= 14.0
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
    "EmailAddress" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Host" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SSL" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "OAuth" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "UserName" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Password" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "Certificate" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "CertificateName" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "CertificatePassword" = {
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
    "PayloadCertificateUUID" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEnabled" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningEnabled" = {
      minIos = "10.3";
      maxIos = null;
      supervised = false;
    };
    "SMIMESigningCertificateUUID" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "SMIMEEncryptionEnabled" = {
      minIos = "10.3";
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
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "MailNumberOfPastDaysToSync" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "HeaderMagic" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules"."DefaultServiceHandlers" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "CommunicationServiceRules"."DefaultServiceHandlers"."AudioCall" = {
      minIos = "10.0";
      maxIos = null;
      supervised = false;
    };
    "allowMailDrop" = {
      minIos = "9.2";
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
    "EnableMail" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableContacts" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableCalendars" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableReminders" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableNotes" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableMailUserOverridable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableContactsUserOverridable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableCalendarsUserOverridable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableRemindersUserOverridable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "EnableNotesUserOverridable" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "OAuthSignInURL" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "OAuthTokenRequestURL" = {
      minIos = "13.0";
      maxIos = null;
      supervised = false;
    };
    "OverridePreviousPassword" = {
      minIos = "14.0";
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
