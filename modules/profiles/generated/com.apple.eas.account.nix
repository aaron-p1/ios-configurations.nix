# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  options = {
    enable = mkEnableOption "Enable the com.apple.eas.account profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.eas.account";
    };
    PayloadIdentifier = mkOption {
      type = types.str;
      default = "com.example.manage-ios.eas.account";
    };
    PayloadUUID = mkOption {
      type = types.str;
    };
    PayloadVersion = mkOption {
      type = types.int;
      default = 1;
    };
    "EmailAddress" = mkProfileOpt {
      type = types.str;
      description = ''
        The full email address for the account. If not present in
        the payload, the device prompts for this string during
        profile installation.
      '';
      required = false;
    };
    "Host" = mkProfileOpt {
      type = types.str;
      description = ''
        The Exchange server host name or IP address.
      '';
      required = false;
    };
    "SSL" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables SSL for authentication.
      '';
      required = false;
    };
    "OAuth" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, enables OAuth for authentication. If enabled,
        don't specify a password.

        Available only in iOS 12.0 and above.
      '';
      required = false;
    };
    "UserName" = mkProfileOpt {
      type = types.str;
      description = ''
        This user name for this Exchange account. Required for
        noninteractive installations like MDM in iOS.
      '';
      required = false;
    };
    "Password" = mkProfileOpt {
      type = types.str;
      description = ''
        The password of the account. Use only with encrypted
        profiles.
      '';
      required = false;
    };
    "Certificate" = mkProfileOpt {
      type = utils.plistDataType;
      description = ''
        The `.p12` identity certificate in NSData blob format, for
        accounts that allow authentication via certificate.
      '';
      required = false;
    };
    "CertificateName" = mkProfileOpt {
      type = types.str;
      description = ''
        The name or description of the certificate.
      '';
      required = false;
    };
    "CertificatePassword" = mkProfileOpt {
      type = types.str;
      description = ''
        The password necessary for the `.p12` identity certificate.
        Used with mandatory encryption of profiles.
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
      '';
      required = false;
    };
    "PreventAppSheet" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, prevents this account from sending mail in any
        app other than the Apple Mail app.
      '';
      required = false;
    };
    "PayloadCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the certificate payload within the same profile
        to use for the identity credential. If this field is
        present, the Certificate field isn't used.
      '';
      required = false;
    };
    "SMIMEEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption. In iOS 10.0
        and later, this key is ignored. Use `SMIMESigningEnabled`
        instead.
      '';
      required = false;
    };
    "SMIMESigningEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME signing for this
        account. Available in iOS 10.0 and later.
      '';
      required = false;
    };
    "SMIMESigningCertificateUUID" = mkProfileOpt {
      type = (types.strMatching "^[0-9A-Za-z]{8}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{4}-[0-9A-Za-z]{12}$");
      description = ''
        The UUID of the identity certificate used to sign messages
        sent from this account.
      '';
      required = false;
    };
    "SMIMEEncryptionEnabled" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables S/MIME encryption for this
        account. Available in iOS 10.0 and later. As of iOS 12.0,
        this key is deprecated. Use `SMIMEEncryptByDefault` instead.
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
      '';
      required = false;
    };
    "disableMailRecentsSyncing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system excludes this account from Recent
        Addresses syncing.
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
      '';
      required = false;
    };
    "HeaderMagic" = mkProfileOpt {
      type = types.str;
      description = ''
        The value of the `X-Apple-Config-Magic` header in each EAS
        HTTP request.
      '';
      required = false;
    };
    "CommunicationServiceRules" = mkProfileOpt {
      type = (
        types.submodule (
          { ... }: {
            options = {
              "DefaultServiceHandlers" = mkProfileOpt {
                type = (
                  types.submodule (
                    { ... }: {
                      options = {
                        "AudioCall" = mkProfileOpt {
                          type = types.str;
                          description = ''
                            The bundle identifier of the default application to use for
                            audio calls made to contacts from this account.
                          '';
                          required = false;
                        };
                      };
                    }
                  )
                );
                description = ''
                  The default handlers to use for contacts from this account.
                '';
                required = false;
              };
            };
          }
        )
      );
      description = ''
        The communication service handler rules for this account.
      '';
      required = false;
    };
    "allowMailDrop" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables this account to use Mail Drop.
      '';
      required = false;
    };
    "SMIMESigningUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can turn S/MIME signing on or off in
        Settings. Available in iOS 12.0 and later.
      '';
      required = false;
    };
    "SMIMESigningCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the signing identity.
        Available in iOS 12.0 and later.
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
      '';
      required = false;
    };
    "SMIMEEncryptByDefaultUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables encryption by default and the
        user can't change it. Available in iOS 12.0 and later.
      '';
      required = false;
    };
    "SMIMEEncryptionCertificateUUIDUserOverrideable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user can select the S/MIME encryption
        identity, and encryption is on.Available in iOS 12.0 and
        later.
      '';
      required = false;
    };
    "SMIMEEnableEncryptionPerMessageSwitch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system displays the per-message encryption
        switch in the Mail Compose UI. Available in iOS 12.0 and
        later.
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
      '';
      required = false;
    };
    "EnableMailUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Mail service for this account in Settings.
      '';
      required = false;
    };
    "EnableContactsUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Contacts service for this account in Settings.
      '';
      required = false;
    };
    "EnableCalendarsUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Calendars service for this account in Settings.
      '';
      required = false;
    };
    "EnableRemindersUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        state of the Reminders service for this account in Settings.
      '';
      required = false;
    };
    "EnableNotesUserOverridable" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prevents the user from changing the state of the
        Notes service for this account in Settings.
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
      '';
      required = false;
    };
    "OAuthTokenRequestURL" = mkProfileOpt {
      type = types.str;
      description = ''
        The URL that this account should use for token requests
        through OAuth. Ignored unless `OAuth` is `true`.
      '';
      required = false;
    };
    "OverridePreviousPassword" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system overrides the previous user/EAS
        password with the new EAS password in the payload. Available
        in iOS 14 and later.
      '';
      required = false;
    };
    "VPNUUID" = mkProfileOpt {
      type = types.str;
      description = ''
        The VPNUUID of the per-app VPN the account uses for network
        communication. Available in iOS 14 and later.
      '';
      required = false;
    };
  };
  supportData = {
    enable = {
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
