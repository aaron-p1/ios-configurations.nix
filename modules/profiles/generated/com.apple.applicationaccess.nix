# Generated from import-profiles.py. Do not edit.
{ lib, utils, ... }:
let
  inherit (lib) types mkEnableOption mkOption;
  inherit (utils) mkProfileOpt;
in
{
  description = ''
    The payload that configures restrictions on a device.

    > Important:
    > The system allows multiple Restrictions payloads. However, don't attempt to
    manage the same restriction in different payloads. Doing so results in
    unexpected behavior.
  '';
  options = {
    enable = mkEnableOption "Enable the com.apple.applicationaccess profile";
    PayloadType = mkOption {
      type = types.str;
      default = "com.apple.applicationaccess";
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
    "allowAccountModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables modification of accounts,
        such as Apple Accounts, and internet-based accounts, such as
        Mail, Contacts, and Calendar.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "allowActivityContinuation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables activity continuation.
        Support for this restriction on unsupervised devices and
        with Managed Apple Accounts is deprecated. In a future
        release, this restriction will begin requiring supervision
        and will apply to personal Apple Accounts only.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "allowAddingGameCenterFriends" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits adding friends to Game
        Center. Requires a supervised device in iOS 13 and later.

        Requires: iOS >= 4.2.1; supervised device
      '';
      required = false;
    };
    "allowAirDrop" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables AirDrop.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "allowAirPrint" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables AirPrint.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowAirPrintCredentialsStorage" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Keychain storage of user
        name and password for AirPrint.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowAirPrintiBeaconDiscovery" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables iBeacon discovery of
        AirPrint printers, which prevents spurious AirPrint
        Bluetooth beacons from phishing for network traffic.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowAppCellularDataModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables changing settings for
        cellular data usage for apps.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "allowAppClips" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents a user from adding any App
        Clips, and removes any existing App Clips on the device.

        Requires: iOS >= 14.0; supervised device
      '';
      required = false;
    };
    "allowAppInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the App Store and removes
        its icon from the Home Screen. Users are unable to install
        or update their apps. This applies to App Store apps,
        marketplace apps, and locally installed apps (using
        Configurator, Xcode, and so forth).

        In iOS 10 and later, MDM commands can override this
        restriction. Requires a supervised device in iOS 13 and
        later.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "allowAppleIntelligenceReport" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Apple Intelligence reports.

        Requires: iOS >= 18.4; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowApplePersonalizedAdvertising" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system limits Apple personalized
        advertising.

        Requires: iOS >= 14.0
      '';
      required = false;
    };
    "allowAppRemoval" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables removal of apps from an iOS
        device. This applies to App Store apps, marketplace apps,
        and locally installed apps (using Configurator, Xcode, and
        so forth).

        Requires: iOS >= 4.2.1; supervised device
      '';
      required = false;
    };
    "allowAppsToBeHidden" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the ability for the user to hide apps.
        It doesn't affect the user's ability to leave it in the App
        Library, while removing it from the Home Screen.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
    "allowAppsToBeLocked" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the ability for the user to lock apps.
        Because hiding apps also requires locking them, disallowing
        locking also disallows hiding.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
    "allowAssistant" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Siri.

        Requires: iOS >= 5.0
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowAssistantUserGeneratedContent" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents Siri from querying user-
        generated content from the web.

        Requires: iOS >= 7.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowAssistantWhileLocked" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Siri when the device is
        locked. The system ignores this restriction if the device
        doesn't have a passcode set.

        Requires: iOS >= 5.1
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowAutoCorrection" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables keyboard autocorrection.

        Requires: iOS >= 8.1.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowAutoDim" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables auto dim on iPads with OLED displays.

        Requires: iOS >= 17.4; supervised device
      '';
      required = false;
    };
    "allowAutomaticAppDownloads" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents automatic downloading of
        apps purchased on other devices. This setting doesn't affect
        updates to existing apps.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowAutoUnlock" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disallows auto unlock. Support for
        this restriction on unsupervised devices is deprecated.

        Requires: iOS >= 14.5
      '';
      required = false;
    };
    "allowBluetoothModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents modification of Bluetooth
        settings.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowBookstore" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system removes the Book Store tab from the
        Books app.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "allowBookstoreErotica" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from downloading
        Apple Books media that's tagged as erotica. Support for this
        restriction on unsupervised devices is deprecated.

        Requires: iOS >= 6.0
      '';
      required = false;
    };
    "allowCallRecording" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables call recording.

        Requires: iOS >= 18.1; supervised device
      '';
      required = false;
    };
    "allowCamera" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the camera and removes its
        icon from the Home Screen, and users are unable to take
        photographs. Support for this restriction on unsupervised
        devices is deprecated.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "allowCellularPlanModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents users from changing settings
        related to their cellular plan (available only on select
        carriers).

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowChat" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the use of iMessage with
        supervised devices. If the device supports text messaging,
        the user can still send and receive text messages.

        Requires: iOS >= 5.0; supervised device
      '';
      required = false;
    };
    "allowCloudBackup" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables backing up the device to
        iCloud. Support for this restriction on unsupervised devices
        is deprecated.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "allowCloudDocumentSync" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables document and key-value
        syncing to iCloud. Requires a supervised device in iOS 13
        and later, and Shared iPad doesn't support it. Support for
        this restriction on unsupervised devices and with Managed
        Apple Accounts is deprecated.

        Requires: iOS >= 5.0; supervised device
      '';
      required = false;
    };
    "allowCloudKeychainSync" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables iCloud Keychain
        synchronization. Support for this restriction on
        unsupervised devices and with Managed Apple Accounts is
        deprecated.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowCloudPhotoLibrary" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables iCloud Photo Library. The
        system removes any photos from local storage that aren't
        fully downloaded from iCloud Photo Library to the device.
        Support for this restriction on unsupervised devices and
        with Managed Apple Accounts is deprecated.

        Requires: iOS >= 9.0
      '';
      required = false;
    };
    "allowCloudPrivateRelay" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables iCloud Private Relay.
        Support for this restriction on unsupervised devices and
        with Managed Apple Accounts is deprecated.

        Requires: iOS >= 15.0; supervised device
      '';
      required = false;
    };
    "allowContinuousPathKeyboard" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables QuickPath keyboard.

        Requires: iOS >= 13.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowDefaultBrowserModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables default browser preference
        modification. The MDM Settings command to set the default
        browser preference still works when applying this.

        Requires: iOS >= 18.2; supervised device
      '';
      required = false;
    };
    "allowDefaultCallingAppModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables default calling app preference
        modification. The MDM Settings command to set the default
        calling app preference still works when applying this.

        Requires: iOS >= 18.4; supervised device
      '';
      required = false;
    };
    "allowDefaultMessagingAppModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables default messaging app preference
        modification. The MDM Settings command to set the default
        messaging app preference still works when applying this.

        Requires: iOS >= 18.4; supervised device
      '';
      required = false;
    };
    "allowDefinitionLookup" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables definition lookup.

        Requires: iOS >= 8.1.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowDeviceNameModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from changing the
        device name.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowDiagnosticSubmission" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the device from
        automatically submitting diagnostic reports to Apple.

        Requires: iOS >= 6.0
      '';
      required = false;
    };
    "allowDiagnosticSubmissionModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables changing the diagnostic
        submission and app analytics settings in the Diagnostics &
        Usage UI in Settings.

        Requires: iOS >= 9.3.2; supervised device
      '';
      required = false;
    };
    "allowDictation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disallows dictation input.

        Requires: iOS >= 10.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowedCameraRestrictionBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        If present, the system exempts apps with bundle IDs in the
        array from the `allowCamera` restriction. The system doesn't
        grant these apps access to the camera automatically; they're
        only exempted from the `allowCamera` restriction. This key
        has no effect when the camera isn't restricted. Multiple
        payloads combine using an intersect operation. Requires a
        supervised device.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "allowedExternalIntelligenceWorkspaceIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings, but currently restricted to a single
        element. If present, Apple Intelligence allows use of only
        the given external integration workspace ID, and requires a
        sign-in to make requests. The user is required to sign in to
        integrations that support signing in. Multiple payloads
        combine using an intersect operation. This means the allowed
        set of workspace IDs can become the empty set if multiple
        payloads specify conflicting values.

        Requires: iOS >= 18.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowEnablingRestrictions" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Enable Restrictions
        option in the Restrictions UI in Settings. If `false` in iOS
        12 and later, the system disables the Enable ScreenTime
        option in the ScreenTime UI in Settings and disables
        ScreenTime if already enabled.

        Requires: iOS >= 8.0; supervised device
      '';
      required = false;
    };
    "allowEnterpriseAppTrust" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system removes the Trust Enterprise
        Developer button in Settings > General > VPN & Device
        Management, which prevents provisioning apps by universal
        provisioning profiles. This restriction applies to free
        developer accounts and enterprise app developers that aren't
        implicitly trusted by apps that install through MDM. This
        restriction doesn't revoke previously granted trust.

        Requires: iOS >= 9.0
      '';
      required = false;
    };
    "allowEnterpriseBookBackup" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables backup of Enterprise books.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "allowEnterpriseBookMetadataSync" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables sync of Enterprise books,
        notes, and highlights.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "allowEraseContentAndSettings" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Erase All Content and
        Settings option in the Reset UI.

        Requires: iOS >= 8.0; supervised device
      '';
      required = false;
    };
    "allowESIMModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables modifications of eSIMs.

        Requires: iOS >= 12.1; supervised device
      '';
      required = false;
    };
    "allowESIMOutgoingTransfers" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prevents the transfer of an eSIM from the device
        on which the restriction is installed to a different device.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
    "allowExplicitContent" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system hides explicit music or video content
        purchased from the iTunes Store. The system marks explicit
        content as such by content providers, such as record labels,
        when sold through the iTunes Store. Explicit content in the
        News and Podcast apps is also hidden.

        Requires a supervised device in iOS 13 and later. Support
        for this restriction on unsupervised devices is deprecated.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "allowExternalIntelligenceIntegrations" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the use of external, cloud-based
        intelligence services with Siri. In iOS, this restriction is
        temporarily allowed on unsupervised and user enrollments. In
        a future release, this restriction will require supervision,
        and will be ignored on unsupervised devices.

        Requires: iOS >= 18.2
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowExternalIntelligenceIntegrationsSignIn" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, forces external intelligence providers into
        anonymous mode. If a user is already signed in to an
        external intelligence provider, applying this restriction
        signs them out when attempting the next request.

        Requires: iOS >= 18.2
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowFilesNetworkDriveAccess" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents connecting to network drives
        in the Files app.

        Requires: iOS >= 13.1; supervised device
      '';
      required = false;
    };
    "allowFilesUSBDriveAccess" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents connecting to any connected
        USB devices in the Files app.

        Requires: iOS >= 13.0; supervised device
      '';
      required = false;
    };
    "allowFindMyDevice" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Find My Device in the Find
        My app.

        Requires: iOS >= 13.0; supervised device
      '';
      required = false;
    };
    "allowFindMyFriends" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Find My Friends in the Find
        My app.

        Requires: iOS >= 13.0; supervised device
      '';
      required = false;
    };
    "allowFindMyFriendsModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables changes to Find My Friends.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "allowFingerprintForUnlock" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents Touch ID, Face ID, or Optic
        ID from unlocking a device. Support for this restriction on
        unsupervised devices is deprecated.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowFingerprintModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents the user from modifying
        Touch ID or Face ID.

        Requires: iOS >= 8.3; supervised device
      '';
      required = false;
    };
    "allowGameCenter" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Game Center, and the system
        removes its icon from the Home Screen.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "allowGenmoji" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prohibits creating new Genmoji.

        Requires: iOS >= 18.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowGlobalBackgroundFetchWhenRoaming" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables global background fetch
        activity when an iOS phone is roaming. Support for this
        restriction on unsupervised devices is deprecated.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "allowHostPairing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables host pairing with the
        exception of the supervision host. If there's no configured
        supervision host certificate, the system disables all
        pairing. Host pairing lets the administrator control whether
        an iOS device can pair with a host Mac or PC.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "allowImagePlayground" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prohibits the use of image generation.

        Requires: iOS >= 18.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowImageWand" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prohibits the use of Image Wand.

        Requires: iOS >= 18.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowInAppPurchases" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits in-app purchasing. Support
        for this restriction on unsupervised devices is deprecated.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "allowiPhoneMirroring" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prohibits the use of iPhone Mirroring. In macOS,
        this prevents the Mac from mirroring any iPhone. In iOS,
        this prevents the iPhone from mirroring to any Mac.

        Requires: iOS >= 18.0; supervised device
      '';
      required = false;
    };
    "allowiPhoneWidgetsOnMac" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disallows iPhone widgets on a Mac
        that signs in with the same Apple Account for iCloud.

        Requires: iOS >= 17.0; supervised device
      '';
      required = false;
    };
    "allowiTunes" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the iTunes Music Store and
        removes its icon from the Home Screen. Users can't preview,
        purchase, or download content. Requires a supervised device
        in iOS 13 and later.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "allowKeyboardShortcuts" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables keyboard shortcuts.

        Requires: iOS >= 9.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowListedAppBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        If present, the system only shows or can launch apps with
        bundle IDs in the array. Include the value
        `com.apple.webapp` to allow all webclips. This applies to
        App Store apps, marketplace apps, and locally installed apps
        (using Configurator, Xcode, and so forth).

        Requires: iOS >= 15.0; supervised device
      '';
      required = false;
    };
    "allowLiveVoicemail" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables live voicemail on the
        device.

        Requires: iOS >= 17.2; supervised device
      '';
      required = false;
    };
    "allowLockScreenControlCenter" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents Control Center from
        appearing on the Lock Screen.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowLockScreenNotificationsView" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Notifications history
        view on the Lock Screen, so users can't view past
        notifications. However, they can still see notifications
        when they arrive.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowLockScreenTodayView" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Today view in
        Notification Center on the Lock Screen.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowMailPrivacyProtection" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Mail Privacy Protection on
        the device.

        Requires: iOS >= 15.2; supervised device
      '';
      required = false;
    };
    "allowMailSmartReplies" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables smart replies in Mail.

        Requires: iOS >= 18.4; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowMailSummary" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the ability to create summaries of
        email messages manually. This doesn't affect automatic
        summary generation.

        Requires: iOS >= 18.1; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowManagedAppsCloudSync" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents managed apps from using
        iCloud sync.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "allowManagedToWriteUnmanagedContacts" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system allows managed apps to write contacts
        to unmanaged accounts. If `allowOpenFromManagedToUnmanaged`
        is `true`, this restriction has no effect.

        > Important:
        > Use MDM to install profiles that contain this restriction.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "allowMarketplaceAppInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents installation of alternative
        marketplace apps from the web and prevents any installed
        alternative marketplace apps from installing apps.

        Requires: iOS >= 17.4; supervised device
      '';
      required = false;
    };
    "allowMultiplayerGaming" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits multiplayer gaming.

        Requires: iOS >= 4.1; supervised device
      '';
      required = false;
    };
    "allowMusicService" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Music service, and the
        Music app reverts to classic mode.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "allowNews" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables News.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowNFC" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables NFC.

        Requires: iOS >= 14.2; supervised device
      '';
      required = false;
    };
    "allowNotesTranscription" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables transcription in Notes.

        Requires: iOS >= 18.4; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowNotesTranscriptionSummary" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables transcription summarization in Notes.

        Requires: iOS >= 18.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowNotificationsModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables modification of notification
        settings.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "allowOpenFromManagedToUnmanaged" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, documents in managed apps and accounts open only
        in other managed apps and accounts.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowOpenFromUnmanagedToManaged" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, documents in unmanaged apps and accounts open
        only in other unmanaged apps and accounts.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowOTAPKIUpdates" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables over-the-air PKI updates.
        Setting this restriction to `false` doesn't disable CRL and
        OCSP checks.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "allowPairedWatch" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables pairing with an Apple Watch,
        and the system unpairs any currently paired Apple Watch and
        erases its content.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowPassbookWhileLocked" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system hides Passbook notifications from the
        Lock Screen.

        Requires: iOS >= 6.0
      '';
      required = false;
    };
    "allowPasscodeModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents adding, changing, or
        removing the passcode. The system ignores this restriction
        on Shared iPad.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowPasswordAutoFill" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables:

        - The AutoFill Passwords feature in iOS, with Keychain and
        third-party password managers
        - Prompting the user to use a saved password in Safari or in
        apps
        - Automatic strong passwords
        - Suggesting strong passwords to users

        However, if `false`, the system doesn't prevent AutoFill for
        contact info and credit cards in Safari.

        Requires: iOS >= 12.0; supervised device
      '';
      required = false;
    };
    "allowPasswordProximityRequests" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables requesting passwords from
        nearby devices.

        Requires: iOS >= 12.0; supervised device
      '';
      required = false;
    };
    "allowPasswordSharing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables sharing passwords with the
        AirDrop passwords feature, or with the Passwords app.

        Requires: iOS >= 12.0; supervised device
      '';
      required = false;
    };
    "allowPersonalHotspotModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables modifications of the
        personal hotspot setting.

        Requires: iOS >= 12.2; supervised device
      '';
      required = false;
    };
    "allowPersonalizedHandwritingResults" = mkProfileOpt {
      type = types.bool;
      description = ''
        If false, prevents the system from generating text in the
        user's handwriting.

        Requires: iOS >= 18.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowPhotoStream" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Photo Stream.

        Requires: iOS >= 5.0
        Deprecated in iOS 17.0
      '';
      required = false;
    };
    "allowPodcasts" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables podcasts.

        Requires: iOS >= 8.0; supervised device
      '';
      required = false;
    };
    "allowPredictiveKeyboard" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables predictive keyboards.

        Requires: iOS >= 8.1.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowProximitySetupToNewDevice" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the prompt to set up new devices that
        are nearby. Starting with iOS 26.3, this also prevents
        exporting iOS data to set up new Android devices.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowRadioService" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Apple Music Radio.

        Requires: iOS >= 9.3; supervised device
      '';
      required = false;
    };
    "allowRapidSecurityResponseInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits installation of Background
        Security Improvements.

        Requires: iOS >= 16.0; supervised device
        Deprecated in iOS 26.0
      '';
      required = false;
    };
    "allowRapidSecurityResponseRemoval" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits removal of Background
        Security Improvements.

        Requires: iOS >= 16.0; supervised device
        Deprecated in iOS 26.0
      '';
      required = false;
    };
    "allowRCSMessaging" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, prevents the use of RCS messaging.

        Requires: iOS >= 18.1; supervised device
      '';
      required = false;
    };
    "allowRemoteScreenObservation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables remote screen observation by
        the Classroom app. Nest this key beneath `allowScreenShot`
        as a subrestriction. If `allowScreenShot` is `false`, the
        Classroom app doesn't observe remote screens. Requires a
        supervised device until iOS 13 and macOS 10.15. Allowed for
        user enrollments in macOS 12 and later.

        Requires: iOS >= 9.3
      '';
      required = false;
    };
    "allowSafari" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the Safari web browser app,
        and the system removes its icon from the Home Screen. This
        setting also prevents users from opening web clips. Requires
        a supervised device in iOS 13 and later.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "allowSafariHistoryClearing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the ability to clear
        browsing history in Safari.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "allowSafariPrivateBrowsing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the ability to use private
        browsing in Safari.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "allowSafariSummary" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the ability to summarize
        content in Safari.

        Requires: iOS >= 18.4; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowSatelliteConnection" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits the connection to and use
        of satellite services.

        Requires: iOS >= 18.2; supervised device
      '';
      required = false;
    };
    "allowScreenShot" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables saving a screenshot of the
        display and capturing a screen recording. It also disables
        the Classroom app from observing remote screens.

        Requires: iOS >= 3.1
      '';
      required = false;
    };
    "allowSharedDeviceTemporarySession" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system makes temporary sessions unavailable
        on Shared iPad.

        Requires: iOS >= 13.4; supervised device
      '';
      required = false;
    };
    "allowSharedStream" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Shared Photo Stream. Support
        for this restriction on unsupervised devices is deprecated.

        Requires: iOS >= 6.0
      '';
      required = false;
    };
    "allowSpellCheck" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the keyboard spell checker.

        Requires: iOS >= 8.1.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowSpotlightInternetResults" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Spotlight Internet search
        results in Siri Suggestions. Support for this restriction on
        unsupervised devices is deprecated.

        Requires: iOS >= 8.0
      '';
      required = false;
    };
    "allowSystemAppRemoval" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the removal of system apps
        from the device.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowUIAppInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables the App Store and removes
        its icon from the Home Screen. However, users can continue
        to install or update their apps either locally (via
        Configurator, Xcode, and so forth), or using alternative
        marketplace apps.

        In iOS 10 and later, MDM commands can override this
        restriction.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowUIConfigurationProfileInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prohibits the user from installing
        configuration profiles and certificates interactively.

        Requires: iOS >= 6.0; supervised device
      '';
      required = false;
    };
    "allowUnmanagedToReadManagedContacts" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system allows unmanaged apps to read from
        managed contacts accounts. If
        `allowOpenFromManagedToUnmanaged` is `true`, this
        restriction has no effect.

        > Important:
        > Use MDM to install profiles that contain this restriction.

        Requires: iOS >= 12.0
      '';
      required = false;
    };
    "allowUnpairedExternalBootToRecovery" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system allows unpaired devices to boot
        devices into recovery.

        Requires: iOS >= 14.5; supervised device
      '';
      required = false;
    };
    "allowUntrustedTLSPrompt" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system automatically rejects untrusted HTTPS
        certificates without prompting the user.

        Requires: iOS >= 5.0
      '';
      required = false;
    };
    "allowUSBRestrictedMode" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system allows iOS devices to always connect
        to USB accessories while locked. In macOS, allows new USB
        and Thunderbolt accessories, and SD cards to connect without
        authorization. If the system has Lockdown mode enabled, it
        ignores this value. This restriction is not supported on the
        user channel.

        Requires: iOS >= 11.4.1; supervised device
      '';
      required = false;
    };
    "allowVideoConferencing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system hides the FaceTime app. Requires a
        supervised device in iOS 13 and later.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "allowVideoConferencingRemoteControl" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables the ability for a remote FaceTime
        session to request control of the device.

        Requires: iOS >= 18.4; supervised device
      '';
      required = false;
    };
    "allowVisualIntelligenceSummary" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables visual intelligence
        summarization.

        Requires: iOS >= 18.3; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "allowVoiceDialing" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables voice dialing if the device
        is locked with a passcode.

        Requires: iOS >= 4.0
        Deprecated in iOS 17.0
      '';
      required = false;
    };
    "allowVPNCreation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system allows only managed apps to create
        VPN configurations. Prior to iOS 18, the system also allows
        unmanaged apps to create VPN configurations.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "allowWallpaperModification" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system prevents changing the wallpaper.

        Requires: iOS >= 9.0; supervised device
      '';
      required = false;
    };
    "allowWebDistributionAppInstallation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the device prevents installation of apps
        directly from the web.

        Requires: iOS >= 17.5; supervised device
      '';
      required = false;
    };
    "allowWritingTools" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, disables Apple Intelligence writing tools.

        Requires: iOS >= 18.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "autonomousSingleAppModePermittedAppIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        If present, the system allows apps identified by the bundle
        IDs listed in the array to autonomously enter Single App
        Mode.

        Requires: iOS >= 7.0; supervised device
      '';
      required = false;
    };
    "blacklistedAppBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        Use `blockedAppBundleIDs` instead.

        Requires: iOS >= 9.3; supervised device
        Deprecated in iOS 15.0
      '';
      required = false;
    };
    "blockedAppBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        If present, the system prevents showing or launching apps
        with bundle IDs in the array. Include the value
        `com.apple.webapp` to restrict all webclips. This applies to
        App Store apps, marketplace apps, and locally installed apps
        (using Configurator, Xcode, and so forth).

        > Note:
        > Denying system apps may disable other functionality. For
        example, denying the App Store app may prevent users from
        accepting the terms and conditions for the user-based Volume
        Purchase Program (VPP).

        Requires: iOS >= 15.0; supervised device
      '';
      required = false;
    };
    "deniedICCIDsForiMessageFaceTime" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings representing ICCIDs of cellular plans.
        The device prevents use of any matching cellular networks in
        iMessage and FaceTime. The array must contain no more than 4
        ICCID strings.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "deniedICCIDsForRCS" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        An array of strings representing ICCIDs of cellular plans.
        The device prevents use of any matching cellular networks
        with RCS messaging. The array must contain no more than 4
        ICCID strings.

        Requires: iOS >= 26.0; supervised device
      '';
      required = false;
    };
    "enforcedSoftwareUpdateDelay" = mkProfileOpt {
      type = (types.ints.between 1 90);
      description = ''
        How many days to delay a software update on the device. With
        this restriction in place, the user doesn't see a software
        update until the specified number of days after the software
        update release date. The restrictions
        `forceDelayedAppSoftwareUpdates` and
        `forceDelayedSoftwareUpdates` use this value.

        Requires: iOS >= 11.3; supervised device
        Deprecated in iOS 26.0
      '';
      required = false;
    };
    "forceAirDropUnmanaged" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system considers AirDrop to be an unmanaged
        drop target.

        Requires: iOS >= 9.0
      '';
      required = false;
    };
    "forceAirPlayOutgoingRequestsPairingPassword" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system forces all devices receiving AirPlay
        requests from this device to use a pairing password.

        Requires: iOS >= 7.1
      '';
      required = false;
    };
    "forceAirPrintTrustedTLSRequirement" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system requires trusted certificates for TLS
        printing communication.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "forceAssistantProfanityFilter" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system forces the use of the profanity filter
        for Siri and dictation. Requires a supervised device in iOS.

        Requires: iOS >= 5.0; supervised device
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "forceAuthenticationBeforeAutoFill" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the user needs to authenticate before the system
        can autofill passwords or credit card information in Safari
        and apps. If this restriction isn't enforced, the user can
        toggle this feature in Settings. Only supported on devices
        with Face ID or Touch ID.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "forceAutomaticDateAndTime" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables the Set Automatically feature
        in Date & Time and the user can't disable it. The system
        updates the device's time zone only when the device can
        determine its location using a cellular connection or Wi-Fi
        with location services enabled.

        Requires: iOS >= 12.0; supervised device
      '';
      required = false;
    };
    "forceClassroomAutomaticallyJoinClasses" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system automatically gives permission to the
        teacher's requests without prompting the student.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "forceClassroomRequestPermissionToLeaveClasses" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, a student enrolled in an unmanaged course through
        Classroom needs to request permission from the teacher to
        leave the course.

        Requires: iOS >= 11.3; supervised device
      '';
      required = false;
    };
    "forceClassroomUnpromptedAppAndDeviceLock" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system allows the teacher to lock apps or the
        device without prompting the student.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "forceClassroomUnpromptedScreenObservation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true` and
        `ScreenObservationPermissionModificationAllowed` is also
        `true` in the Education payload, a student enrolled in a
        managed course through the Classroom app automatically gives
        permission to that course teacher's requests to observe the
        student's screen without prompting the student.

        Requires: iOS >= 11.0; supervised device
      '';
      required = false;
    };
    "forceDelayedSoftwareUpdates" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system delays user visibility of software
        updates. In macOS, the system allows seed build updates
        without delay. The delay is 30 days unless you set
        `enforcedSoftwareUpdateDelay` to another value.

        Requires: iOS >= 11.3; supervised device
        Deprecated in iOS 26.0
      '';
      required = false;
    };
    "forceEncryptedBackup" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system encrypts all backups.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "forceITunesStorePasswordEntry" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system forces the user to enter their iTunes
        password for each transaction.

        Requires: iOS >= 6.0
        Deprecated in iOS 17.0
      '';
      required = false;
    };
    "forceLimitAdTracking" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system limits ad tracking. Additionally, it
        disables app tracking and the Allow Apps to Request to Track
        setting.

        Requires: iOS >= 7.0
      '';
      required = false;
    };
    "forceOnDeviceOnlyDictation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system disables connections to Siri servers
        for the purposes of dictation.

        Requires: iOS >= 14.5
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "forceOnDeviceOnlyTranslation" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the device can't connect to Siri servers for the
        purposes of translation.

        Requires: iOS >= 15.0
        Deprecated in iOS 26.4
      '';
      required = false;
    };
    "forcePreserveESIMOnErase" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system preserves eSIM when it erases the
        device due to too many failed password attempts or the Erase
        All Content and Settings option in Settings > General >
        Reset.

        > Note:
        > The system doesn't preserve eSIM if Find My initiates
        erasing the device.

        Requires: iOS >= 17.2; supervised device
      '';
      required = false;
    };
    "forceWatchWristDetection" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system forces a paired Apple Watch to use
        Wrist Detection.

        Requires: iOS >= 8.2
      '';
      required = false;
    };
    "forceWiFiPowerOn" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system prevents turning off Wi-Fi in Settings
        or Control Center, even by entering or leaving Airplane
        Mode. It doesn't prevent selecting which Wi-Fi network to
        use. and later.

        Requires: iOS >= 13.0; supervised device
      '';
      required = false;
    };
    "forceWiFiToAllowedNetworksOnly" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system limits the device to only join Wi-Fi
        networks set up through a configuration profile.

        Requires: iOS >= 14.5; supervised device
      '';
      required = false;
    };
    "forceWiFiWhitelisting" = mkProfileOpt {
      type = types.bool;
      description = ''
        Use `forceWiFiToAllowedNetworksOnly` instead.

        Requires: iOS >= 10.3; supervised device
        Deprecated in iOS 14.5
      '';
      required = false;
    };
    "ratingApps" = mkProfileOpt {
      type = (types.ints.between 0 1000);
      description = ''
        The maximum level of app content allowed on the device.
        Starting with iOS 26.2, this rating may apply to certain
        system apps.

        Age bands and the number of discrete age values vary by
        region, but the values are consistent across regions. For
        example, in a region that defines rating level 14+, its
        value is guaranteed to be larger than 300 (12+) and smaller
        than 600 (17+). Also, the value of rating level 15+ is
        guaranteed to be larger than the assigned value of rating
        level 14+. For more information about age ratings, see [Age
        ratings values and
        definitions](https://developer.apple.com/help/app-store-
        connect/reference/age-ratings-values-and-definitions).

        Below is the complete list of age rating values used across
        all App Store regions.
        - `1000`: All
        - `621`: 21+
        - `620`: 20+
        - `619`: 19+
        - `618`: 18+
        - `600`: 17+
        - `416`: 16+
        - `415`: 15+
        - `314`: 14+
        - `313`: 13+
        - `300`: 12+
        - `211`: 11+
        - `210`: 10+
        - `200`: 9+
        - `108`: 8+
        - `107`: 7+
        - `106`: 6+
        - `105`: 5+
        - `100`: 4+
        - `3`: 3+
        - `2`: 2+
        - `1`: 1+
        - `0`: None

        This restriction will require supervision in a future
        release.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ratingAppsExemptedBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        If present, the system exempts apps with bundle IDs in the
        array from age-based rating restrictions. The system uses
        intersection combine rules to combine multiple payloads and
        any exceptions that parental control apps provide, including
        ScreenTime.

        Requires: iOS >= 26.1
      '';
      required = false;
    };
    "ratingMovies" = mkProfileOpt {
      type = (types.ints.between 0 1000);
      description = ''
        The maximum level of movie content allowed on the device.
        Support for this restriction on unsupervised devices is
        deprecated.

        Possible values, with the U.S. description of the rating
        level:

        - `1000`: All
        - `500`: NC-17
        - `400`: R
        - `300`: PG-13
        - `200`: PG
        - `100`: G
        - `0`: None

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ratingRegion" = mkProfileOpt {
      type = (
        types.enum [
          "us"
          "au"
          "ca"
          "de"
          "fr"
          "ie"
          "jp"
          "nz"
          "gb"
        ]
      );
      description = ''
        The two-letter key that profile tools use to display the
        proper ratings for the given region. The client doesn't
        recognize or report this data.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "ratingTVShows" = mkProfileOpt {
      type = (types.ints.between 0 1000);
      description = ''
        The maximum level of TV content allowed on the device.
        Support for this restriction on unsupervised devices is
        deprecated.

        Possible values, with the U.S. description of the rating
        level:

        - `1000`: All
        - `600`: TV-MA
        - `500`: TV-14
        - `400`: TV-PG
        - `300`: TV-G
        - `200`: TV-Y7
        - `100`: TV-Y
        - `0`: None

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "requireManagedPasteboard" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, copy-and-paste functionality is limited by the
        `allowOpenFromManagedToUnmanaged` and
        `allowOpenFromUnmanagedToManaged` restrictions.

        Requires: iOS >= 15.0
      '';
      required = false;
    };
    "safariAcceptCookies" = mkProfileOpt {
      type = (
        types.enum [
          0.0
          1.0
          1.5
          2.0
        ]
      );
      description = ''
        Defines the conditions under which the device accepts
        cookies. The user-facing settings changed in iOS 11,
        although the possible values remain the same. Support for
        this restriction on unsupervised devices is deprecated.
        Allowed values:

        - `0`: Enables Prevent Cross-Site Tracking and Block All
        Cookies, and the user canʼt disable either setting.
        - `1` or `1.5`: Enables Prevent Cross-Site Tracking, and the
        user canʼt disable it. Doesn't enable Block All Cookies, but
        the user can enable it.
        - `2`: Enables Prevent Cross-Site Tracking, but doesn't
        enable Block All Cookies. The user can toggle either
        setting.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "safariAllowAutoFill" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, the system disables Safari AutoFill for
        passwords, contact info, and credit cards, and also prevents
        using the Keychain for AutoFill. Requires a supervised
        device in iOS 13 and later.

        > Note:
        > The system still allows third-party password managers, and
        apps can use AutoFill.

        Requires: iOS >= 4.0; supervised device
      '';
      required = false;
    };
    "safariAllowJavaScript" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, Safari doesn't execute JavaScript. This
        restriction will require supervision in a future release.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "safariAllowPopups" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `false`, Safari doesn't allow pop-up windows. Support for
        this restriction on unsupervised devices is deprecated.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "safariForceFraudWarning" = mkProfileOpt {
      type = types.bool;
      description = ''
        If `true`, the system enables Safari fraud warning.

        Requires: iOS >= 4.0
      '';
      required = false;
    };
    "whitelistedAppBundleIDs" = mkProfileOpt {
      type = (types.listOf types.str);
      description = ''
        Use `allowListedAppBundleIDs` instead.

        Requires: iOS >= 9.3; supervised device
        Deprecated in iOS 15.0
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
    "allowAccountModification" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowActivityContinuation" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "allowAddingGameCenterFriends" = {
      minIos = "4.2.1";
      maxIos = null;
      supervised = true;
    };
    "allowAirDrop" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowAirPrint" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowAirPrintCredentialsStorage" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowAirPrintiBeaconDiscovery" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowAppCellularDataModification" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowAppClips" = {
      minIos = "14.0";
      maxIos = null;
      supervised = true;
    };
    "allowAppInstallation" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "allowAppleIntelligenceReport" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowApplePersonalizedAdvertising" = {
      minIos = "14.0";
      maxIos = null;
      supervised = false;
    };
    "allowAppRemoval" = {
      minIos = "4.2.1";
      maxIos = null;
      supervised = true;
    };
    "allowAppsToBeHidden" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowAppsToBeLocked" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowAssistant" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "allowAssistantUserGeneratedContent" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowAssistantWhileLocked" = {
      minIos = "5.1";
      maxIos = null;
      supervised = false;
    };
    "allowAutoCorrection" = {
      minIos = "8.1.3";
      maxIos = null;
      supervised = true;
    };
    "allowAutoDim" = {
      minIos = "17.4";
      maxIos = null;
      supervised = true;
    };
    "allowAutomaticAppDownloads" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowAutoUnlock" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "allowBluetoothModification" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowBookstore" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "allowBookstoreErotica" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "allowCallRecording" = {
      minIos = "18.1";
      maxIos = null;
      supervised = true;
    };
    "allowCamera" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "allowCellularPlanModification" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowChat" = {
      minIos = "5.0";
      maxIos = null;
      supervised = true;
    };
    "allowCloudBackup" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "allowCloudDocumentSync" = {
      minIos = "5.0";
      maxIos = null;
      supervised = true;
    };
    "allowCloudKeychainSync" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowCloudPhotoLibrary" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "allowCloudPrivateRelay" = {
      minIos = "15.0";
      maxIos = null;
      supervised = true;
    };
    "allowContinuousPathKeyboard" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "allowDefaultBrowserModification" = {
      minIos = "18.2";
      maxIos = null;
      supervised = true;
    };
    "allowDefaultCallingAppModification" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowDefaultMessagingAppModification" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowDefinitionLookup" = {
      minIos = "8.1.3";
      maxIos = null;
      supervised = true;
    };
    "allowDeviceNameModification" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowDiagnosticSubmission" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "allowDiagnosticSubmissionModification" = {
      minIos = "9.3.2";
      maxIos = null;
      supervised = true;
    };
    "allowDictation" = {
      minIos = "10.3";
      maxIos = null;
      supervised = true;
    };
    "allowedCameraRestrictionBundleIDs" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "allowedExternalIntelligenceWorkspaceIDs" = {
      minIos = "18.3";
      maxIos = null;
      supervised = true;
    };
    "allowEnablingRestrictions" = {
      minIos = "8.0";
      maxIos = null;
      supervised = true;
    };
    "allowEnterpriseAppTrust" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "allowEnterpriseBookBackup" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "allowEnterpriseBookMetadataSync" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "allowEraseContentAndSettings" = {
      minIos = "8.0";
      maxIos = null;
      supervised = true;
    };
    "allowESIMModification" = {
      minIos = "12.1";
      maxIos = null;
      supervised = true;
    };
    "allowESIMOutgoingTransfers" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowExplicitContent" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "allowExternalIntelligenceIntegrations" = {
      minIos = "18.2";
      maxIos = null;
      supervised = false;
    };
    "allowExternalIntelligenceIntegrationsSignIn" = {
      minIos = "18.2";
      maxIos = null;
      supervised = false;
    };
    "allowFilesNetworkDriveAccess" = {
      minIos = "13.1";
      maxIos = null;
      supervised = true;
    };
    "allowFilesUSBDriveAccess" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "allowFindMyDevice" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "allowFindMyFriends" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "allowFindMyFriendsModification" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowFingerprintForUnlock" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowFingerprintModification" = {
      minIos = "8.3";
      maxIos = null;
      supervised = true;
    };
    "allowGameCenter" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "allowGenmoji" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowGlobalBackgroundFetchWhenRoaming" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "allowHostPairing" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "allowImagePlayground" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowImageWand" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowInAppPurchases" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "allowiPhoneMirroring" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowiPhoneWidgetsOnMac" = {
      minIos = "17.0";
      maxIos = null;
      supervised = true;
    };
    "allowiTunes" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "allowKeyboardShortcuts" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowListedAppBundleIDs" = {
      minIos = "15.0";
      maxIos = null;
      supervised = true;
    };
    "allowLiveVoicemail" = {
      minIos = "17.2";
      maxIos = null;
      supervised = true;
    };
    "allowLockScreenControlCenter" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowLockScreenNotificationsView" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowLockScreenTodayView" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowMailPrivacyProtection" = {
      minIos = "15.2";
      maxIos = null;
      supervised = true;
    };
    "allowMailSmartReplies" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowMailSummary" = {
      minIos = "18.1";
      maxIos = null;
      supervised = true;
    };
    "allowManagedAppsCloudSync" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "allowManagedToWriteUnmanagedContacts" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "allowMarketplaceAppInstallation" = {
      minIos = "17.4";
      maxIos = null;
      supervised = true;
    };
    "allowMultiplayerGaming" = {
      minIos = "4.1";
      maxIos = null;
      supervised = true;
    };
    "allowMusicService" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "allowNews" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowNFC" = {
      minIos = "14.2";
      maxIos = null;
      supervised = true;
    };
    "allowNotesTranscription" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowNotesTranscriptionSummary" = {
      minIos = "18.3";
      maxIos = null;
      supervised = true;
    };
    "allowNotificationsModification" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "allowOpenFromManagedToUnmanaged" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowOpenFromUnmanagedToManaged" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowOTAPKIUpdates" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "allowPairedWatch" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowPassbookWhileLocked" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "allowPasscodeModification" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowPasswordAutoFill" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "allowPasswordProximityRequests" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "allowPasswordSharing" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "allowPersonalHotspotModification" = {
      minIos = "12.2";
      maxIos = null;
      supervised = true;
    };
    "allowPersonalizedHandwritingResults" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "allowPhotoStream" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "allowPodcasts" = {
      minIos = "8.0";
      maxIos = null;
      supervised = true;
    };
    "allowPredictiveKeyboard" = {
      minIos = "8.1.3";
      maxIos = null;
      supervised = true;
    };
    "allowProximitySetupToNewDevice" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowRadioService" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "allowRapidSecurityResponseInstallation" = {
      minIos = "16.0";
      maxIos = null;
      supervised = true;
    };
    "allowRapidSecurityResponseRemoval" = {
      minIos = "16.0";
      maxIos = null;
      supervised = true;
    };
    "allowRCSMessaging" = {
      minIos = "18.1";
      maxIos = null;
      supervised = true;
    };
    "allowRemoteScreenObservation" = {
      minIos = "9.3";
      maxIos = null;
      supervised = false;
    };
    "allowSafari" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "allowSafariHistoryClearing" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "allowSafariPrivateBrowsing" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "allowSafariSummary" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowSatelliteConnection" = {
      minIos = "18.2";
      maxIos = null;
      supervised = true;
    };
    "allowScreenShot" = {
      minIos = "3.1";
      maxIos = null;
      supervised = false;
    };
    "allowSharedDeviceTemporarySession" = {
      minIos = "13.4";
      maxIos = null;
      supervised = true;
    };
    "allowSharedStream" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "allowSpellCheck" = {
      minIos = "8.1.3";
      maxIos = null;
      supervised = true;
    };
    "allowSpotlightInternetResults" = {
      minIos = "8.0";
      maxIos = null;
      supervised = false;
    };
    "allowSystemAppRemoval" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowUIAppInstallation" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowUIConfigurationProfileInstallation" = {
      minIos = "6.0";
      maxIos = null;
      supervised = true;
    };
    "allowUnmanagedToReadManagedContacts" = {
      minIos = "12.0";
      maxIos = null;
      supervised = false;
    };
    "allowUnpairedExternalBootToRecovery" = {
      minIos = "14.5";
      maxIos = null;
      supervised = true;
    };
    "allowUntrustedTLSPrompt" = {
      minIos = "5.0";
      maxIos = null;
      supervised = false;
    };
    "allowUSBRestrictedMode" = {
      minIos = "11.4.1";
      maxIos = null;
      supervised = true;
    };
    "allowVideoConferencing" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "allowVideoConferencingRemoteControl" = {
      minIos = "18.4";
      maxIos = null;
      supervised = true;
    };
    "allowVisualIntelligenceSummary" = {
      minIos = "18.3";
      maxIos = null;
      supervised = true;
    };
    "allowVoiceDialing" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "allowVPNCreation" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "allowWallpaperModification" = {
      minIos = "9.0";
      maxIos = null;
      supervised = true;
    };
    "allowWebDistributionAppInstallation" = {
      minIos = "17.5";
      maxIos = null;
      supervised = true;
    };
    "allowWritingTools" = {
      minIos = "18.0";
      maxIos = null;
      supervised = true;
    };
    "autonomousSingleAppModePermittedAppIDs" = {
      minIos = "7.0";
      maxIos = null;
      supervised = true;
    };
    "blacklistedAppBundleIDs" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
    "blockedAppBundleIDs" = {
      minIos = "15.0";
      maxIos = null;
      supervised = true;
    };
    "deniedICCIDsForiMessageFaceTime" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "deniedICCIDsForRCS" = {
      minIos = "26.0";
      maxIos = null;
      supervised = true;
    };
    "enforcedSoftwareUpdateDelay" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "forceAirDropUnmanaged" = {
      minIos = "9.0";
      maxIos = null;
      supervised = false;
    };
    "forceAirPlayOutgoingRequestsPairingPassword" = {
      minIos = "7.1";
      maxIos = null;
      supervised = false;
    };
    "forceAirPrintTrustedTLSRequirement" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "forceAssistantProfanityFilter" = {
      minIos = "5.0";
      maxIos = null;
      supervised = true;
    };
    "forceAuthenticationBeforeAutoFill" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "forceAutomaticDateAndTime" = {
      minIos = "12.0";
      maxIos = null;
      supervised = true;
    };
    "forceClassroomAutomaticallyJoinClasses" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "forceClassroomRequestPermissionToLeaveClasses" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "forceClassroomUnpromptedAppAndDeviceLock" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "forceClassroomUnpromptedScreenObservation" = {
      minIos = "11.0";
      maxIos = null;
      supervised = true;
    };
    "forceDelayedSoftwareUpdates" = {
      minIos = "11.3";
      maxIos = null;
      supervised = true;
    };
    "forceEncryptedBackup" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "forceITunesStorePasswordEntry" = {
      minIos = "6.0";
      maxIos = null;
      supervised = false;
    };
    "forceLimitAdTracking" = {
      minIos = "7.0";
      maxIos = null;
      supervised = false;
    };
    "forceOnDeviceOnlyDictation" = {
      minIos = "14.5";
      maxIos = null;
      supervised = false;
    };
    "forceOnDeviceOnlyTranslation" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "forcePreserveESIMOnErase" = {
      minIos = "17.2";
      maxIos = null;
      supervised = true;
    };
    "forceWatchWristDetection" = {
      minIos = "8.2";
      maxIos = null;
      supervised = false;
    };
    "forceWiFiPowerOn" = {
      minIos = "13.0";
      maxIos = null;
      supervised = true;
    };
    "forceWiFiToAllowedNetworksOnly" = {
      minIos = "14.5";
      maxIos = null;
      supervised = true;
    };
    "forceWiFiWhitelisting" = {
      minIos = "10.3";
      maxIos = null;
      supervised = true;
    };
    "ratingApps" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ratingAppsExemptedBundleIDs" = {
      minIos = "26.1";
      maxIos = null;
      supervised = false;
    };
    "ratingMovies" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ratingRegion" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "ratingTVShows" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "requireManagedPasteboard" = {
      minIos = "15.0";
      maxIos = null;
      supervised = false;
    };
    "safariAcceptCookies" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "safariAllowAutoFill" = {
      minIos = "4.0";
      maxIos = null;
      supervised = true;
    };
    "safariAllowJavaScript" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "safariAllowPopups" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "safariForceFraudWarning" = {
      minIos = "4.0";
      maxIos = null;
      supervised = false;
    };
    "whitelistedAppBundleIDs" = {
      minIos = "9.3";
      maxIos = null;
      supervised = true;
    };
  };
}
