# NAME

ios-configurations.nix - iOS Config Options

# DESCRIPTION

This document shows all available options for building iOS
configurations with the ios-configurations.nix flake.

# OPTIONS

**\_module.args**

> Additional arguments passed to each module in addition to ones like
> 'lib', 'config', and 'pkgs', 'modulesPath'.
>
> This option is also available to all submodules. Submodules do not
> inherit args from their parent module, nor do they provide args to
> their parent module or sibling submodules. The sole exception to this
> is the argument 'name' which is provided by parent modules to a
> submodule and contains the attribute name the submodule is bound to,
> or a unique generated name if it is not bound to an attribute.
>
> Some arguments are already passed by default, of which the following
> *cannot* be changed with this option:
>
> > **•** *lib*: The nixpkgs library.
>
> > **•** *config*: The results of all options after merging the values
> > from all modules together.
>
> > **•** *options*: The options declared in all modules.
>
> > **•** *specialArgs*: The 'specialArgs' argument passed to
> > 'evalModules'.
>
> > **•** All attributes of *specialArgs*
> >
> > Whereas option values can generally depend on other option values
> > thanks to laziness, this does not apply to 'imports', which must be
> > computed statically before anything else.
> >
> > For this reason, callers of the module system can provide
> > 'specialArgs' which are available during import resolution.
> >
> > For NixOS, 'specialArgs' includes *modulesPath*, which allows you to
> > import extra modules from the nixpkgs package tree without having to
> > somehow make the module aware of the location of the 'nixpkgs' or
> > NixOS directories.
> >
> > > { modulesPath, ... }: {
> > >       imports = [
> > >         (modulesPath + "/profiles/minimal.nix")
> > >       ];
> > >     }
>
> For NixOS, the default value for this option includes at least this
> argument:
>
> > **•** *pkgs*: The nixpkgs package set according to the
> > **nixpkgs.pkgs** option.
>
> *Type:* lazy attribute set of raw value
>
> *Default:*
>
> > { }

**deploy.profileDeployCmd**

> The commands to deploy the profile to a device. This is used by the
> deploy script.
>
> default: 'ios profile add \<profile\> \[\--udid \<udid\>\]'
>
> *Type:* strings concatenated with "\\n"
>
> *Default:*
>
> > ''
> >     ios profile add ${config.profiles.mobileconfig} \
> >       ${optionalString (config.target.udid != null) "--udid ${config.target.udid}"}
> >     ''

**deploy.script**

> The script that deploys the config to a device.
>
> *Type:* package *(read only)*

**profiles.enable**

> Whether to enable Enable deploying profiles to iOS devices.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.PayloadDisplayName**

> The display name when viewing this config/profile in Settings
>
> *Type:* string
>
> *Default:*
>
> > "Config from iosConfigurations.nix"

**profiles.PayloadIdentifier**

> The payload identifier for this config
>
> *Type:* string
>
> *Default:*
>
> > "ios-configurations"

**profiles.PayloadType**

> The payload type for this config
>
> *Type:* string
>
> *Default:*
>
> > "Configuration"

**profiles.PayloadUUID**

> The payload UUID for this config
>
> *Type:* string
>
> *Default:*
>
> > "82bc8a73-3345-4154-817a-45b7993d3492"

**profiles.PayloadVersion**

> The payload version for this config
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.airplay**

> The payload that configures AirPlay settings.
>
> macOS supports more than one payload, iOS does not. Supported on the
> user channel for macOS only.
>
> *Type:* submodule

**profiles.airplay.enable**

> Whether to enable Enable the com.apple.airplay profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.airplay.AllowList**

> If present, only AirPlay destinations in this list are available to
> the device. This allow list applies to supervised devices.
>
> Requires: iOS \>= 14.5; supervised device
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.airplay.AllowList.\*.DeviceID**

> The device ID of the AirPlay destination in the format
> 'xx:xx:xx:xx:xx:xx'. This field isn't case-sensitive.
>
> The system limits the list of visible AirPlay destinations to devices
> that are present in the 'AllowList' field of all installed AirPlay
> payloads.
>
> Specifying the same MACAddress more than once, whether in the same
> payload across different payloads, results in undefined behavior.
>
> As of tvOS 18, 'DeviceID' isn't supported.
>
> Requires: iOS \>= 7.0; supervised device\
> Deprecated in iOS 18.0
>
> *Type:* null or string matching the pattern
> \^(\[0-9A-Fa-f\]{2}:){5}(\[0-9A-Fa-f\]{2})\$
>
> *Default:*
>
> > null

**profiles.airplay.AllowList.\*.DeviceName**

> The name of the AirPlay device.
>
> The system limits the list of visible AirPlay destinations to devices
> that are present in the 'AllowList' field of all installed AirPlay
> payloads.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.airplay.Passwords**

> If present, sets passwords for known AirPlay destinations. Using
> multiple entries for the same destination, whether within the same
> payload or across multiple installed payloads, is an error and results
> in undefined behavior.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.airplay.Passwords.\*.DeviceName**

> The name of the AirPlay destination; used in iOS, and available in
> macOS 15 and later.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.airplay.Passwords.\*.Password**

> The password for the AirPlay destination.
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.airplay.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.airplay.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.airplay"

**profiles.airplay.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.airplay.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.airplay.Whitelist**

> Use 'AllowList' instead. This key is deprecated in iOS 14.5 and macOS
> 11.3.
>
> Requires: iOS \>= 7.0; supervised device\
> Deprecated in iOS 14.5
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.airplay.Whitelist.\*.DeviceID**

> The device ID of the AirPlay destination in the format
> 'xx:xx:xx:xx:xx:xx'. This field isn't case-sensitive.
>
> The system limits the list of visible AirPlay destinations to devices
> that are present in the 'AllowList' field of all installed AirPlay
> payloads.
>
> Specifying the same MACAddress more than once, whether in the same
> payload across different payloads, results in undefined behavior.
>
> As of tvOS 18, 'DeviceID' isn't supported.
>
> Requires: iOS \>= 7.0; supervised device\
> Deprecated in iOS 18.0
>
> *Type:* null or string matching the pattern
> \^(\[0-9A-Fa-f\]{2}:){5}(\[0-9A-Fa-f\]{2})\$
>
> *Default:*
>
> > null

**profiles.airplay.Whitelist.\*.DeviceName**

> The name of the AirPlay device.
>
> The system limits the list of visible AirPlay destinations to devices
> that are present in the 'AllowList' field of all installed AirPlay
> payloads.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.airprint**

> The payload that configures AirPrint printer discoverability in the
> user's printer list.
>
> *Type:* submodule

**profiles.airprint.enable**

> Whether to enable Enable the com.apple.airprint profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.airprint.AirPrint**

> An array of AirPrint printers that are presented to the user.
>
> Requires: iOS \>= 7.0
>
> *Type:* list of (submodule)

**profiles.airprint.AirPrint.\*.ForceTLS**

> If 'true', AirPrint connections are secured by Transport Layer
> Security (TLS). Available only in iOS 11 and later.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.airprint.AirPrint.\*.IPAddress**

> The IP address or hostname of the AirPrint destination.
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.airprint.AirPrint.\*.Port**

> The listening port of the AirPrint destination. Available only in iOS
> 11 and later.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or integer between 0 and 65535 (both inclusive)
>
> *Default:*
>
> > null

**profiles.airprint.AirPrint.\*.ResourcePath**

> The resource path associated with the printer. This path corresponds
> to the 'rp' parameter of the '\_ipps.tcp' Bonjour record. For example:
>
> > **•** 'printers/Canon_MG5300_series'
>
> > **•** 'printers/Xerox_Phaser_7600'
>
> > **•** 'ipp/print'
>
> > **•** 'Epson_IPP_Printer'
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.airprint.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.airprint.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.airprint"

**profiles.airprint.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.airprint.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.apn.managed**

> The payload that configures access point names.
>
> Not supported in macOS. This technically does install on watchOS but
> we are removing the supportedOS dictionary. The cellular payload
> should be used instead. Only applies to the preferred data SIM.
> Deprecated. Use Cellular instead.
>
> This profile is deprecated. Use the 'Cellular' profile instead.
>
> *Type:* submodule

**profiles.apn.managed.enable**

> Whether to enable Enable the com.apple.apn.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.apn.managed.DefaultsData**

> The list of access point names (APNs).
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* submodule

**profiles.apn.managed.DefaultsData.apns**

> An array of APN dictionaries (\`APN.DefaultsData.Apns\`).
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* list of (submodule)

**profiles.apn.managed.DefaultsData.apns.\*.apn**

> The access point name.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* string

**profiles.apn.managed.DefaultsData.apns.\*.password**

> The password for the user. For obfuscation purposes, the system
> encodes the password. If missing, the device prompts for the password
> during profile installation.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.apn.managed.DefaultsData.apns.\*.proxy**

> The IP address or URL of the APN proxy.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.apn.managed.DefaultsData.apns.\*.proxyPort**

> The port number of the APN proxy.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.apn.managed.DefaultsData.apns.\*.username**

> The user name. If missing, the device prompts for it during profile
> installation.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.apn.managed.DefaultsDomainName**

> The domain name.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* value "com.apple.managedCarrier" (singular enum)

**profiles.apn.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.apn.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.apn.managed"

**profiles.apn.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.apn.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.app.lock**

> The payload that configures a device to run a single app.
>
> With an app lock profile, the device locks to the specified app until
> removal of the profile. The device returns to the app automatically
> upon wake or restart.
>
> Only use an app lock payload after installing the target app.
>
> *Type:* submodule

**profiles.app.lock.enable**

> Whether to enable Enable the com.apple.app.lock profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.app.lock.App**

> A dictionary that contains information about the app.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* submodule

**profiles.app.lock.App.Identifier**

> The app's bundle identifier.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* string

**profiles.app.lock.App.Options**

> A dictionary of options that the user can't change.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableAutoLock**

> If 'true', the device doesn't automatically go to sleep after an idle
> period.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableDeviceRotation**

> If 'true', the system disables device rotation sensing.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableRingerSwitch**

> If 'true', the system disables the ringer switch. When disabled, the
> ringer behavior depends on what position the switch was in when it was
> first disabled.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableSleepWakeButton**

> If 'true', the system disables the sleep/wake button.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableTouch**

> If 'true', the system disables the touch screen. In tvOS, it disables
> the touch surface on the Apple TV Remote.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.DisableVolumeButtons**

> If 'true', the system disables the volume buttons.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableAssistiveTouch**

> If 'true', the system enables AssistiveTouch.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableInvertColors**

> If 'true', the system enables Invert Colors.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableMonoAudio**

> If 'true', the system enables Mono Audio.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableSpeakSelection**

> If 'true', the system enables Speak Selection.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableVoiceControl**

> If 'true', the system enables Voice Control.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableVoiceOver**

> If 'true', the system enables VoiceOver.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.Options.EnableZoom**

> If 'true', the system enables Zoom.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions**

> A dictionary of user-editable options.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions.AssistiveTouch**

> If 'true', the system allows the user to toggle AssistiveTouch.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions.InvertColors**

> If 'true', the system allows the user to toggle Invert Colors.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions.VoiceControl**

> If 'true', the system allows the user to toggle Voice Control.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions.VoiceOver**

> If 'true', the system allows the user to toggle VoiceOver.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.App.UserEnabledOptions.Zoom**

> If 'true', the system allows the user to toggle Zoom.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.app.lock.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.app.lock.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.app.lock"

**profiles.app.lock.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.app.lock.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.applicationaccess**

> The payload that configures restrictions on a device.
>
> > *""* Important: The system allows multiple Restrictions payloads.
> > However, don't attempt to manage the same restriction in different
> > payloads. Doing so results in unexpected behavior.
>
> *Type:* submodule

**profiles.applicationaccess.enable**

> Whether to enable Enable the com.apple.applicationaccess profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.applicationaccess.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.applicationaccess.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.applicationaccess"

**profiles.applicationaccess.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.applicationaccess.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.applicationaccess.allowAccountModification**

> If 'false', the system disables modification of accounts, such as
> Apple Accounts, and internet-based accounts, such as Mail, Contacts,
> and Calendar.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowActivityContinuation**

> If 'false', the system disables activity continuation. Support for
> this restriction on unsupervised devices and with Managed Apple
> Accounts is deprecated. In a future release, this restriction will
> begin requiring supervision and will apply to personal Apple Accounts
> only.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAddingGameCenterFriends**

> If 'false', the system prohibits adding friends to Game Center.
> Requires a supervised device in iOS 13 and later.
>
> Requires: iOS \>= 4.2.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAirDrop**

> If 'false', the system disables AirDrop.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAirPrint**

> If 'false', the system disables AirPrint.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAirPrintCredentialsStorage**

> If 'false', the system disables Keychain storage of user name and
> password for AirPrint.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAirPrintiBeaconDiscovery**

> If 'false', the system disables iBeacon discovery of AirPrint
> printers, which prevents spurious AirPrint Bluetooth beacons from
> phishing for network traffic.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppCellularDataModification**

> If 'false', the system disables changing settings for cellular data
> usage for apps.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppClips**

> If 'false', the system prevents a user from adding any App Clips, and
> removes any existing App Clips on the device.
>
> Requires: iOS \>= 14.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppInstallation**

> If 'false', the system disables the App Store and removes its icon
> from the Home Screen. Users are unable to install or update their
> apps. This applies to App Store apps, marketplace apps, and locally
> installed apps (using Configurator, Xcode, and so forth).
>
> In iOS 10 and later, MDM commands can override this restriction.
> Requires a supervised device in iOS 13 and later.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppRemoval**

> If 'false', the system disables removal of apps from an iOS device.
> This applies to App Store apps, marketplace apps, and locally
> installed apps (using Configurator, Xcode, and so forth).
>
> Requires: iOS \>= 4.2.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppleIntelligenceReport**

> If 'false', the system disables Apple Intelligence reports.
>
> Requires: iOS \>= 18.4; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowApplePersonalizedAdvertising**

> If 'false', the system limits Apple personalized advertising.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppsToBeHidden**

> If 'false', disables the ability for the user to hide apps. It doesn't
> affect the user's ability to leave it in the App Library, while
> removing it from the Home Screen.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAppsToBeLocked**

> If 'false', disables the ability for the user to lock apps. Because
> hiding apps also requires locking them, disallowing locking also
> disallows hiding.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAssistant**

> If 'false', the system disables Siri.
>
> Requires: iOS \>= 5.0\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAssistantUserGeneratedContent**

> If 'false', the system prevents Siri from querying user- generated
> content from the web.
>
> Requires: iOS \>= 7.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAssistantWhileLocked**

> If 'false', the system disables Siri when the device is locked. The
> system ignores this restriction if the device doesn't have a passcode
> set.
>
> Requires: iOS \>= 5.1\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAutoCorrection**

> If 'false', the system disables keyboard autocorrection.
>
> Requires: iOS \>= 8.1.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAutoDim**

> If 'false', disables auto dim on iPads with OLED displays.
>
> Requires: iOS \>= 17.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAutoUnlock**

> If 'false', the system disallows auto unlock. Support for this
> restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 14.5
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowAutomaticAppDownloads**

> If 'false', the system prevents automatic downloading of apps
> purchased on other devices. This setting doesn't affect updates to
> existing apps.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowBluetoothModification**

> If 'false', the system prevents modification of Bluetooth settings.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowBookstore**

> If 'false', the system removes the Book Store tab from the Books app.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowBookstoreErotica**

> If 'false', the system prevents the user from downloading Apple Books
> media that's tagged as erotica. Support for this restriction on
> unsupervised devices is deprecated.
>
> Requires: iOS \>= 6.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCallRecording**

> If 'false', disables call recording.
>
> Requires: iOS \>= 18.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCamera**

> If 'false', the system disables the camera and removes its icon from
> the Home Screen, and users are unable to take photographs. Support for
> this restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCellularPlanModification**

> If 'false', the system prevents users from changing settings related
> to their cellular plan (available only on select carriers).
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowChat**

> If 'false', the system disables the use of iMessage with supervised
> devices. If the device supports text messaging, the user can still
> send and receive text messages.
>
> Requires: iOS \>= 5.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCloudBackup**

> If 'false', the system disables backing up the device to iCloud.
> Support for this restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCloudDocumentSync**

> If 'false', the system disables document and key-value syncing to
> iCloud. Requires a supervised device in iOS 13 and later, and Shared
> iPad doesn't support it. Support for this restriction on unsupervised
> devices and with Managed Apple Accounts is deprecated.
>
> Requires: iOS \>= 5.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCloudKeychainSync**

> If 'false', the system disables iCloud Keychain synchronization.
> Support for this restriction on unsupervised devices and with Managed
> Apple Accounts is deprecated.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCloudPhotoLibrary**

> If 'false', the system disables iCloud Photo Library. The system
> removes any photos from local storage that aren't fully downloaded
> from iCloud Photo Library to the device. Support for this restriction
> on unsupervised devices and with Managed Apple Accounts is deprecated.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowCloudPrivateRelay**

> If 'false', the system disables iCloud Private Relay. Support for this
> restriction on unsupervised devices and with Managed Apple Accounts is
> deprecated.
>
> Requires: iOS \>= 15.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowContinuousPathKeyboard**

> If 'false', the system disables QuickPath keyboard.
>
> Requires: iOS \>= 13.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDefaultBrowserModification**

> If 'false', disables default browser preference modification. The MDM
> Settings command to set the default browser preference still works
> when applying this.
>
> Requires: iOS \>= 18.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDefaultCallingAppModification**

> If 'false', disables default calling app preference modification. The
> MDM Settings command to set the default calling app preference still
> works when applying this.
>
> Requires: iOS \>= 18.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDefaultMessagingAppModification**

> If 'false', disables default messaging app preference modification.
> The MDM Settings command to set the default messaging app preference
> still works when applying this.
>
> Requires: iOS \>= 18.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDefinitionLookup**

> If 'false', the system disables definition lookup.
>
> Requires: iOS \>= 8.1.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDeviceNameModification**

> If 'false', the system prevents the user from changing the device
> name.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDiagnosticSubmission**

> If 'false', the system prevents the device from automatically
> submitting diagnostic reports to Apple.
>
> Requires: iOS \>= 6.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDiagnosticSubmissionModification**

> If 'false', the system disables changing the diagnostic submission and
> app analytics settings in the Diagnostics & Usage UI in Settings.
>
> Requires: iOS \>= 9.3.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowDictation**

> If 'false', the system disallows dictation input.
>
> Requires: iOS \>= 10.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowESIMModification**

> If 'false', the system disables modifications of eSIMs.
>
> Requires: iOS \>= 12.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowESIMOutgoingTransfers**

> If 'false', prevents the transfer of an eSIM from the device on which
> the restriction is installed to a different device.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowEnablingRestrictions**

> If 'false', the system disables the Enable Restrictions option in the
> Restrictions UI in Settings. If 'false' in iOS 12 and later, the
> system disables the Enable ScreenTime option in the ScreenTime UI in
> Settings and disables ScreenTime if already enabled.
>
> Requires: iOS \>= 8.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowEnterpriseAppTrust**

> If 'false', the system removes the Trust Enterprise Developer button
> in Settings \> General \> VPN & Device Management, which prevents
> provisioning apps by universal provisioning profiles. This restriction
> applies to free developer accounts and enterprise app developers that
> aren't implicitly trusted by apps that install through MDM. This
> restriction doesn't revoke previously granted trust.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowEnterpriseBookBackup**

> If 'false', the system disables backup of Enterprise books.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowEnterpriseBookMetadataSync**

> If 'false', the system disables sync of Enterprise books, notes, and
> highlights.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowEraseContentAndSettings**

> If 'false', the system disables the Erase All Content and Settings
> option in the Reset UI.
>
> Requires: iOS \>= 8.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowExplicitContent**

> If 'false', the system hides explicit music or video content purchased
> from the iTunes Store. The system marks explicit content as such by
> content providers, such as record labels, when sold through the iTunes
> Store. Explicit content in the News and Podcast apps is also hidden.
>
> Requires a supervised device in iOS 13 and later. Support for this
> restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowExternalIntelligenceIntegrations**

> If 'false', disables the use of external, cloud-based intelligence
> services with Siri. In iOS, this restriction is temporarily allowed on
> unsupervised and user enrollments. In a future release, this
> restriction will require supervision, and will be ignored on
> unsupervised devices.
>
> Requires: iOS \>= 18.2\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowExternalIntelligenceIntegrationsSignIn**

> If 'false', forces external intelligence providers into anonymous
> mode. If a user is already signed in to an external intelligence
> provider, applying this restriction signs them out when attempting the
> next request.
>
> Requires: iOS \>= 18.2\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFilesNetworkDriveAccess**

> If 'false', the system prevents connecting to network drives in the
> Files app.
>
> Requires: iOS \>= 13.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFilesUSBDriveAccess**

> If 'false', the system prevents connecting to any connected USB
> devices in the Files app.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFindMyDevice**

> If 'false', the system disables Find My Device in the Find My app.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFindMyFriends**

> If 'false', the system disables Find My Friends in the Find My app.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFindMyFriendsModification**

> If 'false', the system disables changes to Find My Friends.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFingerprintForUnlock**

> If 'false', the system prevents Touch ID, Face ID, or Optic ID from
> unlocking a device. Support for this restriction on unsupervised
> devices is deprecated.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowFingerprintModification**

> If 'false', the system prevents the user from modifying Touch ID or
> Face ID.
>
> Requires: iOS \>= 8.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowGameCenter**

> If 'false', the system disables Game Center, and the system removes
> its icon from the Home Screen.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowGenmoji**

> If 'false', prohibits creating new Genmoji.
>
> Requires: iOS \>= 18.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowGlobalBackgroundFetchWhenRoaming**

> If 'false', the system disables global background fetch activity when
> an iOS phone is roaming. Support for this restriction on unsupervised
> devices is deprecated.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowHostPairing**

> If 'false', the system disables host pairing with the exception of the
> supervision host. If there's no configured supervision host
> certificate, the system disables all pairing. Host pairing lets the
> administrator control whether an iOS device can pair with a host Mac
> or PC.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowImagePlayground**

> If 'false', prohibits the use of image generation.
>
> Requires: iOS \>= 18.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowImageWand**

> If 'false', prohibits the use of Image Wand.
>
> Requires: iOS \>= 18.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowInAppPurchases**

> If 'false', the system prohibits in-app purchasing. Support for this
> restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowKeyboardShortcuts**

> If 'false', the system disables keyboard shortcuts.
>
> Requires: iOS \>= 9.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowListedAppBundleIDs**

> If present, the system only shows or can launch apps with bundle IDs
> in the array. Include the value 'com.apple.webapp' to allow all
> webclips. This applies to App Store apps, marketplace apps, and
> locally installed apps (using Configurator, Xcode, and so forth).
>
> Requires: iOS \>= 15.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowLiveVoicemail**

> If 'false', the system disables live voicemail on the device.
>
> Requires: iOS \>= 17.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowLockScreenControlCenter**

> If 'false', the system prevents Control Center from appearing on the
> Lock Screen.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowLockScreenNotificationsView**

> If 'false', the system disables the Notifications history view on the
> Lock Screen, so users can't view past notifications. However, they can
> still see notifications when they arrive.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowLockScreenTodayView**

> If 'false', the system disables the Today view in Notification Center
> on the Lock Screen.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMailPrivacyProtection**

> If 'false', the system disables Mail Privacy Protection on the device.
>
> Requires: iOS \>= 15.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMailSmartReplies**

> If 'false', disables smart replies in Mail.
>
> Requires: iOS \>= 18.4; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMailSummary**

> If 'false', disables the ability to create summaries of email messages
> manually. This doesn't affect automatic summary generation.
>
> Requires: iOS \>= 18.1; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowManagedAppsCloudSync**

> If 'false', the system prevents managed apps from using iCloud sync.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowManagedToWriteUnmanagedContacts**

> If 'true', the system allows managed apps to write contacts to
> unmanaged accounts. If 'allowOpenFromManagedToUnmanaged' is 'true',
> this restriction has no effect.
>
> > *""* Important: Use MDM to install profiles that contain this
> > restriction.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMarketplaceAppInstallation**

> If 'false', the system prevents installation of alternative
> marketplace apps from the web and prevents any installed alternative
> marketplace apps from installing apps.
>
> Requires: iOS \>= 17.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMultiplayerGaming**

> If 'false', the system prohibits multiplayer gaming.
>
> Requires: iOS \>= 4.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowMusicService**

> If 'false', the system disables the Music service, and the Music app
> reverts to classic mode.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowNFC**

> If 'false', the system disables NFC.
>
> Requires: iOS \>= 14.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowNews**

> If 'false', the system disables News.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowNotesTranscription**

> If 'false', disables transcription in Notes.
>
> Requires: iOS \>= 18.4; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowNotesTranscriptionSummary**

> If 'false', disables transcription summarization in Notes.
>
> Requires: iOS \>= 18.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowNotificationsModification**

> If 'false', the system disables modification of notification settings.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowOTAPKIUpdates**

> If 'false', the system disables over-the-air PKI updates. Setting this
> restriction to 'false' doesn't disable CRL and OCSP checks.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowOpenFromManagedToUnmanaged**

> If 'false', documents in managed apps and accounts open only in other
> managed apps and accounts.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowOpenFromUnmanagedToManaged**

> If 'false', documents in unmanaged apps and accounts open only in
> other unmanaged apps and accounts.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPairedWatch**

> If 'false', the system disables pairing with an Apple Watch, and the
> system unpairs any currently paired Apple Watch and erases its
> content.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPassbookWhileLocked**

> If 'false', the system hides Passbook notifications from the Lock
> Screen.
>
> Requires: iOS \>= 6.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPasscodeModification**

> If 'false', the system prevents adding, changing, or removing the
> passcode. The system ignores this restriction on Shared iPad.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPasswordAutoFill**

> If 'false', the system disables:
>
> > **•** The AutoFill Passwords feature in iOS, with Keychain and
> > third-party password managers
>
> > **•** Prompting the user to use a saved password in Safari or in
> > apps
>
> > **•** Automatic strong passwords
>
> > **•** Suggesting strong passwords to users
>
> However, if 'false', the system doesn't prevent AutoFill for contact
> info and credit cards in Safari.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPasswordProximityRequests**

> If 'false', the system disables requesting passwords from nearby
> devices.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPasswordSharing**

> If 'false', the system disables sharing passwords with the AirDrop
> passwords feature, or with the Passwords app.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPersonalHotspotModification**

> If 'false', the system disables modifications of the personal hotspot
> setting.
>
> Requires: iOS \>= 12.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPersonalizedHandwritingResults**

> If false, prevents the system from generating text in the user's
> handwriting.
>
> Requires: iOS \>= 18.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPhotoStream**

> If 'false', the system disables Photo Stream.
>
> Requires: iOS \>= 5.0\
> Deprecated in iOS 17.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPodcasts**

> If 'false', the system disables podcasts.
>
> Requires: iOS \>= 8.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowPredictiveKeyboard**

> If 'false', the system disables predictive keyboards.
>
> Requires: iOS \>= 8.1.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowProximitySetupToNewDevice**

> If 'false', disables the prompt to set up new devices that are nearby.
> Starting with iOS 26.3, this also prevents exporting iOS data to set
> up new Android devices.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowRCSMessaging**

> If 'false', prevents the use of RCS messaging.
>
> Requires: iOS \>= 18.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowRadioService**

> If 'false', the system disables Apple Music Radio.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowRapidSecurityResponseInstallation**

> If 'false', the system prohibits installation of Background Security
> Improvements.
>
> Requires: iOS \>= 16.0; supervised device\
> Deprecated in iOS 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowRapidSecurityResponseRemoval**

> If 'false', the system prohibits removal of Background Security
> Improvements.
>
> Requires: iOS \>= 16.0; supervised device\
> Deprecated in iOS 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowRemoteScreenObservation**

> If 'false', the system disables remote screen observation by the
> Classroom app. Nest this key beneath 'allowScreenShot' as a
> subrestriction. If 'allowScreenShot' is 'false', the Classroom app
> doesn't observe remote screens. Requires a supervised device until iOS
> 13 and macOS 10.15. Allowed for user enrollments in macOS 12 and
> later.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSafari**

> If 'false', the system disables the Safari web browser app, and the
> system removes its icon from the Home Screen. This setting also
> prevents users from opening web clips. Requires a supervised device in
> iOS 13 and later.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSafariHistoryClearing**

> If 'false', the system disables the ability to clear browsing history
> in Safari.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSafariPrivateBrowsing**

> If 'false', the system disables the ability to use private browsing in
> Safari.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSafariSummary**

> If 'false', the system disables the ability to summarize content in
> Safari.
>
> Requires: iOS \>= 18.4; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSatelliteConnection**

> If 'false', the system prohibits the connection to and use of
> satellite services.
>
> Requires: iOS \>= 18.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowScreenShot**

> If 'false', the system disables saving a screenshot of the display and
> capturing a screen recording. It also disables the Classroom app from
> observing remote screens.
>
> Requires: iOS \>= 3.1
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSharedDeviceTemporarySession**

> If 'false', the system makes temporary sessions unavailable on Shared
> iPad.
>
> Requires: iOS \>= 13.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSharedStream**

> If 'false', the system disables Shared Photo Stream. Support for this
> restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 6.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSpellCheck**

> If 'false', the system disables the keyboard spell checker.
>
> Requires: iOS \>= 8.1.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSpotlightInternetResults**

> If 'false', the system disables Spotlight Internet search results in
> Siri Suggestions. Support for this restriction on unsupervised devices
> is deprecated.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowSystemAppRemoval**

> If 'false', the system disables the removal of system apps from the
> device.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUIAppInstallation**

> If 'false', the system disables the App Store and removes its icon
> from the Home Screen. However, users can continue to install or update
> their apps either locally (via Configurator, Xcode, and so forth), or
> using alternative marketplace apps.
>
> In iOS 10 and later, MDM commands can override this restriction.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUIConfigurationProfileInstallation**

> If 'false', the system prohibits the user from installing
> configuration profiles and certificates interactively.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUSBRestrictedMode**

> If 'false', the system allows iOS devices to always connect to USB
> accessories while locked. In macOS, allows new USB and Thunderbolt
> accessories, and SD cards to connect without authorization. If the
> system has Lockdown mode enabled, it ignores this value. This
> restriction is not supported on the user channel.
>
> Requires: iOS \>= 11.4.1; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUnmanagedToReadManagedContacts**

> If 'true', the system allows unmanaged apps to read from managed
> contacts accounts. If 'allowOpenFromManagedToUnmanaged' is 'true',
> this restriction has no effect.
>
> > *""* Important: Use MDM to install profiles that contain this
> > restriction.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUnpairedExternalBootToRecovery**

> If 'true', the system allows unpaired devices to boot devices into
> recovery.
>
> Requires: iOS \>= 14.5; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowUntrustedTLSPrompt**

> If 'false', the system automatically rejects untrusted HTTPS
> certificates without prompting the user.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowVPNCreation**

> If 'false', the system allows only managed apps to create VPN
> configurations. Prior to iOS 18, the system also allows unmanaged apps
> to create VPN configurations.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowVideoConferencing**

> If 'false', the system hides the FaceTime app. Requires a supervised
> device in iOS 13 and later.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowVideoConferencingRemoteControl**

> If 'false', disables the ability for a remote FaceTime session to
> request control of the device.
>
> Requires: iOS \>= 18.4; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowVisualIntelligenceSummary**

> If 'false', the system disables visual intelligence summarization.
>
> Requires: iOS \>= 18.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowVoiceDialing**

> If 'false', the system disables voice dialing if the device is locked
> with a passcode.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 17.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowWallpaperModification**

> If 'false', the system prevents changing the wallpaper.
>
> Requires: iOS \>= 9.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowWebDistributionAppInstallation**

> If 'false', the device prevents installation of apps directly from the
> web.
>
> Requires: iOS \>= 17.5; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowWritingTools**

> If 'false', disables Apple Intelligence writing tools.
>
> Requires: iOS \>= 18.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowedCameraRestrictionBundleIDs**

> If present, the system exempts apps with bundle IDs in the array from
> the 'allowCamera' restriction. The system doesn't grant these apps
> access to the camera automatically; they're only exempted from the
> 'allowCamera' restriction. This key has no effect when the camera
> isn't restricted. Multiple payloads combine using an intersect
> operation. Requires a supervised device.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowedExternalIntelligenceWorkspaceIDs**

> An array of strings, but currently restricted to a single element. If
> present, Apple Intelligence allows use of only the given external
> integration workspace ID, and requires a sign-in to make requests. The
> user is required to sign in to integrations that support signing in.
> Multiple payloads combine using an intersect operation. This means the
> allowed set of workspace IDs can become the empty set if multiple
> payloads specify conflicting values.
>
> Requires: iOS \>= 18.3; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowiPhoneMirroring**

> If 'false', prohibits the use of iPhone Mirroring. In macOS, this
> prevents the Mac from mirroring any iPhone. In iOS, this prevents the
> iPhone from mirroring to any Mac.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowiPhoneWidgetsOnMac**

> If 'false', the system disallows iPhone widgets on a Mac that signs in
> with the same Apple Account for iCloud.
>
> Requires: iOS \>= 17.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.allowiTunes**

> If 'false', the system disables the iTunes Music Store and removes its
> icon from the Home Screen. Users can't preview, purchase, or download
> content. Requires a supervised device in iOS 13 and later.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.autonomousSingleAppModePermittedAppIDs**

> If present, the system allows apps identified by the bundle IDs listed
> in the array to autonomously enter Single App Mode.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.blacklistedAppBundleIDs**

> Use 'blockedAppBundleIDs' instead.
>
> Requires: iOS \>= 9.3; supervised device\
> Deprecated in iOS 15.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.blockedAppBundleIDs**

> If present, the system prevents showing or launching apps with bundle
> IDs in the array. Include the value 'com.apple.webapp' to restrict all
> webclips. This applies to App Store apps, marketplace apps, and
> locally installed apps (using Configurator, Xcode, and so forth).
>
> > *""* Note: Denying system apps may disable other functionality. For
> > example, denying the App Store app may prevent users from accepting
> > the terms and conditions for the user-based Volume Purchase Program
> > (VPP).
>
> Requires: iOS \>= 15.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.deniedICCIDsForRCS**

> An array of strings representing ICCIDs of cellular plans. The device
> prevents use of any matching cellular networks with RCS messaging. The
> array must contain no more than 4 ICCID strings.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.deniedICCIDsForiMessageFaceTime**

> An array of strings representing ICCIDs of cellular plans. The device
> prevents use of any matching cellular networks in iMessage and
> FaceTime. The array must contain no more than 4 ICCID strings.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.enforcedSoftwareUpdateDelay**

> How many days to delay a software update on the device. With this
> restriction in place, the user doesn't see a software update until the
> specified number of days after the software update release date. The
> restrictions 'forceDelayedAppSoftwareUpdates' and
> 'forceDelayedSoftwareUpdates' use this value.
>
> Requires: iOS \>= 11.3; supervised device\
> Deprecated in iOS 26.0
>
> *Type:* null or integer between 1 and 90 (both inclusive)
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAirDropUnmanaged**

> If 'true', the system considers AirDrop to be an unmanaged drop
> target.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAirPlayOutgoingRequestsPairingPassword**

> If 'true', the system forces all devices receiving AirPlay requests
> from this device to use a pairing password.
>
> Requires: iOS \>= 7.1
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAirPrintTrustedTLSRequirement**

> If 'true', the system requires trusted certificates for TLS printing
> communication.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAssistantProfanityFilter**

> If 'true', the system forces the use of the profanity filter for Siri
> and dictation. Requires a supervised device in iOS.
>
> Requires: iOS \>= 5.0; supervised device\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAuthenticationBeforeAutoFill**

> If 'true', the user needs to authenticate before the system can
> autofill passwords or credit card information in Safari and apps. If
> this restriction isn't enforced, the user can toggle this feature in
> Settings. Only supported on devices with Face ID or Touch ID.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceAutomaticDateAndTime**

> If 'true', the system enables the Set Automatically feature in Date &
> Time and the user can't disable it. The system updates the device's
> time zone only when the device can determine its location using a
> cellular connection or Wi-Fi with location services enabled.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceClassroomAutomaticallyJoinClasses**

> If 'true', the system automatically gives permission to the teacher's
> requests without prompting the student.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceClassroomRequestPermissionToLeaveClasses**

> If 'true', a student enrolled in an unmanaged course through Classroom
> needs to request permission from the teacher to leave the course.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceClassroomUnpromptedAppAndDeviceLock**

> If 'true', the system allows the teacher to lock apps or the device
> without prompting the student.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceClassroomUnpromptedScreenObservation**

> If 'true' and 'ScreenObservationPermissionModificationAllowed' is also
> 'true' in the Education payload, a student enrolled in a managed
> course through the Classroom app automatically gives permission to
> that course teacher's requests to observe the student's screen without
> prompting the student.
>
> Requires: iOS \>= 11.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceDelayedSoftwareUpdates**

> If 'true', the system delays user visibility of software updates. In
> macOS, the system allows seed build updates without delay. The delay
> is 30 days unless you set 'enforcedSoftwareUpdateDelay' to another
> value.
>
> Requires: iOS \>= 11.3; supervised device\
> Deprecated in iOS 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceEncryptedBackup**

> If 'true', the system encrypts all backups.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceITunesStorePasswordEntry**

> If 'true', the system forces the user to enter their iTunes password
> for each transaction.
>
> Requires: iOS \>= 6.0\
> Deprecated in iOS 17.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceLimitAdTracking**

> If 'true', the system limits ad tracking. Additionally, it disables
> app tracking and the Allow Apps to Request to Track setting.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceOnDeviceOnlyDictation**

> If 'true', the system disables connections to Siri servers for the
> purposes of dictation.
>
> Requires: iOS \>= 14.5\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceOnDeviceOnlyTranslation**

> If 'true', the device can't connect to Siri servers for the purposes
> of translation.
>
> Requires: iOS \>= 15.0\
> Deprecated in iOS 26.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forcePreserveESIMOnErase**

> If 'true', the system preserves eSIM when it erases the device due to
> too many failed password attempts or the Erase All Content and
> Settings option in Settings \> General \> Reset.
>
> > *""* Note: The system doesn't preserve eSIM if Find My initiates
> > erasing the device.
>
> Requires: iOS \>= 17.2; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceWatchWristDetection**

> If 'true', the system forces a paired Apple Watch to use Wrist
> Detection.
>
> Requires: iOS \>= 8.2
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceWiFiPowerOn**

> If 'true', the system prevents turning off Wi-Fi in Settings or
> Control Center, even by entering or leaving Airplane Mode. It doesn't
> prevent selecting which Wi-Fi network to use. and later.
>
> Requires: iOS \>= 13.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceWiFiToAllowedNetworksOnly**

> If 'true', the system limits the device to only join Wi-Fi networks
> set up through a configuration profile.
>
> Requires: iOS \>= 14.5; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.forceWiFiWhitelisting**

> Use 'forceWiFiToAllowedNetworksOnly' instead.
>
> Requires: iOS \>= 10.3; supervised device\
> Deprecated in iOS 14.5
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.ratingApps**

> The maximum level of app content allowed on the device. Starting with
> iOS 26.2, this rating may apply to certain system apps.
>
> Age bands and the number of discrete age values vary by region, but
> the values are consistent across regions. For example, in a region
> that defines rating level 14+, its value is guaranteed to be larger
> than 300 (12+) and smaller than 600 (17+). Also, the value of rating
> level 15+ is guaranteed to be larger than the assigned value of rating
> level 14+. For more information about age ratings, see \[Age ratings
> values and definitions\](https://developer.apple.com/help/app-store-
> connect/reference/age-ratings-values-and-definitions).
>
> Below is the complete list of age rating values used across all App
> Store regions.
>
> > **•** '1000': All
>
> > **•** '621': 21+
>
> > **•** '620': 20+
>
> > **•** '619': 19+
>
> > **•** '618': 18+
>
> > **•** '600': 17+
>
> > **•** '416': 16+
>
> > **•** '415': 15+
>
> > **•** '314': 14+
>
> > **•** '313': 13+
>
> > **•** '300': 12+
>
> > **•** '211': 11+
>
> > **•** '210': 10+
>
> > **•** '200': 9+
>
> > **•** '108': 8+
>
> > **•** '107': 7+
>
> > **•** '106': 6+
>
> > **•** '105': 5+
>
> > **•** '100': 4+
>
> > **•** '3': 3+
>
> > **•** '2': 2+
>
> > **•** '1': 1+
>
> > **•** '0': None
>
> This restriction will require supervision in a future release.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 1000 (both inclusive)
>
> *Default:*
>
> > null

**profiles.applicationaccess.ratingAppsExemptedBundleIDs**

> If present, the system exempts apps with bundle IDs in the array from
> age-based rating restrictions. The system uses intersection combine
> rules to combine multiple payloads and any exceptions that parental
> control apps provide, including ScreenTime.
>
> Requires: iOS \>= 26.1
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.applicationaccess.ratingMovies**

> The maximum level of movie content allowed on the device. Support for
> this restriction on unsupervised devices is deprecated.
>
> Possible values, with the U.S. description of the rating level:
>
> > **•** '1000': All
>
> > **•** '500': NC-17
>
> > **•** '400': R
>
> > **•** '300': PG-13
>
> > **•** '200': PG
>
> > **•** '100': G
>
> > **•** '0': None
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 1000 (both inclusive)
>
> *Default:*
>
> > null

**profiles.applicationaccess.ratingRegion**

> The two-letter key that profile tools use to display the proper
> ratings for the given region. The client doesn't recognize or report
> this data.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "us", "au", "ca", "de", "fr", "ie", "jp", "nz",
> "gb"
>
> *Default:*
>
> > null

**profiles.applicationaccess.ratingTVShows**

> The maximum level of TV content allowed on the device. Support for
> this restriction on unsupervised devices is deprecated.
>
> Possible values, with the U.S. description of the rating level:
>
> > **•** '1000': All
>
> > **•** '600': TV-MA
>
> > **•** '500': TV-14
>
> > **•** '400': TV-PG
>
> > **•** '300': TV-G
>
> > **•** '200': TV-Y7
>
> > **•** '100': TV-Y
>
> > **•** '0': None
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 1000 (both inclusive)
>
> *Default:*
>
> > null

**profiles.applicationaccess.requireManagedPasteboard**

> If 'true', copy-and-paste functionality is limited by the
> 'allowOpenFromManagedToUnmanaged' and
> 'allowOpenFromUnmanagedToManaged' restrictions.
>
> Requires: iOS \>= 15.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.safariAcceptCookies**

> Defines the conditions under which the device accepts cookies. The
> user-facing settings changed in iOS 11, although the possible values
> remain the same. Support for this restriction on unsupervised devices
> is deprecated. Allowed values:
>
> > **•** '0': Enables Prevent Cross-Site Tracking and Block All
> > Cookies, and the user canʼt disable either setting.
>
> > **•** '1' or '1.5': Enables Prevent Cross-Site Tracking, and the
> > user canʼt disable it. Doesn't enable Block All Cookies, but the
> > user can enable it.
>
> > **•** '2': Enables Prevent Cross-Site Tracking, but doesn't enable
> > Block All Cookies. The user can toggle either setting.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of \<float\>, \<float\>, \<float\>, \<float\>
>
> *Default:*
>
> > null

**profiles.applicationaccess.safariAllowAutoFill**

> If 'false', the system disables Safari AutoFill for passwords, contact
> info, and credit cards, and also prevents using the Keychain for
> AutoFill. Requires a supervised device in iOS 13 and later.
>
> > *""* Note: The system still allows third-party password managers,
> > and apps can use AutoFill.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.safariAllowJavaScript**

> If 'false', Safari doesn't execute JavaScript. This restriction will
> require supervision in a future release.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.safariAllowPopups**

> If 'false', Safari doesn't allow pop-up windows. Support for this
> restriction on unsupervised devices is deprecated.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.safariForceFraudWarning**

> If 'true', the system enables Safari fraud warning.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.applicationaccess.whitelistedAppBundleIDs**

> Use 'allowListedAppBundleIDs' instead.
>
> Requires: iOS \>= 9.3; supervised device\
> Deprecated in iOS 15.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.assertions.\*.assertion**

> This option has no description.
>
> *Type:* boolean

**profiles.assertions.\*.message**

> This option has no description.
>
> *Type:* string

**profiles.caldav.account**

> The payload that configures a Calendar account.
>
> *Type:* submodule

**profiles.caldav.account.enable**

> Whether to enable Enable the com.apple.caldav.account profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.caldav.account.CalDAVAccountDescription**

> The description of the account.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.caldav.account.CalDAVHostName**

> The server's address.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.caldav.account.CalDAVPassword**

> The user's password. Only use this in encrypted profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.caldav.account.CalDAVPort**

> The server's port.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.caldav.account.CalDAVPrincipalURL**

> The base URL to the user's calendar.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.caldav.account.CalDAVUseSSL**

> If 'true', the system enables SSL.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.caldav.account.CalDAVUsername**

> The user name for logins. If this profile is part of a non-
> interactive install, the system requires this field.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.caldav.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.caldav.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.caldav.account"

**profiles.caldav.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.caldav.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.caldav.account.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account**

> The payload that configures a Contacts account.
>
> *Type:* submodule

**profiles.carddav.account.enable**

> Whether to enable Enable the com.apple.carddav.account profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.carddav.account.CardDAVAccountDescription**

> The description of the account.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account.CardDAVHostName**

> The server's address.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.carddav.account.CardDAVPassword**

> The user's password. Only use this in encrypted profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account.CardDAVPort**

> The server's port.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.carddav.account.CardDAVPrincipalURL**

> The base URL to the user's address book.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account.CardDAVUseSSL**

> If 'true', the system enables SSL.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.carddav.account.CardDAVUsername**

> The user name for logins.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account.CommunicationServiceRules**

> An array of communication service rules for this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.carddav.account.CommunicationServiceRules.DefaultServiceHandlers**

> A dictionary of service handlers for contacts from this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.carddav.account.CommunicationServiceRules.DefaultServiceHandlers.AudioCall**

> The bundle identifier for the default application that handles audio
> calls to contacts from this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.carddav.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.carddav.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.carddav.account"

**profiles.carddav.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.carddav.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.carddav.account.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular**

> The payload that configures cellular settings.
>
> This payload cannot be installed if an APN payload is already
> installed. This payload only applies to the preferred data SIM. There
> is no way to have a cellular payload affect a different SIM. This
> payload replaces the com.apple.managedCarrier payload. The latter
> payload is supported, but deprecated.
>
> *Type:* submodule

**profiles.cellular.enable**

> Whether to enable Enable the com.apple.cellular profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.cellular.APNs**

> An array of access point name (APN) dictionaries.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.AllowedProtocolMask**

> The Internet Protocol versions that the system supports. Available in
> iOS 10.3 and later. Allowed values:
>
> > **•** '1': IPv4
>
> > **•** '2': IPv6
>
> > **•** '3': Both
>
> Requires: iOS \>= 10.3
>
> *Type:* null or one of 1, 2, 3
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.AllowedProtocolMaskInDomesticRoaming**

> The Internet Protocol versions that the system supports while roaming.
> Available in iOS 10.3 and later. Allowed values:
>
> > **•** '1': IPv4
>
> > **•** '2': IPv6
>
> > **•** '3': Both
>
> Requires: iOS \>= 10.3
>
> *Type:* null or one of 1, 2, 3
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.AllowedProtocolMaskInRoaming**

> The Internet Protocol versions that the system supports while roaming.
> Available in iOS 10.3 and later. Allowed values:
>
> > **•** '1': IPv4
>
> > **•** '2': IPv6
>
> > **•** '3': Both
>
> Requires: iOS \>= 10.3
>
> *Type:* null or one of 1, 2, 3
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.AuthenticationType**

> The authentication type for logging in.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or one of "CHAP", "PAP"
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.DefaultProtocolMask**

> The default Internet Protocol versions. Available in iOS 10.3 but no
> longer used in iOS 11 and later. Allowed values:
>
> > **•** '1': IPv4
>
> > **•** '2': IPv6
>
> > **•** '3': Both
>
> Requires: iOS \>= 10.3\
> Deprecated in iOS 11.0
>
> *Type:* null or one of 1, 2, 3
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.EnableXLAT464**

> If 'true', the system enables XLAT464. Available in iOS 16 and later
> and watchOS 9 and later.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.Name**

> The name for this configuration.
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.cellular.APNs.\*.Password**

> The user's password for the APN.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.ProxyPort**

> The proxy server's port number.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.ProxyServer**

> The proxy server's address.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular.APNs.\*.Username**

> The user name for the APN.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular.AttachAPN**

> A configuration dictionary.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.cellular.AttachAPN.AllowedProtocolMask**

> The Internet Protocol versions that the system supports. Allowed
> values:
>
> > **•** '1': IPv4
>
> > **•** '2': IPv6
>
> > **•** '3': Both
>
> Requires: iOS \>= 10.3
>
> *Type:* null or one of 1, 2, 3
>
> *Default:*
>
> > null

**profiles.cellular.AttachAPN.AuthenticationType**

> The authentication type.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or one of "CHAP", "PAP"
>
> *Default:*
>
> > null

**profiles.cellular.AttachAPN.Name**

> The name for this configuration.
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.cellular.AttachAPN.Password**

> The password for the user.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular.AttachAPN.Username**

> The user name.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellular.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.cellular.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.cellular"

**profiles.cellular.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.cellular.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.cellularprivatenetwork.managed**

> The payload that provides device info on private network deployments,
> including geographical location, preference over Wi-Fi, and network
> deployment type.
>
> Payload can be used to provide device info on private network
> deployments including geographical location, preference over Wi-Fi,
> and network deployment type. Only five Cellular Private Networks can
> be configured simultaneously.
>
> *Type:* submodule

**profiles.cellularprivatenetwork.managed.enable**

> Whether to enable Enable the com.apple.cellularprivatenetwork.managed
> profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.cellularprivatenetwork.managed.CellularDataPreferred**

> Set to 'true' to prefer this private network over Wi-Fi.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.cellularprivatenetwork.managed.CsgNetworkIdentifier**

> A string using the 3GPP "CSG_ID" format (defined in 3GPP 23.003,
> Section 4.7). The device uses this value to match a SIM present on the
> device.
>
> All combinations of 'NetworkIdentifier' and 'CsgNetworkIdentifier'
> must be unique across all profiles installed on the device.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellularprivatenetwork.managed.DataSetName**

> The name of the private network configuration data set.
>
> Requires: iOS \>= 17.0
>
> *Type:* string

**profiles.cellularprivatenetwork.managed.EnableNRStandalone**

> Set to 'true' if this private network is NR Standalone.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.cellularprivatenetwork.managed.Geofences**

> A list of up to 1000 geofences for private networks. Geofencing is
> only used on iPhone.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.cellularprivatenetwork.managed.Geofences.\*.GeofenceId**

> A geofence identifier that's unique within a list of geofences.
>
> Requires: iOS \>= 17.0
>
> *Type:* string

**profiles.cellularprivatenetwork.managed.Geofences.\*.Latitude**

> The latitude of the geofence.
>
> Requires: iOS \>= 17.0
>
> *Type:* floating point number between -90.0 and 90.0 (both inclusive)

**profiles.cellularprivatenetwork.managed.Geofences.\*.Longitude**

> The longitude of the geofence.
>
> Requires: iOS \>= 17.0
>
> *Type:* floating point number between -180.0 and 180.0 (both
> inclusive)

**profiles.cellularprivatenetwork.managed.Geofences.\*.Radius**

> Specifies the radius of the geofence in meters. Set this value
> slightly greater than the private cellular network coverage area.
>
> Requires: iOS \>= 17.0
>
> *Type:* floating point number between 100.0 and 6500.0 (both
> inclusive)

**profiles.cellularprivatenetwork.managed.NetworkIdentifier**

> A string using the 3GPP "Coordinated NID" (option 1 or option 2)
> format (defined in 3GPP 31.102, Section 12.7.1). The device uses this
> value to match a SIM present on the device.
>
> All combinations of 'NetworkIdentifier' and 'CsgNetworkIdentifier'
> must be unique across all profiles installed on the device.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.cellularprivatenetwork.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.cellularprivatenetwork.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.cellularprivatenetwork.managed"

**profiles.cellularprivatenetwork.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.cellularprivatenetwork.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.cellularprivatenetwork.managed.VersionNumber**

> The version number of this dataset that the system uses to track
> updates.
>
> Requires: iOS \>= 17.0
>
> *Type:* string

**profiles.declarations**

> The payload that applies a set of declarations to the device through
> the Settings app.
>
> This profile applies a set of declarations to the device. Users use
> this profile to install declarations without requiring an MDM
> enrollment. A device management server can't install a configuration
> profile containing this payload type. Device management servers need
> to use declarative device management to install declarations.
>
> > *""* Important: When a user installs the profile, the device only
> > applies configuration declarations that allow a "local" enrollment.
> > Consult the documentation for each configuration type to see if you
> > can use it.
>
> *Type:* submodule

**profiles.declarations.enable**

> Whether to enable Enable the com.apple.declarations profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.declarations.Declarations**

> The set of declarations to apply. The array items are Base64-encoded
> data representations of the declaration JSON data.
>
> Requires: iOS \>= 17.0
>
> *Type:* list of (Written as string or path, read as { \_\_type =
> "data", value = \... })
>
> *Default:*
>
> > [ ]

**profiles.declarations.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.declarations.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.declarations"

**profiles.declarations.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.declarations.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.dnsProxy.managed**

> The payload that configures DNS proxies.
>
> As of iOS 15.0 this payload can be installed on unsupervised devices
> via MDM and can only be installed via MDM. As of iOS 16.0, this can be
> installed on user enrollments via MDM if DNSProxyUUID is specified.
>
> Beginning with iOS 15, this profile is unsupervised and needs to be
> installed through MDM.
>
> *Type:* submodule

**profiles.dnsProxy.managed.enable**

> Whether to enable Enable the com.apple.dnsProxy.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.dnsProxy.managed.AppBundleIdentifier**

> The bundle identifier of the app containing the DNS proxy network
> extension.
>
> Requires: iOS \>= 11.0
>
> *Type:* string

**profiles.dnsProxy.managed.DNSProxyUUID**

> A globally unique identifier for this DNS proxy configuration. The
> proxy processes DNS lookups traffic for managed apps with the same
> 'DNSProxyUUID' in their app attributes. This key is required for user
> enrollment.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.dnsProxy.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.dnsProxy.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.dnsProxy.managed"

**profiles.dnsProxy.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.dnsProxy.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.dnsProxy.managed.ProviderBundleIdentifier**

> The bundle identifier of the DNS proxy network extension to use.
> Declaring the bundle identifier is useful for apps that contain more
> than one DNS proxy extension.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.dnsProxy.managed.ProviderConfiguration**

> The dictionary of vendor-specific configuration items.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or (attribute set of anything)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed**

> The payload that configures encrypted DNS settings.
>
> When installed from an MDM, the setting only applies to managed Wi-Fi
> networks.
>
> When installed manually, this setting also applies to cellular
> networks.
>
> *Type:* submodule

**profiles.dnsSettings.managed.enable**

> Whether to enable Enable the com.apple.dnsSettings.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.dnsSettings.managed.DNSSettings**

> A dictionary that defines a configuration for an encrypted DNS server.
>
> Requires: iOS \>= 14.0
>
> *Type:* submodule

**profiles.dnsSettings.managed.DNSSettings.AllowFailover**

> If 'true', the device allows failover to the default system DNS
> resolver.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.DNSSettings.DNSProtocol**

> The encrypted transport protocol used to communicate with the DNS
> server.
>
> Requires: iOS \>= 14.0
>
> *Type:* one of "HTTPS", "TLS"

**profiles.dnsSettings.managed.DNSSettings.PayloadCertificateUUID**

> The UUID that points to an identity certificate payload. The system
> uses this identity to authenticate the user to the DNS resolver.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.DNSSettings.ServerAddresses**

> An unordered list of DNS server IP address strings. These IP addresses
> can be a mixture of IPv4 and IPv6 addresses.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.DNSSettings.ServerName**

> The hostname of a DNS-over-TLS server used to validate the server
> certificate, as defined in RFC 7858. If no 'ServerAddresses' are
> provided, the system uses the hostname to determine the server
> addresses. This key must be present only if the DNSProtocol is 'TLS'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.DNSSettings.ServerURL**

> The URI template of a DNS-over-HTTPS server, as defined in RFC 8484.
> This URL needs to use the 'https://' scheme, and the system uses the
> hostname or address in the URL to validate the server certificate. If
> no 'ServerAddresses' are provided, the system uses the hostname or
> address in the URL to determine the server addresses. Required if
> 'DNSProtocol' is 'HTTPS'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.DNSSettings.SupplementalMatchDomains**

> A list of domain strings used to determine which DNS queries use the
> DNS server. If not set, all domains use the DNS server.
>
> The system supports a single wildcard ('\*') prefix, but it's not
> required. For example, both '\*.example.com' and 'example.com' match
> against 'mydomain.example.com' and 'your.domain.example.com', but
> don't match against 'mydomain-example.com'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules**

> An array of rules that define the DNS settings. If not set, the system
> always applies the DNS settings. These rules are identical to the
> 'OnDemandRules' array in VPN payloads.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.Action**

> The action to take if this dictionary matches the current network.
> Allowed values:
>
> > **•** 'Connect': Apply DNS Settings when the dictionary matches.
>
> > **•** 'Disconnect': Don't apply DNS Settings when the dictionary
> > matches.
>
> > **•** 'EvaluateConnection': Apply DNS Settings with per-domain
> > exceptions when the dictionary matches.
>
> Requires: iOS \>= 14.0
>
> *Type:* one of "Connect", "Disconnect", "EvaluateConnection"

**profiles.dnsSettings.managed.OnDemandRules.\*.ActionParameters**

> An array of dictionaries that provide per-connection rules. The system
> uses this array only for settings where the 'Action' value is
> 'EvaluateConnection'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.ActionParameters.\*.DomainAction**

> The DNS settings behavior for the specified domains. Allowed values:
>
> > **•** 'NeverConnect': Don't use the DNS Settings for the specified
> > domains.
>
> > **•** 'ConnectIfNeeded': Allow using the DNS Settings for the
> > specified domains.
>
> Requires: iOS \>= 14.0
>
> *Type:* one of "NeverConnect", "ConnectIfNeeded"

**profiles.dnsSettings.managed.OnDemandRules.\*.ActionParameters.\*.Domains**

> The domains for which this evaluation applies.
>
> Requires: iOS \>= 14.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.dnsSettings.managed.OnDemandRules.\*.DNSDomainMatch**

> An array of domain names. This rule matches if any of the domain names
> in the specified list matches any domain in the device's search
> domains list.
>
> The system supports a single wildcard ('\*') prefix, but it's not
> required. For example, both '\*.example.com' and 'example.com' match
> against 'mydomain.example.com' and 'your.domain.example.com', but
> don't match against 'mydomain-example.com'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.DNSServerAddressMatch**

> An array of IP addresses. This rule matches if any of the network's
> specified DNS servers match any entry in the array.
>
> The system supports matching with a single wildcard. For example,
> '17.\*' matches any DNS server in the 17.0.0.0/8 subnet.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.InterfaceTypeMatch**

> An interface type. If specified, this rule matches only if the primary
> network interface hardware matches the specified type.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of "Ethernet", "WiFi", "Cellular"
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.SSIDMatch**

> An array of SSIDs to match against the current network. If the network
> isn't a Wi-Fi network or if the SSID doesn't appear in this array, the
> match fails. Omit this key and the corresponding array to match
> against any SSID.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.OnDemandRules.\*.URLStringProbe**

> A URL to probe. This rule matches if this URL is successfully fetched
> and returns a 200 HTTP status code without redirection.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.dnsSettings.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.dnsSettings.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.dnsSettings.managed"

**profiles.dnsSettings.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.dnsSettings.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.dnsSettings.managed.ProhibitDisablement**

> If 'true', the system prohibits users from disabling DNS settings.
> This key is only available on supervised devices.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.domains**

> The payload that configures the domains under an organization's
> management.
>
> This payload defines web domains that are under an enterprise's
> management.
>
> The 'WebDomains', 'SafariPasswordAutoFillDomains', and
> 'CrossSiteTrackingPreventionRelaxedDomains' keys are arrays containing
> strings that use the following matching patterns:
>
> > **•** 'example.com': Any path under 'example.com' matches, but not
> > 'site.example.com'.
>
> > **•** 'foo.example.com': Any path under 'foo.example.com' matches,
> > but not 'example.com' or 'bar.example.com'.
>
> > **•** '\\\*.example.com': Any path under 'foo.example.com' or
> > 'bar.example.com' matches, but not 'example.com'.
>
> > **•** 'example.com/sub': 'example.com/sub' and any path under it
> > matches, but not 'example.com'.
>
> > **•** 'foo.example.com/sub': Any path under 'foo.example.com/sub'
> > matches, but not 'example.com', 'example.com/sub',
> > 'foo.example.com/', or 'bar.example.com/sub'.
>
> > **•** '\\\*.example.com/sub': Any path under 'foo.example.com/sub'
> > or 'bar.example.com/sub' matches, but not 'example.com' or
> > 'foo.example.com/'.
>
> > **•** '\\\*.co': Any path under 'example.co' or 'betterbag.co'
> > matches, but not 'example.co.uk' or 'example.com'.
>
> A URL that begins with the prefix 'www.' is treated as though it
> doesn't contain that prefix during matching. For example,
> 'http://www.example.com/store' is matched as
> 'http://example.com/store'.
>
> Trailing slashes are ignored.
>
> If a domain string contains a port number, the system considers only
> addresses that specify that port number managed. Otherwise, the system
> matches the domain without regard to the port number specified. For
> example, the pattern '\*.example.com:8080' matches
> 'http://site.example.com:8080/page.html' but not
> 'http://site.example.com/page.html', while the pattern
> '\*.example.com' matches both URLs.
>
> *Type:* submodule

**profiles.domains.enable**

> Whether to enable Enable the com.apple.domains profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.domains.CrossSiteTrackingPreventionRelaxedApps**

> An array of up to 10 strings representing app bundle-ids. Apps
> matching the bundle-ids listed here have relaxed enforcement of
> cross-site tracking prevention for the domains listed in
> 'CrossSiteTrackingPreventionRelaxedDomains'.
>
> Available in iOS 18 and later and macOS 15 and later.
>
> Requires: iOS \>= 18.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.domains.CrossSiteTrackingPreventionRelaxedDomains**

> An array of up to 10 strings. URLs matching the patterns listed here
> have relaxed enforcement of cross-site tracking prevention.
>
> Available in iOS 16.2 and later and macOS 13.1 and later.
>
> Requires: iOS \>= 16.2; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.domains.EmailDomains**

> An array of domains. Mail marks in red all email addresses that lack a
> suffix matching any of these strings.
>
> Available in iOS 8 and later and macOS 10.10 and later.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.domains.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.domains.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.domains"

**profiles.domains.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.domains.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.domains.SafariPasswordAutoFillDomains**

> An array of domains. Users can only save passwords in Safari from URLs
> matching the patterns listed here. This property doesn't disable the
> autofill feature itself.
>
> Supervised devices or Shared iPads need this property to enable saving
> passwords in Safari.
>
> Available in iOS 9.3 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.domains.WebDomains**

> An array of domains. The system considers URLs matching the patterns
> listed in this property managed.
>
> Available in iOS 9.3 and later.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.eas.account**

> The payload that configures Exchange ActiveSync accounts.
>
> This payload configures an Exchange Active Sync account on an iOS
> device for Mail, Contacts, Calendars, Reminders, and Notes. Updating
> this payload overrides any settings that the user customized, such as
> EnableMail/Contacts/Calendars/Reminders/Notes and
> MailNumberOfPastDaysToSync.
>
> *Type:* submodule

**profiles.eas.account.enable**

> Whether to enable Enable the com.apple.eas.account profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.eas.account.Certificate**

> The '.p12' identity certificate in NSData blob format, for accounts
> that allow authentication via certificate.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.eas.account.CertificateName**

> The name or description of the certificate.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.CertificatePassword**

> The password necessary for the '.p12' identity certificate. Used with
> mandatory encryption of profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.CommunicationServiceRules**

> The communication service handler rules for this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.eas.account.CommunicationServiceRules.DefaultServiceHandlers**

> The default handlers to use for contacts from this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.eas.account.CommunicationServiceRules.DefaultServiceHandlers.AudioCall**

> The bundle identifier of the default application to use for audio
> calls made to contacts from this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.EmailAddress**

> The full email address for the account. If not present in the payload,
> the device prompts for this string during profile installation.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.EnableCalendars**

> If 'false', the system disables the Calendars service for this
> account. The user can reenable Calendars service in Settings unless
> 'EnableCalendarsUserOverridable' is 'false'.
>
> > *""* Note: At least of the following fields needs to be 'true':
> > 'EnableMail', 'EnableContacts', 'EnableCalendars',
> > 'EnableReminders', and 'EnableNotes'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableCalendarsUserOverridable**

> If 'false', the system prevents the user from changing the state of
> the Calendars service for this account in Settings.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableContacts**

> If 'false', the system disables the Contacts service for this account.
> The user can reenable Contacts service in Settings unless
> 'EnableContactsUserOverridable' is 'false'.
>
> > *""* Note: At least of the following fields needs to be 'true':
> > 'EnableMail', 'EnableContacts', 'EnableCalendars',
> > 'EnableReminders', and 'EnableNotes'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableContactsUserOverridable**

> If 'false', the system prevents the user from changing the state of
> the Contacts service for this account in Settings.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableMail**

> If 'false', the system disables the Mail service for this account. The
> user can reenable Mail service in Settings unless
> 'EnableMailUserOverridable' is 'false'.
>
> > *""* Note: At least of the following fields needs to be 'true':
> > 'EnableMail', 'EnableContacts', 'EnableCalendars',
> > 'EnableReminders', and 'EnableNotes'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableMailUserOverridable**

> If 'false', the system prevents the user from changing the state of
> the Mail service for this account in Settings.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableNotes**

> If 'false', the system disables the Notes service for this account.
> The user can reenable Notes service in Settings unless
> 'EnableNotesUserOverridable' is 'false'.
>
> > *""* Note: At least of the following fields needs to be 'true':
> > 'EnableMail', 'EnableContacts', 'EnableCalendars',
> > 'EnableReminders', and 'EnableNotes'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableNotesUserOverridable**

> If 'false', prevents the user from changing the state of the Notes
> service for this account in Settings.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableReminders**

> If 'false', the system disables the Reminders service for this
> account. The user can reenable Reminders service in Settings unless
> 'EnableRemindersUserOverridable' is 'false'.
>
> > *""* Note: At least of the following fields needs to be 'true':
> > 'EnableMail', 'EnableContacts', 'EnableCalendars',
> > 'EnableReminders', and 'EnableNotes'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.EnableRemindersUserOverridable**

> If 'false', the system prevents the user from changing the state of
> the Reminders service for this account in Settings.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.HeaderMagic**

> The value of the 'X-Apple-Config-Magic' header in each EAS HTTP
> request.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.Host**

> The Exchange server host name or IP address.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.MailNumberOfPastDaysToSync**

> The number of days in the past to sync mail on the device.
>
> For no limit, use the value '0'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1, 3, 7, 14, 31
>
> *Default:*
>
> > null

**profiles.eas.account.OAuth**

> If 'true', enables OAuth for authentication. If enabled, don't specify
> a password.
>
> Available only in iOS 12.0 and above.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.OAuthSignInURL**

> The URL that this account should use for signing in through OAuth.
> Ignored unless 'OAuth' is 'true'. If you specify this URL,
> auto-discovery isn't used for this account, so you need to also
> specify a host.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.OAuthTokenRequestURL**

> The URL that this account should use for token requests through OAuth.
> Ignored unless 'OAuth' is 'true'.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.OverridePreviousPassword**

> If 'true', the system overrides the previous user/EAS password with
> the new EAS password in the payload. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.Password**

> The password of the account. Use only with encrypted profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile to use for
> the identity credential. If this field is present, the Certificate
> field isn't used.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.eas.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.eas.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.eas.account"

**profiles.eas.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.eas.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.eas.account.PreventAppSheet**

> If 'true', prevents this account from sending mail in any app other
> than the Apple Mail app.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.PreventMove**

> If 'true', the system prevents moving messages from out of this email
> account into another account. This setting also prevents forwarding or
> replying from an account other than the recipient of the message.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEnableEncryptionPerMessageSwitch**

> If 'true', the system displays the per-message encryption switch in
> the Mail Compose UI. Available in iOS 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEnablePerMessageSwitch**

> If 'true', the system displays the per-message encryption switch in
> the Mail Compose UI.
>
> Available in iOS 8.0 and later. As of iOS 12.0, this key is
> deprecated. Use 'SMIMEEnableEncryptionPerMessageSwitch' instead.
>
> Requires: iOS \>= 8.0\
> Deprecated in iOS 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEnabled**

> If 'true', the system enables S/MIME encryption. In iOS 10.0 and
> later, this key is ignored. Use 'SMIMESigningEnabled' instead.
>
> Requires: iOS \>= 5.0\
> Deprecated in iOS 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEncryptByDefault**

> If 'true', the system enables S/MIME encryption by default. If
> 'SMIMEEnableEncryptionPerMessageSwitch' is 'false', the user can't
> change this default. Available in iOS 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEncryptByDefaultUserOverrideable**

> If 'true', the system enables encryption by default and the user can't
> change it. Available in iOS 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEncryptionCertificateUUID**

> The payload UUID of the identity certificate used to decrypt messages
> sent to this account. The system attaches the public certificate to
> outgoing mail to allow the user to receive encrypted mail. When the
> user sends encrypted mail, the system uses the public certificate to
> encrypt the copy of the mail in the user's Sent mailbox.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEncryptionCertificateUUIDUserOverrideable**

> If 'true', the user can select the S/MIME encryption identity, and
> encryption is on.Available in iOS 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMEEncryptionEnabled**

> If 'true', the system enables S/MIME encryption for this account.
> Available in iOS 10.0 and later. As of iOS 12.0, this key is
> deprecated. Use 'SMIMEEncryptByDefault' instead.
>
> Requires: iOS \>= 10.3\
> Deprecated in iOS 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMESigningCertificateUUID**

> The UUID of the identity certificate used to sign messages sent from
> this account.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMESigningCertificateUUIDUserOverrideable**

> If 'true', the user can select the signing identity. Available in iOS
> 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMESigningEnabled**

> If 'true', the system enables S/MIME signing for this account.
> Available in iOS 10.0 and later.
>
> Requires: iOS \>= 10.3
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SMIMESigningUserOverrideable**

> If 'true', the user can turn S/MIME signing on or off in Settings.
> Available in iOS 12.0 and later.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.SSL**

> If 'true', the system enables SSL for authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.UserName**

> This user name for this Exchange account. Required for noninteractive
> installations like MDM in iOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.eas.account.allowMailDrop**

> If 'true', the system enables this account to use Mail Drop.
>
> Requires: iOS \>= 9.2
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.eas.account.disableMailRecentsSyncing**

> If 'true', the system excludes this account from Recent Addresses
> syncing.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.education**

> The payload that configures the users, groups, and departments within
> an educational organization.
>
> This payload is used to configure Classroom students, Classroom
> instructors, and the Shared iPad login screen. These do not
> necessarily require the same set of keys to be present in their
> payloads, so make sure to include all keys that are required for the
> education product you are configuring.
>
> In iOS, send this payload over the device channel. Additionally, the
> system requires supervision unless the payload only specifies as
> teacher configuration.
>
> In macOS, send this payload over the user channel. The system supports
> student payloads in macOS 10.14.4 and later.
>
> Additionally, configure:
>
> > **•** All identities as both SSL clients and servers
>
> > **•** All certificates with a key size of at least 2048 bits
>
> > **•** All certificates to use a hashing algorithm of SHA256 or
> > stronger
>
> > **•** Leader certificates to have the common name prefix leader,
> > which is case- insensitive
>
> > **•** Member certificates to have the common name prefix member,
> > which is case- insensitive
>
> > **•** TLS server certificates issued on or after September 1, 2020
> > 00:00 GMT/UTC to have a validity period greater than 398 days; see
> > **About Upcoming Limits on Trusted Certificates**\[1\] for more
> > information.
>
> *Type:* submodule
>
> > **1.** https://support.apple.com/en-us/HT211025

**profiles.education.enable**

> Whether to enable Enable the com.apple.education profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.education.Departments**

> *For Shared iPad profiles:* The array of dictionaries that defines
> which departments the system displays in the Shared iPad login screen.
> If set, the system uses this key to configure both Classroom and the
> Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.education.Departments.\*.GroupBeaconIDs**

> The group beacon identifiers that are members of this department.
>
> Requires: iOS \>= 9.3
>
> *Type:* list of signed integer
>
> *Default:*
>
> > [ ]

**profiles.education.Departments.\*.Name**

> The display name of the department.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.DeviceGroups**

> *For leader/teacher profiles:* The array of dictionaries that defines
> which device groups the leader can assign devices to. Not included in
> member payloads.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.education.DeviceGroups.\*.Identifier**

> The unique identifier for the device group in the organization.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.DeviceGroups.\*.Name**

> The name of the device group, which must be unique in the
> organization.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.DeviceGroups.\*.SerialNumbers**

> The serial numbers of the devices in the group.
>
> Requires: iOS \>= 9.3
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.education.Groups**

> *For Shared iPad profiles:* The array of dictionaries that defines
> which groups the user can select in the Login Window.
>
> *For leader/teacher profiles:* The array of dictionaries that defines
> the groups that the user can control.
>
> *For member/student profiles:* The array of dictionaries that defines
> the groups where the user is a member.
>
> Requires: iOS \>= 9.3
>
> *Type:* list of (submodule)

**profiles.education.Groups.\*.BeaconID**

> An unsigned 16 bit integer specifying this group's unique beacon ID.
>
> Requires: iOS \>= 9.3
>
> *Type:* signed integer

**profiles.education.Groups.\*.ConfigurationSource**

> The source that provided this group, such as SIS, or MDM.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Groups.\*.Description**

> The description of the group.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Groups.\*.DeviceGroupIdentifiers**

> The identifiers that refer to entries in the 'DeviceGroups' array to
> which the instructor can assign users from this class.
>
> Has no effect on the configuration of the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.education.Groups.\*.ImageURL**

> Deprecated in iOS 9.3.1 and later. The URL of an image for the group.
>
> Requires: iOS \>= 9.3\
> Deprecated in iOS 9.3.1
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Groups.\*.LeaderIdentifiers**

> The user identifiers that are leaders of this group.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.education.Groups.\*.MemberIdentifiers**

> The entries in the Users array that are members of the group.
>
> Requires: iOS \>= 9.3
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.education.Groups.\*.Name**

> The display name of the group.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.LeaderPayloadCertificateAnchorUUID**

> The array of UUIDs referring to certificate payloads within the same
> profile that the system uses to authorize leader peer certificate
> identities. This array needs to contain all necessary certificates to
> validate the entire chain of trust. Leader certificates needs to have
> the common name prefix leader, which is case insensitive.
>
> This property doesn't support identity payloads or PKCS12
> certificates.
>
> Required when configuring a student device for Classroom, and ignored
> when configuring an instructor device. Has no effect on the
> configuration of the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.education.MemberPayloadCertificateAnchorUUID**

> The array of UUIDs referring to certificate payloads within the same
> profile that the system uses to authorize group member peer
> certificate identities. This array must contain all certificates
> needed to validate the entire chain of trust. Member certificates must
> have the common name prefix member (case insensitive).
>
> This property doesn't support identity payloads or PKCS12
> certificates.
>
> Required when configuring a student device for Classroom, and ignored
> when configuring an instructor device. Has no effect on the
> configuration of the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.education.OrganizationName**

> The organization's display name. The system displays this name in the
> iOS login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.OrganizationUUID**

> The organization's UUID identifier. This identifier can be any valid
> UUID. All teacher and student devices that need to communicate with
> one another must have the same organization UUID, particularly if they
> originated from different Device Enrollment Programs.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.PayloadCertificateUUID**

> The UUID of an identity certificate payload within the same profile to
> use for performing client authentication with other devices. This
> property supports PKCS12 certificates.
>
> Required to configure Classroom. Has no effect on the configuration of
> the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.education.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.education"

**profiles.education.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.education.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.education.ResourcePayloadCertificateUUID**

> The UUID of an identity certificate payload within the same profile
> that the system uses to perform client authentication when fetching
> additional resources, such as student images.
>
> If set, the system uses this key to configure both Classroom and the
> Shared iPad login screen. If not set, the system uses MDM client
> identity.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.ScreenObservationPermissionModificationAllowed**

> If 'true', the system allows students enrolled in managed classes to
> modify their teacher's permissions for screen observation on their
> device.
>
> Requires: iOS \>= 10.3
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.education.UserIdentifier**

> The unique string that identifies the user of this device within the
> organization.
>
> Don't set this value in payloads intended to configure the Shared iPad
> login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.Users**

> For Shared iPad profiles: The array of dictionaries that define the
> users that the system displays in the iOS Login Window.
>
> *For leader/teacher profiles:* The array of dictionaries that define
> users that are members of the teacher's groups.
>
> *For member/student profiles:* The array of dictionaries that needs to
> contain the definition of the user specified in the 'UserIdentifier'
> key. With one-to-one member devices, this key should include only the
> device user and the teacher but not other class members.
>
> Requires: iOS \>= 9.3
>
> *Type:* list of (submodule)

**profiles.education.Users.\*.AppleID**

> The Managed Apple Account for this user.
>
> Not required to configure Classroom, but if set the system uses it.
>
> Required to configure the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.FamilyName**

> The family name of the user.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.FullScreenImageURL**

> Deprecated in iOS 9.3.1 and later. The URL pointing to an image of the
> user. The system uses the 'ResourcePayloadCertificateUUID' identity
> certificate or the MDM client identity to perform authentication when
> fetching the specified resource.
>
> Requires: iOS \>= 9.3\
> Deprecated in iOS 9.3.1
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.GivenName**

> The given name of the user.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.Identifier**

> The unique identifier for a user in the organization.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.Users.\*.ImageURL**

> A string that contains a URL pointing to an image of the user. The
> system displays this image in the iOS login screen and in the
> Classroom app. The recommended resolution is 256 x 256 pixels (512 x
> 512 pixels on a 2x device). The recommended formats are JPEG, PNG, and
> TIFF. The system uses the 'ResourcePayloadCertificateUUID' identity
> certificate or the MDM client identity to perform authentication when
> fetching the image.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.Name**

> The name of the user.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.education.Users.\*.PasscodeType**

> The type of passcode UI to show when the user is at the Login Window.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or one of "complex", "four", "six"
>
> *Default:*
>
> > null

**profiles.education.Users.\*.PhoneticFamilyName**

> The user's phonetic family name. The system uses this name to sort
> users in the Classroom app and the Shared iPad login screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.education.Users.\*.PhoneticGivenName**

> The user's phonetic given name. The system uses this name to sort
> users in the Classroom app and the Shared iPad Login Screen.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso**

> The payload that configures an app extension that performs single
> sign-on (SSO).
>
> Configures an app extension that performs SSO on behalf of certain
> URLs. User channel support was added in macOS 11.0.
>
> The system supports user channel installation in macOS 11 and later.
>
> *Type:* submodule

**profiles.extensiblesso.enable**

> Whether to enable Enable the com.apple.extensiblesso profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.extensiblesso.DeniedBundleIdentifiers**

> An array of bundle identifiers of apps that don't use SSO provided by
> this extension. Available in iOS 15 and later, and macOS 12 and later.
>
> Requires: iOS \>= 15.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso.ExtensionData**

> A dictionary of arbitrary data passed through to the app extension.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (attribute set of anything)
>
> *Default:*
>
> > null

**profiles.extensiblesso.ExtensionIdentifier**

> The bundle identifier of the app extension that performs SSO for the
> specified URLs.
>
> Requires: iOS \>= 13.0
>
> *Type:* string

**profiles.extensiblesso.Hosts**

> An array of host or domain names that apps can authenticate through
> the app extension.
>
> Required for 'Credential' payloads. Ignored for 'Redirect' payloads.
>
> The system:
>
> > **•** Matches host or domain names case-insensitively
>
> > **•** Requires that all the host and domain names of all installed
> > Extensible SSO payloads are unique
>
> > *""* Note: Host names that begin with a "." are wildcard suffixes
> > that match all subdomains; otherwise the host name needs be an exact
> > match.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.extensiblesso.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.extensiblesso"

**profiles.extensiblesso.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.extensiblesso.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.extensiblesso.Realm**

> The realm name for 'Credential' payloads. Use proper capitalization
> for this value. Ignored for 'Redirect' payloads.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso.ScreenLockedBehavior**

> If set to 'Cancel', the system cancels authentication requests when
> the screen is locked. If set to 'DoNotHandle', the request continues
> without SSO instead. This doesn't apply to requests where
> 'userInterfaceEnabled' is 'false', or for background 'URLSession'
> requests. Available in iOS 15 and later, and macOS 12 and later.
>
> Requires: iOS \>= 15.0
>
> *Type:* null or one of "Cancel", "DoNotHandle"
>
> *Default:*
>
> > null

**profiles.extensiblesso.Type**

> The type of SSO.
>
> Requires: iOS \>= 13.0
>
> *Type:* one of "Credential", "Redirect"

**profiles.extensiblesso.URLs**

> An array of URL prefixes of identity providers where the app extension
> performs SSO.
>
> Required for 'Redirect' payloads. Ignored for 'Credential' payloads.
>
> The URLs need to begin with 'http://' or 'https://'.
>
> The system:
>
> > **•** Matches scheme and host name case-insensitively
>
> > **•** Doesn't allow query parameters and URL fragments
>
> > **•** Requires that the URLs of all installed Extensible SSO
> > payloads are unique
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos**

> The payload that configures an app extension that performs single
> sign-on with the Kerberos extension.
>
> Configures the included Kerberos extension that performs SSO on behalf
> of specified hosts. User channel support was added in macOS 11.0.
>
> This is a version of the profile that defines the specific keys and
> values needed for the Kerberos extension.
>
> The system supports user channel installation in macOS 11 and later.
>
> *Type:* submodule

**profiles.extensiblesso-kerberos.enable**

> Whether to enable Enable the com.apple.extensiblesso profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.extensiblesso-kerberos.ExtensionData**

> This is the dictionary used by the Apple built-in Kerberos extension.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.allowAutomaticLogin**

> If 'false', the system doesn't allow saving passwords in the keychain.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.cacheName**

> The GSS name of the Kerberos cache to use. Rarely set by an
> administrator.
>
> Requires: iOS \>= 13.0\
> Deprecated in iOS 15.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.certificateUUID**

> The PayloadUUID of a PKINIT certificate.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.credentialBundleIdACL**

> A list of bundle IDs allowed to access the ticket-granting ticket
> (TGT).
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.credentialUseMode**

> This setting affects how other processes use the Kerberos Extension
> credential. Allowed values:
>
> > **•** 'always': The system always uses the credential if the SPN
> > matches the Kerberos Extension 'Hosts' array and the caller hasn't
> > specified another credential. However, the system won't use the
> > credential if the calling app isn't in the 'credentialBundleIDACL'.
>
> > **•** 'whenNotSpecified': The system only uses the extension
> > credential if the SPN matches the Kerberos Extension 'Hosts' array.
> > However, the system won't use the credential if the calling app
> > isn't in the 'credentialBundleIDACL'.
>
> > **•** 'kerberosDefault': The system uses the default Kerberos
> > processes to select credentials, and normally uses the default
> > Kerberos credential. This is the same as turning off this
> > capability.
>
> Available in macOS 11 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of "always", "whenNotSpecified", "kerberosDefault"
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.customUsernameLabel**

> The custom user name label used in the Kerberos extension instead of
> "Username," such as "Company ID". Available in macOS 11 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.domainRealmMapping**

> A custom domain-realm mapping for Kerberos. The system uses this when
> the DNS name of hosts doesn't match the realm name. Most
> administrators don't need to customize this.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.domainRealmMapping.Realm**

> The key should be the name of the realm, and the value is an array of
> DNS suffixes that map to the realm.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.helpText**

> The text to display to the user at the bottom of the Kerberos Login
> Window. You can also use this to display help information or
> disclaimer text. Available in iOS 14 and later, and macOS 11 and
> later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.includeManagedAppsInBundleIdACL**

> If 'true', the Kerberos extension allows only managed apps to access
> and use the credential. This is in addition to the
> 'credentialBundleIDACL', if you specify that value. Available in iOS
> 14 and later, and macOS 12 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.isDefaultRealm**

> Specifies whether this is the default realm if there's more than one
> Kerberos extension configuration.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.performKerberosOnly**

> If 'true', the Kerberos Extension handles Kerberos requests only. It
> doesn't check for password expiration, show the password expiration in
> the menu, check for external password changes, perform password sync,
> or retrieve the home directory. Available in macOS 13 and later.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.preferredKDCs**

> The ordered list of preferred Key Distribution Centers (KDCs) to use
> for Kerberos traffic. Use this if the servers aren't discoverable
> through DNS. If the servers are specified, then the system uses them
> for both connectivity checks and attempts to use them first for
> Kerberos traffic. If the servers don't respond, the device falls back
> to DNS discovery. Format each entry the same as it would be in a
> 'krb5.conf' file, for example:
>
> > **•** 'adserver1.example.com'
>
> > **•** 'tcp/adserver1.example.com:88'
>
> > **•** 'kkdcp://kerberosproxy.example.com:443/kkdcp'
>
> Requires: iOS \>= 15.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.principalName**

> The principal (username) to use. You don't need to include the realm.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.requireTLSForLDAP**

> Require that LDAP connections use TLS. Available in macOS 11 and
> later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.requireUserPresence**

> If 'true', the system requires the user to provide Touch ID, Face ID
> or their passcode to access the keychain entry.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.siteCode**

> The name of the Active Directory site the Kerberos extension should
> use. Most administrators don't need to modify this value, as the
> Kerberos extension can normally find the site automatically.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionData.useSiteAutoDiscovery**

> If 'false', the Kerberos extension doesn't automatically use LDAP and
> DNS to determine its AD site name.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.ExtensionIdentifier**

> Set this to 'com.apple.AppSSOKerberos.KerberosExtension' for this
> extension.
>
> Requires: iOS \>= 13.0
>
> *Type:* value "com.apple.AppSSOKerberos.KerberosExtension" (singular
> enum)

**profiles.extensiblesso-kerberos.Hosts**

> One or more host or domain names for which the app extension performs
> SSO.
>
> The system:
>
> > **•** Matches host or domain names case-insensitively
>
> > **•** Requires that all the host and domain names of all installed
> > Extensible SSO payloads are unique
>
> > *""* Note: Host names that begin with a "." are wildcard suffixes
> > that match all subdomains; otherwise the host name needs be an exact
> > match.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.extensiblesso-kerberos.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.extensiblesso-kerberos.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.extensiblesso"

**profiles.extensiblesso-kerberos.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.extensiblesso-kerberos.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.extensiblesso-kerberos.Realm**

> The Kerberos realm. Use proper capitalization for this value. If in an
> Active Directory forest, this is the realm where the user logs in.
>
> Requires: iOS \>= 13.0
>
> *Type:* string

**profiles.extensiblesso-kerberos.TeamIdentifier**

> Set this to 'apple' for this extension.
>
> Requires: iOS \>= 13.0
>
> *Type:* value "apple" (singular enum)

**profiles.extensiblesso-kerberos.Type**

> Set this to 'Credential' for this extension.
>
> Requires: iOS \>= 13.0
>
> *Type:* value "Credential" (singular enum)

**profiles.font**

> The payload that configures fonts.
>
> Each payload may contain one font file. Font files may be in TrueType
> (.ttf) or OpenType (.otf) file format. Collection types (.ttc or .otc)
> formats are not supported. Fonts are uniquely identified internally by
> their embedded PostScript name. Two fonts with the same PostScript
> name will be considered the same font, even if their contents differ.
> Installing two different fonts with the same PostScript name is not
> supported, and it is undefined which font will remain installed.
> Supported on the Shared iPad user channel as of iPadOS 18.0. Earlier
> versions of iPadOS erroneously accepted the Font payload on the device
> channel but installed it for the currently logged in user.
>
> In iPadOS 18 and later, the font profile is available on the user
> channel for Shared iPads.
>
> *Type:* submodule

**profiles.font.enable**

> Whether to enable Enable the com.apple.font profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.font.Font**

> The contents of the font file.
>
> Requires: iOS \>= 7.0
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.font.Name**

> The user-visible name for the font. This field is replaced by the
> actual name of the font after installation. Each payload must contain
> exactly one font file in trueType (.ttf) or OpenType (.otf) format.
> Collection formats (.ttc or .otc) are not supported.
>
> Fonts are identified by their embedded PostScript names. Two fonts
> with the same PostScript name are considered to be the same font even
> if their contents differ. Installing two different fonts with the same
> PostScript name isn't supported, and the resulting behavior is
> undefined.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.font.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.font.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.font"

**profiles.font.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.font.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.globalethernet.managed**

> The payload that configures the default fallback global Ethernet
> interface.
>
> This payload's contents contain these profile-specific keys:
>
> > **•** Interface (String): This payload uses the value
> > 'GlobalEthernet'.
>
> > **•** EAPClientConfiguration ('EAPClientConfiguration'): The
> > dictionary that defines the enterprise profile for the network.
>
> > **•** SetupModes (String): The type of connection mode, which is
> > either 'System' or 'Loginwindow'. 'System' is the default.
>
> *Type:* submodule

**profiles.globalethernet.managed.enable**

> Whether to enable Enable the com.apple.globalethernet.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.globalethernet.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.globalethernet.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.globalethernet.managed"

**profiles.globalethernet.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.globalethernet.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.globalethernet.managed.settings**

> Keys relevant to 802.1X configuration. User enrollment payloads don't
> support the various proxy keys, including 'ProxyType', 'ProxyServer',
> 'ProxyServerPort', 'ProxyUsername', 'ProxyPassword', 'ProxyPACURL' and
> 'ProxyPACFallbackAllowed'.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (Written as attrs, read as { \_\_type = "settings",
> value = {\...} })
>
> *Default:*
>
> > null

**profiles.google-oauth**

> The payload that configures a Google account.
>
> A Google account payload sets up a Google email address as well as any
> other Google services the user enables after authentication. Google
> accounts must be installed via MDM or by Apple Configurator 2 (if the
> device is supervised). The payload never contains credentials and the
> user will be prompted to enter their credentials shortly after the
> payload successfully installs. On Shared iPads, this payload can only
> be installed on the MDM user channel.
>
> You can install multiple Google payloads. Each sets up a Google email
> address and any other Google services the user enables after
> authentication.
>
> > *""* Note: For supervised devices, the system requires installation
> > of Google accounts through MDM or Apple Configurator 2.
>
> The payload never contains credentials; the system prompts the user to
> enter credentials shortly after installation of the payload.
>
> *Type:* submodule

**profiles.google-oauth.enable**

> Whether to enable Enable the com.apple.google-oauth profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.google-oauth.AccountDescription**

> A user-visible description of the Google account, shown in the Mail
> and Settings apps.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.google-oauth.AccountName**

> The user's full name for the Google account. This name appears in sent
> messages.
>
> Requires: iOS \>= 9.3
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.google-oauth.CommunicationServiceRules**

> The communication service handler rules for this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.google-oauth.CommunicationServiceRules.DefaultServiceHandlers**

> A dictionary that defines which app to use for audio calls from this
> account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.google-oauth.CommunicationServiceRules.DefaultServiceHandlers.AudioCall**

> The bundle identifier for the default application that handles audio
> calls to contacts from this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.google-oauth.EmailAddress**

> The full Google email address for the account.
>
> Requires: iOS \>= 9.3
>
> *Type:* string

**profiles.google-oauth.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.google-oauth.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.google-oauth"

**profiles.google-oauth.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.google-oauth.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.google-oauth.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout**

> The payload that configures the Home Screen layout.
>
> The payload defines a layout of apps, folders, & web clips for the
> Home screen.
>
> This payload defines a layout of apps, folders, and web clips for the
> Home Screen. This layout is locked and can't be modified by the user.
>
> If a Home Screen layout puts more than four items in the iPhone Dock
> the location of the fifth and succeeding items may be undefined but
> they will not be omitted.
>
> To disable deletion of apps, set 'allowAppRemoval' to 'false' with
> 'Restrictions'.
>
> *Type:* submodule

**profiles.homescreenlayout.enable**

> Whether to enable Enable the com.apple.homescreenlayout profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.homescreenlayout.Dock**

> An array of dictionaries, each of which must conform to the icon
> dictionary format. If this key isn't present, the user's Dock is
> empty.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.BundleID**

> The bundle identifier of the app. This setting is required if the type
> is 'Application'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.DisplayName**

> The human-readable string shown to the user. This setting is valid
> only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Pages**

> An array of arrays of dictionaries, each conforming to the icon
> dictionary format. This setting is valid only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of list of (submodule))
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Pages.\*.\*.BundleID**

> The bundle identifier of the app. This setting is required if the type
> is 'Application'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Pages.\*.\*.DisplayName**

> The human-readable string shown to the user. This setting is valid
> only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Pages.\*.\*.Pages**

> An array of arrays of dictionaries, each conforming to the icon
> dictionary format. This setting is valid only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of anything)
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Pages.\*.\*.Type**

> The type of the Dock item.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* one of "Application", "Folder", "WebClip"

**profiles.homescreenlayout.Dock.\*.Pages.\*.\*.URL**

> The URL of the existing web clip for this item. This setting is
> required if 'type' is 'WebClip'. If more than one web clip exists with
> the same URL, the behavior is undefined.
>
> Specifying a web clip in this payload doesn't create the web clip. Use
> the 'WebClip' payload to create a web clip.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Dock.\*.Type**

> The type of the Dock item.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* one of "Application", "Folder", "WebClip"

**profiles.homescreenlayout.Dock.\*.URL**

> The URL of the existing web clip for this item. This setting is
> required if 'type' is 'WebClip'. If more than one web clip exists with
> the same URL, the behavior is undefined.
>
> Specifying a web clip in this payload doesn't create the web clip. Use
> the 'WebClip' payload to create a web clip.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages**

> An array of arrays of dictionaries, each of which must conform to the
> icon dictionary format.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* list of list of (submodule)

**profiles.homescreenlayout.Pages.\*.\*.BundleID**

> The bundle identifier of the app. This setting is required if the type
> is 'Application'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.DisplayName**

> The human-readable string shown to the user. This setting is valid
> only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Pages**

> An array of arrays of dictionaries, each conforming to the icon
> dictionary format. This setting is valid only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of list of (submodule))
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Pages.\*.\*.BundleID**

> The bundle identifier of the app. This setting is required if the type
> is 'Application'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Pages.\*.\*.DisplayName**

> The human-readable string shown to the user. This setting is valid
> only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Pages.\*.\*.Pages**

> An array of arrays of dictionaries, each conforming to the icon
> dictionary format. This setting is valid only if the type is 'Folder'.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or (list of anything)
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Pages.\*.\*.Type**

> The type of the Dock item.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* one of "Application", "Folder", "WebClip"

**profiles.homescreenlayout.Pages.\*.\*.Pages.\*.\*.URL**

> The URL of the existing web clip for this item. This setting is
> required if 'type' is 'WebClip'. If more than one web clip exists with
> the same URL, the behavior is undefined.
>
> Specifying a web clip in this payload doesn't create the web clip. Use
> the 'WebClip' payload to create a web clip.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.Pages.\*.\*.Type**

> The type of the Dock item.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* one of "Application", "Folder", "WebClip"

**profiles.homescreenlayout.Pages.\*.\*.URL**

> The URL of the existing web clip for this item. This setting is
> required if 'type' is 'WebClip'. If more than one web clip exists with
> the same URL, the behavior is undefined.
>
> Specifying a web clip in this payload doesn't create the web clip. Use
> the 'WebClip' payload to create a web clip.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.homescreenlayout.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.homescreenlayout.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.homescreenlayout"

**profiles.homescreenlayout.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.homescreenlayout.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.ldap.account**

> The payload that configures a Lightweight Directory Access Protocol
> (LDAP) account.
>
> *Type:* submodule

**profiles.ldap.account.enable**

> Whether to enable Enable the com.apple.ldap.account profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.ldap.account.LDAPAccountDescription**

> The description of the account.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPAccountHostName**

> The server's address.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.ldap.account.LDAPAccountPassword**

> The user's password. Only use this in encrypted profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPAccountUseSSL**

> If 'true', the system enables SSL.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPAccountUserName**

> The user's user name.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPSearchSettings**

> An array of search settings dictionaries.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPSearchSettings.\*.LDAPSearchSettingDescription**

> The description of this search setting.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPSearchSettings.\*.LDAPSearchSettingScope**

> The type of recursion to use in the search:
>
> > **•** 'LDAPSearchSettingScopeBase': The search uses only the
> > immediate node that the search base points to.
>
> > **•** 'LDAPSearchSettingScopeOneLevel': The search uses the node
> > plus its immediate children.
>
> > **•** 'LDAPSearchSettingScopeSubtree': The search uses the node plus
> > all children, regardless of depth.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "LDAPSearchSettingScopeBase",
> "LDAPSearchSettingScopeOneLevel", "LDAPSearchSettingScopeSubtree"
>
> *Default:*
>
> > null

**profiles.ldap.account.LDAPSearchSettings.\*.LDAPSearchSettingSearchBase**

> The path to the node where a search should start.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.ldap.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.ldap.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.ldap.account"

**profiles.ldap.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.ldap.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.ldap.account.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed**

> The payload that configures a Mail account.
>
> An email payload creates an email account on the device.
>
> *Type:* submodule

**profiles.mail.managed.enable**

> Whether to enable Enable the com.apple.mail.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.mail.managed.EmailAccountDescription**

> A user-visible description of the email account, shown in the Mail and
> Settings applications.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.EmailAccountName**

> The full user name for the account. The system displays this name in
> sent messages.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.EmailAccountType**

> Defines the protocol to use for the account.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "EmailTypeIMAP", "EmailTypePOP"

**profiles.mail.managed.EmailAddress**

> The full email address for the account. If this string isn't present
> in the payload, the device prompts the user for this string during
> interactive profile installation in Settings or System Preferences.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.IncomingMailServerAuthentication**

> The authentication scheme for incoming mail.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "EmailAuthNone", "EmailAuthPassword",
> "EmailAuthCRAMMD5", "EmailAuthNTLM", "EmailAuthHTTPMD5"

**profiles.mail.managed.IncomingMailServerHostName**

> The incoming mail server host name.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.mail.managed.IncomingMailServerIMAPPathPrefix**

> The path prefix for the IMAP mail server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.IncomingMailServerPortNumber**

> The incoming mail server port number. If not set, the system uses the
> default port for a given protocol.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.mail.managed.IncomingMailServerUseSSL**

> If 'true', the system enables SSL for authentication on the incoming
> mail server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.IncomingMailServerUsername**

> The user name for the email account, usually the same as the email
> address up to the "@" character. If not set and the account requires
> authentication for incoming email, the device prompts the user for
> this string during interactive profile installation in Settings or
> System Preferences.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.IncomingPassword**

> The password for the incoming mail server. Only use this in encrypted
> profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.OutgoingMailServerAuthentication**

> The authentication scheme for outgoing mail.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "EmailAuthNone", "EmailAuthPassword",
> "EmailAuthCRAMMD5", "EmailAuthNTLM", "EmailAuthHTTPMD5"

**profiles.mail.managed.OutgoingMailServerHostName**

> The outgoing mail server host name.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.mail.managed.OutgoingMailServerPortNumber**

> The outgoing mail server port number. If not set, the system uses
> ports 25, 587, and 465, in that order.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.mail.managed.OutgoingMailServerUseSSL**

> If 'true', the system enables SSL authentication on the outgoing mail
> server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.OutgoingMailServerUsername**

> The user name for the email account, usually the same as the email
> address up to the "@" character. If not set and the account requires
> authentication for outgoing email, the device prompts the user for
> this string during interactive profile installation in Settings or
> System Preferences.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.OutgoingPassword**

> The password for the outgoing mail server. Only use this in encrypted
> profiles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.OutgoingPasswordSameAsIncomingPassword**

> If 'true', the system prompts the user only once for the password,
> which it uses for both outgoing and incoming mail.
>
> This setting is only supported by interactive profile installations.
> Not supported by non-interactive installations, such as MDM on iOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.mail.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.mail.managed"

**profiles.mail.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.mail.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.mail.managed.PreventAppSheet**

> If 'true', the system prevents this account from sending mail in any
> app other than the Apple Mail app.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.PreventMove**

> If 'true', the system prevents moving messages out of this email
> account and into another account. It also prevents forwarding or
> replying from an account other than the recipient of the message.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEnableEncryptionPerMessageSwitch**

> If 'true', the system displays the per-message encryption switch in
> the Mail Compose UI.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEnablePerMessageSwitch**

> If 'true', the system displays the per-message encryption switch in
> the Mail Compose UI.\
> Deprecated in iOS 12.0. Use 'SMIMEEnableEncryptionPerMessageSwitch'
> instead.
>
> Requires: iOS \>= 8.0\
> Deprecated in iOS 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEnabled**

> If 'true', the system enables S/MIME encryption. The system ignores
> this key in iOS 10.0 and later.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEncryptByDefault**

> If 'true', the system enables S/MIME encryption by default.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEncryptByDefaultUserOverrideable**

> If 'true', the user can turn encryption by default on/off, and
> encryption is on.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEncryptionCertificateUUID**

> The UUID of the identity certificate used to decrypt messages sent to
> this account. The system attaches the public certificate to outgoing
> mail to allow the user to receive encrypted mail. When the user sends
> encrypted mail, the system uses the public certificate to encrypt the
> copy of the mail in their Sent mailbox.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEncryptionCertificateUUIDUserOverrideable**

> If 'true', the user can select the S/MIME encryption identity, and
> encryption is on.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMEEncryptionEnabled**

> If 'true', the system enables S/MIME encryption for this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMESigningCertificateUUID**

> The payload UUID of the identity certificate used to sign messages
> sent from this account.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMESigningCertificateUUIDUserOverrideable**

> If 'true', the user can select the signing identity.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMESigningEnabled**

> If 'true', the system enables S/MIME signing for this account.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.SMIMESigningUserOverrideable**

> If 'true', the user can turn S/MIME signing on or off in Settings.
>
> Requires: iOS \>= 12.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mail.managed.allowMailDrop**

> If 'true', the system enables this account to use Mail Drop.
>
> Requires: iOS \>= 9.2
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mail.managed.disableMailRecentsSyncing**

> If 'true', the system excludes this account from Recent Addresses
> syncing.
>
> Requires: iOS \>= 6.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mdm**

> The payload that configures mobile device management (MDM) settings.
>
> Also define the following four standard payload values in your MDM
> payload:
>
> > **•** 'PayloadIdentifier': The reverse-DNS style identifier that
> > identifies the profile; for example, 'com.example.myprofile'. The
> > system uses this value to determine whether to replace an existing
> > profile or add a new one.
>
> > **•** 'PayloadUUID': A globally unique identifier for the profile.
> > In macOS, you can use 'uuidgen' to generate this value.
>
> > **•** 'PayloadType': The payload type. Set to 'com.apple.mdm' to
> > designate that this payload is an MDM payload.
>
> > **•** 'PayloadVersion': The version number of the profile format,
> > which describes the version of the configuration profile as a whole,
> > not of the individual profiles within it. Set this value to '1'.
>
> > *""* Note: MDM reserves profile payload dictionary keys with the
> > *Payload* prefix. Don't treat them as managed preferences.
>
> *Type:* submodule

**profiles.mdm.enable**

> Whether to enable Enable the com.apple.mdm profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.mdm.AccessRights**

> Logical OR of the following bit flags:
>
> > **•** '1': Allow inspection of installed configuration profiles.
>
> > **•** '2': Allow installation and removal of configuration profiles.
>
> > **•** '4': Allow device lock and passcode removal.
>
> > **•** '8': Allow device erase.
>
> > **•** '16': Allow query of device information (device capacity,
> > serial number).
>
> > **•** '32': Allow query of network information (phone/SIM numbers,
> > MAC addresses).
>
> > **•** '64': Allow inspection of installed provisioning profiles.
>
> > **•** '128': Allow installation and removal of provisioning
> > profiles.
>
> > **•** '256': Allow inspection of installed applications.
>
> > **•** '512': Allow restriction-related queries.
>
> > **•** '1024': Allow security-related queries.
>
> > **•** '2048': Allow manipulation of settings.
>
> > **•** '4096': Allow app management.
>
> Don't set to '0'. Specify '1' if you specify '2'. Specify '64' if you
> specify '128'. Ignored if you set a value for 'ManagedAppleID'.
>
> > *""* Note: When updating the payload, the addition of any access
> > right is an error, and the update is rejected.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.mdm.AssignedManagedAppleID**

> The Managed Apple Account pre-assigned to the authenticated user.
> Required for account-driven enrollments. Available in iOS 15 and
> later, and macOS 14 and later.
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 15.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mdm.CheckInURL**

> The URL that the device should use to check in during installation.
> The URL must begin with the 'https://' URL scheme and may contain a
> port number (':1234', for example). If not set, the system uses
> 'ServerURL'.
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string matching the pattern \^https://.\*\$
>
> *Default:*
>
> > null

**profiles.mdm.CheckInURLPinningCertificateUUIDs**

> An array of strings, each containing the payload UUID of a certificate
> to use when evaluating trust to the '.../checkin/' URLs of MDM
> servers.
>
> Requires: iOS \>= 13.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.mdm.CheckOutWhenRemoved**

> If 'true', the device attempts to send a 'Check-Out' message to the
> 'CheckInURL' when the profile is removed.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mdm.EnrollmentMode**

> The enrollment mode the server indicates to use when enrolling.
> Required for account-driven enrollment. Available in iOS 15 and macOS
> 14, and later.
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 15.0
>
> *Type:* null or one of "BYOD", "ADDE"
>
> *Default:*
>
> > null

**profiles.mdm.IdentityCertificateUUID**

> The UUID of the certificate payload for the device's identity. It may
> also point to a SCEP payload.
>
> Requires: iOS \>= 4.0
>
> *Type:* string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$

**profiles.mdm.ManagedAppleID**

> The Managed Apple Account of the user. Previously required for
> profile-driven user enrollment. Removed as of iOS 18 and macOS 15.
>
> Requires: iOS \>= 13.1 and \< 18.0\
> Deprecated in iOS 17.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.mdm.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.mdm.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.mdm"

**profiles.mdm.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.mdm.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.mdm.PinningRevocationCheckRequired**

> If 'true', the system fails the connection attempt unless it obtains a
> verified positive response during certificate revocation checks. If
> 'false', the system performs revocation checks on a best- attempt
> basis, where failure to reach the server isn't considered fatal.
>
> Requires: iOS \>= 13.4
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mdm.RequiredAppIDForMDM**

> This property specifies an iTunes Store ID for an app the system can
> install with the InstallApplicationCommand, without any approval from
> the user. The MDM vendor or managing organization generally provides
> this app, which enhances the management experience for the user. The
> device shows the user details about this app in the account-driven
> enrollment process prior to installing the MDM profile. Use this
> property with account-driven MDM enrollments that normally require
> user approval for app installs through MDM. Only account-driven
> enrollments support this property and other enrollment types ignore
> it. Available in iOS 15.1 and later.
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 15.1
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.mdm.ServerCapabilities**

> A unique array of strings indicating server capabilities:
>
> > **•** 'com.apple.mdm.per-user-connections': Indicates that the
> > server supports both device and user connections. This must be
> > present when managing Shared iPad or macOS devices.
>
> > **•** 'com.apple.mdm.bootstraptoken': Indicates that the server
> > supports escrowing the bootstrap token. This must be present for the
> > device to create a bootstrap token and send it to the server.
> > Available in iOS 26 and later, macOS 11 and later, and visionOS 26
> > and later.
>
> > **•** 'com.apple.mdm.token': Indicates that the server supports the
> > 'Get-Token' CheckIn message type. This must be present for the
> > device to use 'Get-Token' CheckIn message when appropriate.
>
> > *""* Note: When updating the payload, the 'com.apple.mdm.per-user-
> > connections' capability must not be added or removed. Any such
> > change is an error, and the update is rejected.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (one of "com.apple.mdm.per-user-connections",
> "com.apple.mdm.bootstraptoken", "com.apple.mdm.token"))
>
> *Default:*
>
> > null

**profiles.mdm.ServerURL**

> The URL that the device contacts to retrieve device management
> instructions. The URL must begin with the 'https://' URL scheme, and
> may contain a port number (':1234', for example).
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 4.0
>
> *Type:* string matching the pattern \^https://.\*\$

**profiles.mdm.ServerURLPinningCertificateUUIDs**

> An array of strings, each containing the UUID of a certificate to use
> when evaluating trust to the '.../connect/' URLs of MDM servers.
>
> Requires: iOS \>= 13.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.mdm.SignMessage**

> If 'true', each message coming from the device carries the additional
> 'Mdm-Signature' HTTP header.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mdm.Topic**

> The topic that MDM listens to for push notifications. The certificate
> that the server uses to send push notifications must have the same
> topic in its subject. The topic must begin with the 'com.apple.mgmt.'
> prefix.
>
> > *""* Note: When updating the payload, the value of this key must not
> > change. Any change is an error, and the update is rejected.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.mdm.UseDevelopmentAPNS**

> If 'true', the device uses the development APNS servers. Otherwise,
> the device uses the production servers. Set to 'false' if your Apple
> Push Notification Service certificate was issued by the Apple Push
> Certificate Portal ('https://identity.apple.com/pushcert'). That
> portal only issues certificates for the production push environment.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mobileconfig**

> The generated iosConfiguration.mobileconfig file.
>
> *Type:* package *(read only)*

**profiles.mobiledevice.passwordpolicy**

> The payload that configures a passcode policy.
>
> The presence of this payload type causes the device to present the
> user with a passcode entry mechanism. The payload controls the
> complexity of the passcode.
>
> For user enrollments, the system allows this payload type, but ignores
> most of the keys. Instead, the presence of the payload forces only
> these settings:
>
> > **•** 'allowSimple': always set to 'false'
>
> > **•** 'forcePIN': always set to 'true'
>
> > **•** 'minLength': always set to '6'
>
> > **•** 'maxInactivity': if this key is present its value is ignored,
> > but the 'never' option is removed in the Settings UI.
>
> *Type:* submodule

**profiles.mobiledevice.passwordpolicy.enable**

> Whether to enable Enable the com.apple.mobiledevice.passwordpolicy
> profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.mobiledevice.passwordpolicy.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.mobiledevice.passwordpolicy.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.mobiledevice.passwordpolicy"

**profiles.mobiledevice.passwordpolicy.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.mobiledevice.passwordpolicy.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.mobiledevice.passwordpolicy.allowSimple**

> If 'false', the system prevents use of a simple passcode. A simple
> passcode contains repeated characters, or increasing or decreasing
> characters, such as '123' or 'CBA'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.forcePIN**

> If 'true', the system forces the user to enter a PIN.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.maxFailedAttempts**

> The number of failed passcode attempts that the system allows the user
> before it erases or locks the device. After six failed attempts, the
> device imposes a time delay before the user can enter a passcode
> again. The time delay increases with each failed attempt. On macOS,
> set 'minutesUntilFailedLoginReset' to define the time delay. The time
> delay begins after the sixth attempt, so if 'MaximumFailedAttempts' is
> six or lower, the system has no time delay and triggers the erase or
> lock as soon as the user exceeds the limit.
>
> After the final failed attempt, the system locks a macOS device, or
> securely erases all data and settings from an iOS, visionOS, or
> watchOS device.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 2 and 11 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.maxGracePeriod**

> The maximum grace period, in minutes, to unlock the phone without
> entering a passcode. The default is '0', which is no grace period and
> requires a passcode immediately. On macOS, the system translates this
> grace period value to screen- saver settings.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.maxInactivity**

> The maximum number of minutes for which the device can be idle without
> the user unlocking it, before the system locks it. When this limit is
> reached, the system locks the device and the passcode is required to
> unlock it. The user can edit this setting, but the value can't exceed
> the 'maxInactivity' value.
>
> On macOS, the system translates this inactivity value to screen-saver
> settings. The maximum value for macOS is '60'.
>
> Setting this key removes the 'never' option in the Settings UI on user
> enrolled devices.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 15 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.maxPINAgeInDays**

> The number of days for which the passcode can remain unchanged. After
> this number of days, the system forces the user to change the passcode
> before it unlocks the device.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 1 and 730 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.minComplexChars**

> The minimum number of complex characters that a passcode needs to
> contain. A *complex* character is a character other than a number or a
> letter, such as '&', '%', '\$', and '#'.
>
> The system ignores this property for user enrollments.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 4 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.minLength**

> The minimum overall length of the passcode. This value is independent
> of the value for 'minComplexChars'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 16 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.pinHistory**

> This value defines *N*, where the new passcode must be unique within
> the last *N* entries in the passcode history.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 1 and 50 (both inclusive)
>
> *Default:*
>
> > null

**profiles.mobiledevice.passwordpolicy.requireAlphanumeric**

> If 'true', the system requires alphabetic characters instead of only
> numeric characters.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.networkusagerules**

> The payload that configures network-usage rules.
>
> Network Usage Rules allow enterprises to specify how devices use
> networks, such as cellular data networks. iOS 9-12 support only
> ApplicationRules. In iOS 13, ApplicationRules, SIMRules, or both must
> be present.
>
> Network usage rules allow enterprises to specify how devices use
> networks, such as cellular data networks. iOS 9-12 require the
> application rules. In iOS 13, application rules, SIM rules, or both
> must be present.
>
> *Type:* submodule

**profiles.networkusagerules.enable**

> Whether to enable Enable the com.apple.networkusagerules profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.networkusagerules.ApplicationRules**

> An array of application rules, that apply to only managed apps.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.networkusagerules.ApplicationRules.\*.AllowCellularData**

> If 'false', disables cellular data for all matching managed apps.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.networkusagerules.ApplicationRules.\*.AllowRoamingCellularData**

> If 'false', disables cellular data while roaming for all matching
> managed apps.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.networkusagerules.ApplicationRules.\*.AppIdentifierMatches**

> A list of managed app identifiers, as strings, that must follow the
> associated rules. If this key is missing, the rules apply to all
> managed apps on the device.
>
> Each string in the 'AppIdentifierMatches' array may either be an exact
> app identifier match (for example, 'com.mycompany.myapp') or it may
> specify a prefix match for the bundle ID by using the \* wildcard
> character. If used, this character must appear after a period (.) and
> may only appear once, at the end of the string; for example,
> 'com.mycompany.\*'.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.networkusagerules.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.networkusagerules.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.networkusagerules"

**profiles.networkusagerules.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.networkusagerules.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.networkusagerules.SIMRules**

> An array of SIM rules, that apply to all apps.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.networkusagerules.SIMRules.\*.ICCIDs**

> One or more ICCIDs of SIM cards for which the 'WiFiAssistPolicy'
> applies. All ICCIDs in all installed Network Usage Rules payloads must
> be unique. An example ICCID is '89310410106543789301'.
>
> Requires: iOS \>= 13.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.networkusagerules.SIMRules.\*.WiFiAssistPolicy**

> The Wi-Fi Assist policy to apply to the SIM cards specified in the
> ICCIDs. Allowed values:
>
> > **•** '2': Use the default system policy for the specified SIM
> > card(s).
>
> > **•** '3': Make Wi-Fi Assist switch more aggressively from a poor
> > Wi-Fi connection to cellular data for the specified SIM card(s).
> > This setting may increase cellular data use and may impact battery
> > life.
>
> For more information, see **About Wi-Fi Assist**\[1\].
>
> Requires: iOS \>= 13.0
>
> *Type:* one of 2, 3
>
> > **1.** https://support.apple.com/en-us/HT205296

**profiles.notificationsettings**

> The payload that configures notifications.
>
> A notification settings payload specifies the restriction enforced
> notification settings for apps using their bundle identifier. The
> profile specifies notification settings by bundle identifier (even for
> apps that aren't installed on the device yet), and those settings will
> always be enforced.
>
> *Type:* submodule

**profiles.notificationsettings.enable**

> Whether to enable Enable the com.apple.notificationsettings profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.notificationsettings.NotificationSettings**

> An array of notification settings dictionaries.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* list of (submodule)

**profiles.notificationsettings.NotificationSettings.\*.AlertType**

> The type of alert for notifications for this app:
>
> > **•** '0': None
>
> > **•** '1': Temporary Banner
>
> > **•** '2': Persistent Banner
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or one of 0, 1, 2
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.BadgesEnabled**

> If 'true', enables badges for this app.
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.BundleIdentifier**

> The bundle identifier of the app to which to apply these notification
> settings.
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* string

**profiles.notificationsettings.NotificationSettings.\*.CriticalAlertEnabled**

> If 'true', enables critical alerts that can ignore Do Not Disturb and
> ringer settings for this app.
>
> Available in iOS 12 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.GroupingType**

> The type of grouping for notifications for this app:
>
> > **•** '0': Automatic: Group notifications into app-specified groups.
>
> > **•** '1': By app: Group notifications into one group.
>
> > **•** '2': Off: Don't group notifications.
>
> Available in iOS 12 and later.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or one of 0, 1, 2
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.NotificationsEnabled**

> If 'true', enables notifications for this app.
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.PreviewType**

> The type previews for notifications. This key overrides the value at
> Settings\>Notifications\>Show Previews.
>
> > **•** '0' - Always: Previews will be shown when the device is locked
> > and unlocked
>
> > **•** '1' - When Unlocked: Previews will only be shown when the
> > device is unlocked
>
> > **•** '2' - Never: Previews will never be shown
>
> Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0; supervised device
>
> *Type:* null or one of 0, 1, 2
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.ShowInCarPlay**

> If 'true', enables notifications in CarPlay for this app.
>
> Available in iOS 12 and later.
>
> Requires: iOS \>= 12.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.ShowInLockScreen**

> If 'true', enables notifications on the Lock Screen for this app.
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.ShowInNotificationCenter**

> If 'true', enables notifications in the notification center for this
> app.
>
> Available in iOS 9.3 and later and macOS 10.15 and later.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.NotificationSettings.\*.SoundsEnabled**

> If 'true', enables sounds for this app.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.notificationsettings.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.notificationsettings.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.notificationsettings"

**profiles.notificationsettings.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.notificationsettings.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.osxserver.account**

> The payload that configures a macOS Server account.
>
> *Type:* submodule

**profiles.osxserver.account.enable**

> Whether to enable Enable the com.apple.osxserver.account profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.osxserver.account.AccountDescription**

> The description of the account.
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.osxserver.account.ConfiguredAccounts**

> An array of dictionaries containing configured account types and
> relevant settings
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* list of (submodule)

**profiles.osxserver.account.ConfiguredAccounts.\*.Port**

> Designates the port number to use when contacting the server. If no
> port number is specified, the default port is used.
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.osxserver.account.ConfiguredAccounts.\*.Type**

> com.apple.osxserver.documents (the Documents account type).
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* value "com.apple.osxserver.documents" (singular enum)

**profiles.osxserver.account.HostName**

> The server's address.
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* string

**profiles.osxserver.account.Password**

> The user's password.
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.osxserver.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.osxserver.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.osxserver.account"

**profiles.osxserver.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.osxserver.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.osxserver.account.UserName**

> The user's user name.
>
> Requires: iOS \>= 9.0 and \< 12.0\
> Deprecated in iOS 12.0
>
> *Type:* string

**profiles.plist**

> The generated profiles file content.
>
> *Type:* string *(read only)*

**profiles.profileRemovalPassword**

> The payload that configures profile removal.
>
> This payload provides a password to allow users to remove a locked
> configuration profile from the device. If this payload is present and
> has a password value set, the device asks for the password when the
> user taps a profile's Remove button. This system encrypts the payload
> with the rest of the profile.
>
> *Type:* submodule

**profiles.profileRemovalPassword.enable**

> Whether to enable Enable the com.apple.profileRemovalPassword profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.profileRemovalPassword.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.profileRemovalPassword.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.profileRemovalPassword"

**profiles.profileRemovalPassword.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.profileRemovalPassword.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.profileRemovalPassword.RemovalPassword**

> The password to allow removing the profile.
>
> Requires: iOS \>= 4.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.proxy.http.global**

> The payload that configures a global HTTP proxy.
>
> PEM-encoded cer
>
> There can only be one payload of this type on the device at any time.
>
> *Type:* submodule

**profiles.proxy.http.global.enable**

> Whether to enable Enable the com.apple.proxy.http.global profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.proxy.http.global.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.proxy.http.global.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.proxy.http.global"

**profiles.proxy.http.global.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.proxy.http.global.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.proxy.http.global.ProxyCaptiveLoginAllowed**

> If 'true', allows the device to bypass the proxy server to display the
> login page for captive networks.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyPACFallbackAllowed**

> If 'true', allows connecting directly to the destination if the proxy
> autoconfiguration (PAC) file is unreachable.
>
> Requires: iOS \>= 7.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyPACURL**

> The URL of the PAC file that defines the proxy configuration. Starting
> in iOS 13 and macOS 10.15, only URLs that begin with 'http://' or
> 'https://' are allowed. This is only used if 'ProxyType' is set to
> 'Automatic', and is ignored if 'ProxyType' is set to 'Manual'.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyPassword**

> The password used to authenticate to the proxy server. The device only
> uses this if 'ProxyType' is set to 'Manual', and ignores it if
> 'ProxyType' is set to 'Automatic'.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyServer**

> The proxy server's network address. The device requires this if
> 'ProxyType' is set to 'Manual', and ignores it if 'ProxyType' is set
> to 'Automatic'.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyServerPort**

> The proxy server's port number. The device requires this if
> 'ProxyType' is set to 'Manual', and ignores this if 'ProxyType' is set
> to 'Automatic'.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyType**

> The proxy type. For a manual proxy type, the profile contains the
> proxy server address, including its port, and optionally a user name
> and password. For an auto proxy type, you can enter a PAC URL.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or one of "Manual", "Auto"
>
> *Default:*
>
> > null

**profiles.proxy.http.global.ProxyUsername**

> The user name used to authenticate to the proxy server. The device
> only uses this if 'ProxyType' is set to 'Manual', and ignores it if
> 'ProxyType' is set to 'Automatic'.
>
> Requires: iOS \>= 6.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.relay.managed**

> The payload that configures relay settings.
>
> *Type:* submodule

**profiles.relay.managed.enable**

> Whether to enable Enable the com.apple.relay.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.relay.managed.AllowDNSFailover**

> If 'true', the device allows the relay to failover to the default
> system DNS resolver.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.relay.managed.ExcludedDomains**

> A list of domain strings to exclude from routing through the servers
> in 'Relays'. Any connection that matches a domain in the list exactly
> or is a subdomain of the listed domain won't use the relay server.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.relay.managed.ExcludedFQDNs**

> A list of Fully Qualified Domain Names (FQDNs) to exclude from routing
> through the servers contained in 'Relays'. Any connection that matches
> an FQDN in the list exactly won't use the relay server. When
> 'MatchDomains' is also present, any FQDN listed in the list should be
> a subdomain of at least one 'MatchDomain' value, otherwise it will not
> have any effect.
>
> Requires: iOS \>= 18.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.relay.managed.MatchDomains**

> A list of domain strings that the system uses to determine which
> connection to route through the servers in 'Relays'.
>
> Any connection that matches a domain in the list exactly or is a
> subdomain of the listed domain uses the relay servers, unless it
> matches a domain in 'ExcludedDomains'.
>
> If this list and 'MatchFQDNs' are empty, the system routes traffic to
> all domains to the relay servers, except those that match an excluded
> domain or excluded FQDN.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.relay.managed.MatchFQDNs**

> A list of Fully Qualified Domain Names (FQDNs) to be routed through
> the servers contained in 'Relays'. Any connection that matches an FQDN
> in the list exactly uses the relay servers. If this list and
> 'MatchDomains' are empty, the system routes traffic to all domains to
> the relay servers, except those that match an excluded domain or
> excluded FQDN.
>
> Requires: iOS \>= 18.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.relay.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.relay.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.relay.managed"

**profiles.relay.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.relay.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.relay.managed.RelayUUID**

> A globally unique identifier for this relay configuration. The system
> uses this UUID to route managed apps through the servers in 'Relays'.
> This key is required for user enrollment.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.relay.managed.Relays**

> An array of dictionaries that describe one or more relay servers that
> the system can chain together.
>
> Requires: iOS \>= 17.0
>
> *Type:* list of (submodule)

**profiles.relay.managed.Relays.\*.AdditionalHTTPHeaderFields**

> A dictionary that contains custom HTTP header keys and values to add
> to each request. The dictionary key name represents the HTTP header
> field name to use, and the dictionary value is the string to use as
> the HTTP header field value.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (attribute set of string)
>
> *Default:*
>
> > null

**profiles.relay.managed.Relays.\*.HTTP2RelayURL**

> The URL or URI template, as defined in RFC 9298, of a relay server
> that's reachable using HTTP/2 and supports proxying TCP and UDP using
> the CONNECT method.
>
> Each relay needs to include either 'HTTP2RelayURL' or 'HTTP3RelayURL',
> or it can include both.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.relay.managed.Relays.\*.HTTP3RelayURL**

> The URL or URI template, as defined in RFC 9298, of a relay server
> that's reachable using HTTP/3 and supports proxying TCP and UDP using
> the CONNECT method.
>
> Each relay needs to include either 'HTTP2RelayURL' or 'HTTP3RelayURL',
> or it can include both.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.relay.managed.Relays.\*.PayloadCertificateUUID**

> The UUID that points to an identity certificate payload, which the
> system uses to authenticate the user to the relay server.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.relay.managed.Relays.\*.RawPublicKeys**

> An array of DER-encoded raw public keys that the system uses to
> authenticate the server during a TLS handshake. The server needs to
> use one of the keys in the handshake to authenticate.
>
> If this array is empty, the system uses the default TLS trust
> evaluation.
>
> Requires: iOS \>= 17.0
>
> *Type:* null or (list of (Written as string or path, read as {
> \_\_type = "data", value = \... }))
>
> *Default:*
>
> > null

**profiles.relay.managed.UIToggleEnabled**

> If 'true', the device allows the user to disable this network relay
> configuration.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.security.acme**

> The payload that configures Automated Certificate Management
> Environment (ACME) settings.
>
> Use this payload to specify how the device requests a client
> certificate from an Automated Certificate Management Environment
> (ACME) server. Other payloads can reference the resulting client
> identity by the payload's 'PayloadUUID'.
>
> First the device generates an asymmetric key pair based upon the
> 'KeyType', 'KeySize', and 'HardwareBound' fields. Then the device
> communicates with the ACME server. It requests a new order using the
> 'ClientIdentifier' as the 'permanent-identifier'. The ACME server
> responds with a challenge type of 'device-attest-01'. If 'Attest' is
> 'true' the device requests an attestation of the key and device
> properties. Then it replies to the challenge with a WebAuthn
> attestation statement, and this contains the attestation if the device
> obtained one. The device submits a certificate signing request
> matching the key and containing the 'ClientIdentifier', 'Subject',
> 'SubjectAltName', 'UsageFlags', and 'ExtendedKeyUsage' fields. The
> ACME server issues a certificate, and the device stores the resulting
> identity.
>
> For details on the content of the attestation provided to the ACME
> server, see the documentation of the 'DevicePropertiesAttestation' key
> in the 'QueryResponses'response. In the attestation certificate the
> value of the freshness code OID is the SHA-256 hash of the 'token'
> from the 'device- attest-01' challenge.
>
> *Type:* submodule

**profiles.security.acme.enable**

> Whether to enable Enable the com.apple.security.acme profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.acme.Attest**

> If 'true', the device provides attestations that describe the device
> and the generated key to the ACME server. The server can use the
> attestations as strong evidence that the key is bound to the device,
> and that the device has properties listed in the attestation. The
> server can use that as part of a trust score to decide whether to
> issue the requested certificate.
>
> When 'Attest' is 'true', 'HardwareBound' also needs to be 'true'.
>
> Setting this key to 'true' is supported as of macOS 14. Older macOS
> versions require this key but it must have a value of 'false'. See
> below for hardware requirements.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.security.acme.ClientIdentifier**

> A unique string identifying a specific device. The server may use this
> as an anti-replay code to prevent issuing multiple certificates. This
> identifier also indicates to the ACME server that the device has
> access to a valid client identifier issued by the enterprise
> infrastructure. This can help the ACME server determine whether to
> trust the device. Though this is a relatively weak indication because
> of the risk that an attacker can intercept the client identifier.
>
> Requires: iOS \>= 16.0
>
> *Type:* string

**profiles.security.acme.DirectoryURL**

> The directory URL of the ACME server. The URL must use the https
> scheme.
>
> Requires: iOS \>= 16.0
>
> *Type:* string

**profiles.security.acme.ExtendedKeyUsage**

> The value is an array of strings. Each string is an OID in dotted
> notation. For instance, '\[\"1.3.6.1.5.5.7.3.2\",
> \"1.3.6.1.5.5.7.3.4\"\]' indicates client authentication and email
> protection.
>
> The device requests this field for the certificate that the ACME
> server issues. The ACME server may override or ignore this field in
> the certificate it issues.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.security.acme.HardwareBound**

> If 'false', the private key isn't bound to the device.
>
> If 'true', the private key is bound to the device. The Secure Enclave
> generates the key pair, and the private key is cryptographically
> entangled with a system key. This prevents the system from exporting
> the private key.
>
> If 'true', 'KeyType' must be 'ECSECPrimeRandom' and 'KeySize' must be
> 256 or 384.
>
> Setting this key to 'true' is supported as of macOS 14 on Apple
> Silicon and Intel devices that have a T2 chip. Older macOS versions or
> other Mac devices require this key but it must have a value of
> 'false'.
>
> Requires: iOS \>= 16.0
>
> *Type:* boolean

**profiles.security.acme.KeySize**

> The valid values for 'KeySize' depend on the values of 'KeyType' and
> 'HardwareBound'. See those keys for specific requirements.
>
> Requires: iOS \>= 16.0
>
> *Type:* signed integer

**profiles.security.acme.KeyType**

> The type of key pair to generate. Allowed values:
>
> > **•** 'RSA': Specifies an RSA key pair. RSA key pairs need to have a
> > 'KeySize' that's a multiple of 8 in the range of 1024 through 4096
> > (inclusive), and 'HardwareBound' needs to be 'false'.
>
> > **•** 'ECSECPrimeRandom': Specifies a key pair on the P-192, P-256,
> > P-384, or P-521 curves as defined in FIPS Pub 186-4. 'KeySize'
> > defines the particular curve, which needs to be '192', '256', '384',
> > or '521'. Hardware bound keys only support values of '256' and
> > '384'.
>
> > *""* Note: The key size is '521', not '512', even though the other
> > key sizes are multiples of 64.
>
> Requires: iOS \>= 16.0
>
> *Type:* one of "RSA", "ECSECPrimeRandom"

**profiles.security.acme.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.acme.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.acme"

**profiles.security.acme.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.acme.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.acme.Subject**

> The device requests this subject for the certificate that the ACME
> server issues. The ACME server may override or ignore this field in
> the certificate it issues.
>
> The representation of a X.500 name represented as an array of OID and
> value. For example, '/C=US/O=Apple Inc./CN=foo/1.2.5.3=bar'
> corresponds to:
>
> '\[ \[ \[\"C\", \"US\"\] \], \[ \[\"O\", \"Apple Inc.\"\] \], \..., \[
> \[ \"1.2.5.3\", \"bar\" \] \] \]'
>
> Dotted numbers can represent OIDs , with shortcuts for country ©,
> locality (L), state (ST), organization (O), organizational unit (OU),
> and common name (CN).
>
> Requires: iOS \>= 16.0
>
> *Type:* list of list of list of string
>
> *Default:*
>
> > [ ]

**profiles.security.acme.SubjectAltName**

> The Subject Alt Name that the device requests for the certificate that
> the ACME server issues. The ACME server may override or ignore this
> field in the certificate it issues.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.security.acme.SubjectAltName.dNSName**

> The DNS name.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.acme.SubjectAltName.ntPrincipalName**

> The NT principal name. Use an other name OID set to
> '1.3.6.1.4.1.311.20.2.3'.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.acme.SubjectAltName.rfc822Name**

> The RFC 822 (email address) string.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.acme.SubjectAltName.uniformResourceIdentifier**

> The Uniform Resource Identifier.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.acme.UsageFlags**

> This value is a bit field.
>
> > **•** Bit '0x01' indicates digital signature.
>
> > **•** Bit '0x04' indicates encryption.
>
> The device requests this key for the certificate that the ACME server
> issues. The ACME server may override or ignore this field in the
> certificate it issues.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.security.certificaterevocation**

> The payload that configures certificate revocation checking.
>
> Policies that affect system-wide certificate revocation checking.
>
> *Type:* submodule

**profiles.security.certificaterevocation.enable**

> Whether to enable Enable the com.apple.security.certificaterevocation
> profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.certificaterevocation.EnabledForCerts**

> An array of certificates that the system checks for revocation.
>
> Specifying a certificate authority (CA) enables revocation checking
> for all certificates chaining up to that CA.
>
> It's not necessary to specify trusted root certificates because
> they're implicitly specified. See **https://support.apple.com/en-
> us/HT209143**\[1\] for the available trusted root certificates for
> Apple operating systems.
>
> Requires: iOS \>= 14.2
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null
>
> > **1.** https://support.apple.com/en-us/HT209143

**profiles.security.certificaterevocation.EnabledForCerts.\*.Algorithm**

> The algorithm must be 'sha256'.
>
> Requires: iOS \>= 14.2
>
> *Type:* value "sha256" (singular enum)

**profiles.security.certificaterevocation.EnabledForCerts.\*.Hash**

> The hash of the DER-encoding of the certificate's
> 'subjectPublicKeyInfo'.
>
> The hash field requires the data ('subjectPublicKeyInfo' hash) in a
> specific format: a Base64 encoded (binary) SHA-256 hash of the
> certificate's public key.
>
> Requires: iOS \>= 14.2
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.certificaterevocation.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.certificaterevocation.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.certificaterevocation"

**profiles.security.certificaterevocation.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.certificaterevocation.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.certificatetransparency**

> The payload that configures certificate transparency enforcement.
>
> Policies that affect system-wide certificate transparency enforcement.
>
> *Type:* submodule

**profiles.security.certificatetransparency.enable**

> Whether to enable Enable the
> com.apple.security.certificatetransparency profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.certificatetransparency.DisabledForCerts**

> An array of certificates for which certificate transparency is
> disabled. One of the following conditions needs to be met to disable
> certificate transparency enforcement when this policy is set:
>
> > **•** The hash is of the server certificate's
> > 'subjectPublicKeyInfo'.
>
> > **•** The hash is of a 'subjectPublicKeyInfo' that appears in a CA
> > certificate in the certificate chain; the CA certificate is
> > constrained through the X.509v3 'nameConstraints' extension. One or
> > more 'directoryName' 'nameConstraints' are present in the
> > 'permittedSubtrees', and the 'directoryName' contains an
> > 'organizationName' attribute.
>
> > **•** The hash is of a 'subjectPublicKeyInfo' that appears in a CA
> > certificate in the certificate chain. The CA certificate has one or
> > more 'organizationName' attributes in the certificate 'Subject', and
> > the server's certificate contains the same number of
> > 'organizationName' attributes, in the same order, and with
> > byte-for-byte identical values.
>
> Requires: iOS \>= 12.1.1
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.security.certificatetransparency.DisabledForCerts.\*.Algorithm**

> The algorithm must be 'sha256'.
>
> Requires: iOS \>= 12.1.1
>
> *Type:* value "sha256" (singular enum)

**profiles.security.certificatetransparency.DisabledForCerts.\*.Hash**

> The hash of the DER-encoding of the certificate's
> 'subjectPublicKeyInfo'.
>
> The hash field requires the data ('subjectPublicKeyInfo' hash) in a
> specific format: a Base64 encoded (binary) SHA-256 hash of the
> certificate's public key.
>
> Requires: iOS \>= 12.1.1
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.certificatetransparency.DisabledForDomains**

> An array of strings that represent the domains to exclude from
> certificate transparency enforcement. The system supports using a
> leading period ('.') to signify subdomains. However, the system
> doesn't support wildcards. If you include a leading period, the domain
> can't be a top-level domain, such as '.com' and '.co.uk'.
>
> Requires: iOS \>= 12.1.1
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.security.certificatetransparency.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.certificatetransparency.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.certificatetransparency"

**profiles.security.certificatetransparency.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.certificatetransparency.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.pem**

> The payload that configures a PEM-formatted certificate.
>
> PEM-encoded certificate without private key. May contain root
> certificates.
>
> *Type:* submodule

**profiles.security.pem.enable**

> Whether to enable Enable the com.apple.security.pem profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.pem.PayloadCertificateFileName**

> The file name of the enclosed certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.pem.PayloadContent**

> The binary representation of the payload, encoded in Base64.
>
> Requires: iOS \>= 4.0
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.pem.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.pem.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.pem"

**profiles.security.pem.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.pem.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.pkcs1**

> The payload that configures a PKCS #1-formatted certificate.
>
> DER-encoded certificate without private key. May contain root
> certificates.
>
> *Type:* submodule

**profiles.security.pkcs1.enable**

> Whether to enable Enable the com.apple.security.pkcs1 profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.pkcs1.PayloadCertificateFileName**

> The file name of the enclosed certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.pkcs1.PayloadContent**

> The binary representation of the payload, encoded in Base64.
>
> Requires: iOS \>= 4.0
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.pkcs1.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.pkcs1.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.pkcs1"

**profiles.security.pkcs1.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.pkcs1.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.pkcs12**

> The payload that configures a PKCS #12-formatted certificate.
>
> Password-protected identity certificate. Only one certificate may be
> included.
>
> > *""* Warning: The system obfuscates the profile but doesn't encrypt
> > it, so it's possible to intercept the profile and extract the
> > password and identity.
>
> It's recommended to omit the password in the profile, or do one of the
> following instead:
>
> > **•** Securely deliver the profile to authorized users only, such as
> > through MDM.
>
> > **•** Encrypt the profile so that only authorized devices can
> > decrypt it.
>
> > **•** Use 'SCEP' or 'ACMECertificate' to provision the identity.
>
> *Type:* submodule

**profiles.security.pkcs12.enable**

> Whether to enable Enable the com.apple.security.pkcs12 profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.pkcs12.Password**

> The password to the identity.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.pkcs12.PayloadCertificateFileName**

> The file name of the enclosed certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.pkcs12.PayloadContent**

> The binary representation of the payload, encoded in Base64.
>
> Requires: iOS \>= 4.0
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.pkcs12.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.pkcs12.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.pkcs12"

**profiles.security.pkcs12.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.pkcs12.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.root**

> The payload that configures a root certificate.
>
> Alias for com.apple.security.pkcs1.
>
> *Type:* submodule

**profiles.security.root.enable**

> Whether to enable Enable the com.apple.security.root profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.root.PayloadCertificateFileName**

> The file name of the enclosed certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.root.PayloadContent**

> The binary representation of the payload encoded in base64.
>
> Requires: iOS \>= 4.0
>
> *Type:* Written as string or path, read as { \_\_type = "data", value
> = \... }

**profiles.security.root.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.root.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.root"

**profiles.security.root.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.root.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.security.scep**

> The payload that configures Simple Certificate Enrollment Protocol
> (SCEP) settings.
>
> A SCEP payload automates the request of a client certificate from a
> SCEP server, as described in \[Over-the-Air Profile Delivery and
> Configuration\](https://develo
> per.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/iPhone
> OTAConfiguration/Introduction/Introduction.html).
>
> *Type:* submodule

**profiles.security.scep.enable**

> Whether to enable Enable the com.apple.security.scep profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.security.scep.PayloadContent**

> A dictionary containing the SCEP information.
>
> Requires: iOS \>= 4.0
>
> *Type:* submodule

**profiles.security.scep.PayloadContent.AllowAllAppsAccess**

> If 'true', all apps have access to the private key.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.CAFingerprint**

> The fingerprint of the Certificate Authority certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.Challenge**

> A preshared secret.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.\"Key Type\"**

> Always 'RSA'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.\"Key Usage\"**

> A bitmask indicating the use of the key. Possible values:
>
> > **•** '1': Signing
>
> > **•** '4': Encryption
>
> Some certificate authorities, such as Windows CA, support only
> encryption or signing, but not both at the same time.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.KeyIsExtractable**

> If 'false', the system disables exporting the private key from the
> keychain.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.Keysize**

> The key size, in bits.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 1024, 2048, 4096
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.Name**

> A string that's understood by the SCEP server; for example, a domain
> name like example.org. If a certificate authority has multiple CA
> certificates, this field can be used to distinguish which is required.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.Retries**

> The number of times the device should retry if the server sends a
> PENDING response.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.RetryDelay**

> The number of seconds to wait between subsequent retries. The first
> retry is attempted without this delay.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.Subject**

> The representation of an X.500 name as an array of OID and value.
>
> For example, '/C=US/O=Apple Inc./CN=foo/1.2.5.3=bar' translates to '\[
> \[ \[\"C\", \"US\"\] \], \[ \[\"O\", \"Apple Inc.\"\] \], ..., \[ \[
> \"1.2.5.3\", \"bar\" \] \] \]'.
>
> OIDs can be represented as dotted numbers, with shortcuts for country
> ©, locality (L), state (ST), organization (O), organizational unit
> (OU), and common name (CN).
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of list of list of string)
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.SubjectAltName**

> The SCEP payload can specify an optional 'SubjectAltName' dictionary
> that provides values required by the CA for issuing a certificate. You
> can specify a single string or an array of strings for each key. The
> values you specify depend on the CA you're using, but might include
> DNS name, URL, or email values. For an example, see Sample
> Configuration Profile or Over-the-Air Profile Delivery and
> Configuration.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.SubjectAltName.dNSName**

> The DNS name.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.SubjectAltName.ntPrincipalName**

> The NT principal name. Use an other name OID set to
> '1.3.6.1.4.1.311.20.2.3'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.SubjectAltName.rfc822Name**

> The RFC 822 (email address) string.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.SubjectAltName.uniformResourceIdentifier**

> The Uniform Resource Identifier.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.security.scep.PayloadContent.URL**

> The SCEP URL. See Over-the-Air Profile Delivery and Configuration for
> more information about SCEP.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.security.scep.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.security.scep.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.security.scep"

**profiles.security.scep.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.security.scep.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.setupAssistant.managed**

> The payload that configures Setup Assistant settings.
>
> On macOS, this payload can specify Setup Assistant options for either
> the system or particular users.
>
> *Type:* submodule

**profiles.setupAssistant.managed.enable**

> Whether to enable Enable the com.apple.SetupAssistant.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.setupAssistant.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.setupAssistant.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.SetupAssistant.managed"

**profiles.setupAssistant.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.setupAssistant.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.setupAssistant.managed.SkipSetupItems**

> An array of strings that describe the setup items to skip. 'SkipKeys'
> provides a list of valid strings and their meanings. Available in iOS
> 14 and later, and macOS 15 and later.
>
> Requires: iOS \>= 14.0; supervised device
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.shareddeviceconfiguration**

> The payload that configures a Lock Screen message.
>
> Allows admins to specify optional text displayed on the Login Window
> and Lock Screen (i.e. a footnote and Asset Tag Information).
>
> This payload allows administrators to specify optional text displayed
> in the Login Window and Lock Screen (for example, an "If Lost, Return
> To" message and asset tag information). There can only be one Lock
> Screen payload.
>
> *Type:* submodule

**profiles.shareddeviceconfiguration.enable**

> Whether to enable Enable the com.apple.shareddeviceconfiguration
> profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.shareddeviceconfiguration.AssetTagInformation**

> The asset tag information for the device, displayed in the Login
> Window and Lock Screen.
>
> Requires: iOS \>= 9.3; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.shareddeviceconfiguration.IfLostReturnToMessage**

> Deprecated. Use 'LockScreenFootnote' instead.
>
> Requires: iOS \>= 9.3; supervised device\
> Deprecated in iOS 9.3.1
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.shareddeviceconfiguration.LockScreenFootnote**

> The footnote displayed in the Login Window and Lock Screen.
>
> Requires: iOS \>= 9.3.1; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.shareddeviceconfiguration.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.shareddeviceconfiguration.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.shareddeviceconfiguration"

**profiles.shareddeviceconfiguration.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.shareddeviceconfiguration.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.sso**

> The payload that configures single sign-on (SSO).
>
> Deprecated in iOS 26. Use the 'ExtensibleSingleSignOn' payload
> instead.
>
> *Type:* submodule

**profiles.sso.enable**

> Whether to enable Enable the com.apple.sso profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.sso.Kerberos**

> The Kerberos dictionary.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.sso.Kerberos.AppIdentifierMatches**

> The list of app identifiers that the system allows to use this login.
> If this field missing, the system matches all app identifiers with
> this login.
>
> Don't set an empty array. The array needs to contain strings that
> match App Bundle IDs. These strings can be exact matches such as
> 'com.mycompany.myapp', or they may specify a prefix match on the
> Bundle ID by using the '\*' wildcard character. The wildcard character
> needs to appear after a period ('.'), and may only appear once, at the
> end of the string, for example, 'com.mycompany.\*'. When you provide a
> wildcard, the system grants access to the account to any app with a
> Bundle ID that begins with the prefix.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.sso.Kerberos.PayloadCertificateUUID**

> The 'PayloadUUID' of an identity certificate payload that the system
> can use to renew the Kerberos credential without user interaction. Set
> the payload type to either 'com.apple.security.pkcs12' or
> 'com.apple.security.scep' in the certificate payload. The
> configuration file needs to contain both the SSO payload and the
> identity certificate payload.
>
> Requires: iOS \>= 8.0\
> Deprecated in iOS 26.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.sso.Kerberos.PrincipalName**

> The principal name. If not provided, the system prompts the user for
> one during profile installation. Required for MDM installation.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.sso.Kerberos.Realm**

> The properly capitalized realm name.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* string

**profiles.sso.Kerberos.URLPrefixMatches**

> The list of URL prefixes to match in order to use this account for
> Kerberos authentication over HTTP. If this key is missing, the system
> makes the account eligible to match all 'http://' and 'https://' URLs.
>
> Begin the URL matching patterns with either 'http://' or 'https://'.
> The system performs a simple string match, so the URL prefix
> 'http://www.apple.com/' doesn't match 'http://www.apple.com:80/'.
> However, if a matching pattern doesn't end in '/', the system
> automatically append a '/' to it.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.sso.Name**

> The human-readable name for the account.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 26.0
>
> *Type:* string

**profiles.sso.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.sso.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.sso"

**profiles.sso.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.sso.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.subscribedcalendar.account**

> The payload that configures subscribed calendars.
>
> *Type:* submodule

**profiles.subscribedcalendar.account.enable**

> Whether to enable Enable the com.apple.subscribedcalendar.account
> profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.subscribedcalendar.account.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.subscribedcalendar.account.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.subscribedcalendar.account"

**profiles.subscribedcalendar.account.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.subscribedcalendar.account.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.subscribedcalendar.account.SubCalAccountDescription**

> The description of the account.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.subscribedcalendar.account.SubCalAccountHostName**

> The server's address.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.subscribedcalendar.account.SubCalAccountPassword**

> The user's password.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.subscribedcalendar.account.SubCalAccountUseSSL**

> If 'true', the system enables SSL.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.subscribedcalendar.account.SubCalAccountUsername**

> The user's user name.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.subscribedcalendar.account.VPNUUID**

> The VPNUUID of the per-app VPN the account uses for network
> communication. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.tvremote**

> The payload that configures the Apple TV remote.
>
> *Type:* submodule

**profiles.tvremote.enable**

> Whether to enable Enable the com.apple.tvremote profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.tvremote.AllowedTVs**

> The array of valid Apple TV identifiers that the remote can connect
> to.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.tvremote.AllowedTVs.\*.TVDeviceID**

> The MAC address of an Apple TV device that the system permits this iOS
> device to control. Use the format 'xx:xx:xx:xx:xx:xx', which isn't
> case-sensitive.
>
> Requires: iOS \>= 11.3; supervised device
>
> *Type:* string

**profiles.tvremote.AllowedTVs.\*.TVDeviceName**

> The name of an Apple TV device that the system permits this iOS device
> to control.
>
> Requires: iOS \>= 15.0; supervised device
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.tvremote.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.tvremote.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.tvremote"

**profiles.tvremote.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.tvremote.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.vpn.managed**

> The payload that configures a VPN.
>
> *Type:* submodule

**profiles.vpn.managed.enable**

> Whether to enable Enable the com.apple.vpn.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.vpn.managed.AlwaysOn**

> The dictionary to use when 'VPNType' is 'AlwaysOn'. Not available in
> tvOS or watchOS.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.AllowAllCaptiveNetworkPlugins**

> If '1', allows traffic from all captive networking apps outside the
> VPN tunnel to perform captive network handling.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.AllowCaptiveWebSheet**

> If '1', allows traffic from Captive Web Sheet outside the VPN tunnel.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.AllowedCaptiveNetworkPlugins**

> The array of captive networking apps whose traffic is allowed outside
> the VPN tunnel, to perform captive network handling. Used only when
> 'AllowAllCaptiveNetworkPlugins' is 'false'.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.AllowedCaptiveNetworkPlugins.\*.BundleIdentifier**

> The bundle identifier for the app that's allowed on the captive
> network.
>
> Requires: iOS \>= 8.0
>
> *Type:* string

**profiles.vpn.managed.AlwaysOn.ApplicationExceptions**

> An array that contains an arbitrary number of apps whose connections
> occur outside the VPN.
>
> Requires: iOS \>= 13.6
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.ApplicationExceptions.\*.BundleIdentifier**

> The app's bundle identifier.
>
> Requires: iOS \>= 13.6
>
> *Type:* string

**profiles.vpn.managed.AlwaysOn.ApplicationExceptions.\*.LimitToProtocols**

> Limit the exception to only the specified list of protocols, with
> support for 'UDP' only.
>
> Requires: iOS \>= 13.6
>
> *Type:* null or (list of value "UDP" (singular enum))
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.ServiceExceptions**

> An array that contains an arbitrary number of service exceptions.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.ServiceExceptions.\*.Action**

> The action to take with network connections from the named service.
>
> Requires: iOS \>= 8.0
>
> *Type:* one of "Allow", "Drop"

**profiles.vpn.managed.AlwaysOn.ServiceExceptions.\*.ServiceName**

> The name of a service that's exempt from Always On VPN.
>
> 'CellularServices' is available in iOS 11.3 and later; it exempts
> 'VoLTE', 'IMS' and 'MMS'. WiFiCalling is exempted in iOS 13.4 and
> later.
>
> 'DeviceCommunication' is available in iOS 17.4 and later; it exempts
> network traffic used for communicating with devices connected via USB
> or Wi-Fi.
>
> Requires: iOS \>= 8.0
>
> *Type:* one of "VoiceMail", "AirPrint", "CellularServices",
> "DeviceCommunication"

**profiles.vpn.managed.AlwaysOn.TunnelConfigurations**

> An array that contains an arbitrary number of tunnel configurations.
>
> Requires: iOS \>= 8.0
>
> *Type:* list of (submodule)

**profiles.vpn.managed.AlwaysOn.TunnelConfigurations.\*.Interfaces**

> The interfaces to apply this configuration to.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or (list of (one of "Cellular", "WiFi"))
>
> *Default:*
>
> > null

**profiles.vpn.managed.AlwaysOn.TunnelConfigurations.\*.ProtocolType**

> The type of connection, which needs to be 'IKEv2'.
>
> Requires: iOS \>= 8.0
>
> *Type:* value "IKEv2" (singular enum)

**profiles.vpn.managed.AlwaysOn.UIToggleEnabled**

> If '1', allows the user to disable the VPN configuration.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS**

> A dictionary to use for all VPN types.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.DNSProtocol**

> The transport protocol to communicate with the DNS server.
>
> Requires: iOS \>= 14.0
>
> *Type:* one of "Cleartext", "HTTPS", "TLS"

**profiles.vpn.managed.DNS.DomainName**

> The primary domain of the tunnel.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.PayloadCertificateUUID**

> That UUID that points to an identity certificate payload. The system
> uses this identity to authenticate the user to the DNS resolver.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.SearchDomains**

> The list of domain strings used to fully qualify single- label host
> names.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.ServerAddresses**

> The array of DNS server IP address strings. These IP addresses can be
> a mixture of IPv4 and IPv6 addresses.
>
> Requires: iOS \>= 10.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.vpn.managed.DNS.ServerName**

> The hostname of a DNS-over-TLS server to validate the server
> certificate, as defined in RFC 7858. If 'ServerAddresses' isn't
> specified, the system uses the hostname to determine the server
> addresses. This key is required if the 'DNSProtocol' is 'TLS'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.ServerURL**

> The URI template of a DNS-over-HTTPS server, as defined in RFC 8484,
> which needs to use the 'https://' scheme. The system uses the hostname
> or address in the URL to validate the server certificate. If
> 'ServerAddresses' isn't specified, the system uses the hostname or
> address in the URL to determine the server addresses. This key is
> required if the 'DNSProtocol' is 'HTTPS'.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.SupplementalMatchDomains**

> The list of domain strings used to determine which DNS queries use the
> DNS resolver settings in 'ServerAddresses'. The system uses this key
> to create a split DNS configuration where it resolves only hosts in
> certain domains using the tunnel's DNS resolver. The system uses the
> default resolver for hosts that aren't in one of the domains in this
> list.
>
> If 'SupplementalMatchDomains' contains the empty string it becomes the
> default domain.
>
> Split-tunnel configurations can direct all DNS queries to the VPN DNS
> servers before the primary DNS servers. If the VPN tunnel becomes the
> network's default route, the servers listed in 'ServerAddresses'
> become the default resolver and the system ignores the
> 'SupplementalMatchDomains' list.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.DNS.SupplementalMatchDomainsNoSearch**

> If '0', append the domains in the 'SupplementalMatchDomains' list to
> the resolver's list of search domains.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2**

> The dictionary to use when 'VPNType' is 'IKEv2'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.AllowPostQuantumKeyExchangeFallback**

> If set to '0', the VPN doesn't establish a connection if the server
> does not support or doesn't allow post-quantum key exchanges. Thd
> device ignores this key if 'PostQuantumKeyExchangeMethods' is not
> present in 'IKESecurityAssociationParameters' or
> 'ChildSecurityAssociationParameters'.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.AuthName**

> The user name to use for authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.AuthPassword**

> The password to use for authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.AuthenticationMethod**

> The type of authentication method for the VPN.
>
> To enable EAP-only authentication, set this to 'None' and
> 'ExtendedAuthEnabled' to '1'. If this is 'None' and the
> 'ExtendedAuthEnabled' key isn't set, the authentication configuration
> defaults to 'SharedSecret'.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "None", "SharedSecret", "Certificate"

**profiles.vpn.managed.IKEv2.CertificateType**

> The type of 'PayloadCertificateUUID' to use for IKEv2 machine
> authentication. If this key is included, the system requires a value
> for 'ServerCertificateIssuerCommonName'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "RSA", "ECDSA256", "ECDSA384", "ECDSA521",
> "RSA-PSS"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters**

> The 'ChildSecurityAssociationParameters' dictionaries.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters.DiffieHellmanGroup**

> The Diffie-Hellman group.
>
> For 'AlwaysOn' VPN in iOS 14.2 and later, the minimum allowed value is
> '14'.
>
> '1', '2', and '5' are available only in iOS, macOS, and visionOS prior
> to iOS 26, macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 1, 2, 5, 14, 15, 16, 17, 18, 19, 20, 21, 31, 32
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters.EncryptionAlgorithm**

> The encryption algorithm.
>
> In watchOS and tvOS, the default value is 'AES-256-GCM'. 'DES' and
> '3DES' are available only in iOS, macOS, and visionOS prior to iOS 26,
> macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "DES", "3DES", "AES-128", "AES-256",
> "AES-128-GCM", "AES-256-GCM", "ChaCha20Poly1305"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters.IntegrityAlgorithm**

> The integrity algorithm.
>
> 'SHA1-96' and 'SHA1-160' are available only in iOS, macOS, and
> visionOS prior to iOS 26, macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "SHA1-96", "SHA1-160", "SHA2-256", "SHA2-384",
> "SHA2-512"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters.LifeTimeInMinutes**

> The SA lifetime (rekey interval) in minutes.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 10 and 1440 (both inclusive)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ChildSecurityAssociationParameters.PostQuantumKeyExchangeMethods**

> An array of strings representing postquantum key exchange methods the
> device uses during SA establishment and rekey. You can specify up to
> seven items, which correspond to ADDKE1 - ADDKE7 from RFC 9370.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or (list of (one of 0, 36, 37))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.DeadPeerDetectionRate**

> One of the following:
>
> > **•** 'None': No keepalive.
>
> > **•** 'Low': Send keepalive every 30 minutes.
>
> > **•** 'Medium': Send keepalive every 10 minutes.
>
> > **•** 'High': Send keepalive every 1 minute.
>
> Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "None", "Low", "Medium", "High"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.DisableMOBIKE**

> If '1', the system disables MOBIKE.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.DisableRedirect**

> If '1', the system disables IKEv2 redirect. If not set, the system
> redirects an IKEv2 connection when it receives a redirect request from
> the server.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.DisconnectOnIdle**

> If '1', the VPN disconnects automatically after a period defined by
> 'DisconnectOnIdleTimer'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.DisconnectOnIdleTimer**

> Only used if 'DisconnectOnIdle' is '1'. The number of seconds before
> the VPN disconnects. On watchOS, maximum allowed value is 15 seconds
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.EnableCertificateRevocationCheck**

> If '1', the system performs a certificate revocation check for IKEv2
> connections. This is a best-effort revocation check and server
> response timeouts won't cause it to fail.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.EnableFallback**

> If '1', the system enables a tunnel over cellular data to carry
> traffic that's eligible for Wi-Fi Assist and also requires VPN.
>
> Enabling fallback requires that the server support multiple tunnels
> for a single user.
>
> This field is available in iOS 13 and later, and tvOS 17 and later.
> Not available in watchOS.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.EnablePFS**

> If '1', enables Perfect Forward Secrecy (PFS) for IKEv2 Connections.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.EnforceRoutes**

> If '1', all the VPN's non-default routes take precedence over any
> locally-defined routes. If 'IncludeAllNetworks' is '1', the system
> ignores 'EnforceRoutes'.
>
> Requires: iOS \>= 14.2
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.EnforceStrictAlgorithmSelection**

> If set to '1', the device doesn't allow DES, 3DES, and Diffie-Hellman
> groups less than 14. Also the device requires the encryption algorithm
> specified for the IKE SA to be at least as cryptographically strong as
> the algorithm specified for the child SA. The device rejects this
> profile payload if these requirements are not met.
>
> Requires: iOS \>= 18.5
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ExcludeAPNs**

> If '1' and 'IncludeAllNetworks' is '1', the system excludes network
> traffic for the Apple Push Notification service (APNs) from the
> tunnel.
>
> Requires: iOS \>= 16.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ExcludeCellularServices**

> If '1' and 'IncludeAllNetworks' is '1', the system excludes
> internet-routable network traffic for cellular services (VoLTE, Wi-Fi
> Calling, IMS, MMS, Visual Voicemail, etc.) from the tunnel. Note that
> some cellular carriers route cellular services traffic directly to the
> carrier network, bypassing the internet. Such cellular services
> traffic is always excluded from the tunnel.
>
> Requires: iOS \>= 16.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ExcludeDeviceCommunication**

> If set to '1' and 'IncludeAllNetworks' is set to '1', the device
> excludes network traffic used for communicating with devices connected
> via USB or Wi-Fi from the tunnel.
>
> Requires: iOS \>= 17.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ExcludeLocalNetworks**

> If '1' and either 'IncludeAllNetworks' or 'EnforceRoutes' are '1',
> then the system routes local network traffic outside of the VPN. The
> default for this value is '0' on macOS and '1' on iOS.
>
> Requires: iOS \>= 14.2
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ExtendedAuthEnabled**

> If '1', enables EAP-only authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters**

> These parameters apply to Child Security Association unless
> 'ChildSecurityAssociationParameters' is specified.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters.DiffieHellmanGroup**

> The Diffie-Hellman group.
>
> For 'AlwaysOn' VPN in iOS 14.2 and later, the minimum allowed value is
> '14'.
>
> '1', '2', and '5' are available only in iOS, macOS, and visionOS prior
> to iOS 26, macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 1, 2, 5, 14, 15, 16, 17, 18, 19, 20, 21, 31, 32
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters.EncryptionAlgorithm**

> The encryption algorithm.
>
> In watchOS and tvOS, the default value is 'AES-256-GCM'. 'DES' and
> '3DES' are available only in iOS, macOS, and visionOS prior to iOS 26,
> macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "DES", "3DES", "AES-128", "AES-256",
> "AES-128-GCM", "AES-256-GCM", "ChaCha20Poly1305"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters.IntegrityAlgorithm**

> The integrity algorithm.
>
> 'SHA1-96' and 'SHA1-160' are available only in iOS, macOS, and
> visionOS prior to iOS 26, macOS 26, and visionOS 26.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "SHA1-96", "SHA1-160", "SHA2-256", "SHA2-384",
> "SHA2-512"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters.LifeTimeInMinutes**

> The SA lifetime (rekey interval) in minutes.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 10 and 1440 (both inclusive)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IKESecurityAssociationParameters.PostQuantumKeyExchangeMethods**

> An array of strings representing postquantum key exchange methods the
> device uses during SA establishment and rekey. You can specify up to
> seven items, which correspond to ADDKE1 - ADDKE7 from RFC 9370.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or (list of (one of 0, 36, 37))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.IncludeAllNetworks**

> If '1', then the system routes all network traffic through the VPN,
> with some controllable exclusions, such as 'ExcludeLocalNetworks',
> 'ExcludeCellularServices', and 'ExcludeAPNs' properties. The system
> always excludes the following traffic from the tunnel:
>
> > **•** Traffic necessary for connecting and maintaining the device's
> > network connection, such as DHCP.
>
> > **•** Traffic necessary for connecting to captive networks.
>
> > **•** Certain cellular services traffic that's not routable over the
> > internet and is instead directly routed to the cellular network. See
> > the 'ExcludeCellularServices' field for more information.
>
> > **•** Network communication with a companion device such as a
> > watchOS device.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.LocalIdentifier**

> Identifier of the IKEv2 client.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.vpn.managed.IKEv2.MTU**

> The Maximum Transmission Unit (MTU) specifies the maximum size in
> bytes of each packet that the system sends over the IKEv2 VPN
> interface. Available in iOS 14 and later, and macOS 11 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or integer between 1280 and 1400 (both inclusive)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.NATKeepAliveInterval**

> The NAT Keepalive interval for Always On VPN IKEv2 connections. This
> value controls the interval that the device sends keepalive offload
> packets. The minimum value is 20 seconds. If no key is specified, the
> default is 20 seconds over Wi-Fi and 110 seconds over a cellular
> interface.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.NATKeepAliveOffloadEnable**

> If '1', enables NAT keepalive offload for Always On VPN IKEv2
> connections. The device sends keepalive packets to maintain NAT
> mappings for IKEv2 connections that have a NAT on the path. It sends
> keepalive packets at regular intervals when the device is awake. If
> 'NATKeepAliveOffloadEnable' is '1', the system offloads keepalive
> packets to hardware while the device is asleep.
>
> NAT keepalive offload has an impact on the battery life due to the
> extra workload during sleep. The default interval for the keepalive
> offload packets is 20 seconds over Wi-Fi and 110 seconds over Cellular
> interface. The default NAT keepalive works well on networks with small
> NAT mapping timeouts but imposes a potential battery impact. If a
> network has larger NAT mapping timeouts, larger keepalive intervals
> may be safely used to minimize battery impact. Modify the keepalive
> interval through the 'NATKeepAliveInterval' key.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandEnabled**

> If '1', enables VPN up on demand.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules**

> A list of rules that determine when and how to use an OnDemand VPN.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.Action**

> The action to take if this dictionary matches the current network.
> Possible values are:
>
> > **•** 'Allow': Deprecated. Allow VPN On Demand to connect if
> > triggered.
>
> > **•** 'Connect': Unconditionally initiate a VPN connection on the
> > next network attempt.
>
> > **•** 'Disconnect': Tear down the VPN connection and don't reconnect
> > on demand as long as this dictionary matches.
>
> > **•** 'EvaluateConnection': Evaluate the ActionParameters array for
> > each connection attempt.
>
> > **•** 'Ignore': Leave any existing VPN connection up, but don't
> > reconnect on demand as long as this dictionary matches. Only the
> > 'Disconnect' action is available on watchOS 10 and later.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "Allow", "Connect", "Disconnect", "EvaluateConnection",
> "Ignore"

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.ActionParameters**

> An array of dictionaries that provides rules similar to the
> 'OnDemandRules' dictionary, but evaluated on each connection instead
> of when the network changes. This value is only for use with
> dictionaries in which the 'Action' value is 'EvaluateConnection'. The
> system evaluates these dictionaries in order and the first dictionary
> that matches determines the behavior. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.ActionParameters.\*.DomainAction**

> Defines the VPN behavior for the specified domains. Allowed values
> are:
>
> > **•** 'ConnectIfNeeded': The specified domains should trigger a VPN
> > connection attempt if domain name resolution fails, such as when the
> > DNS server indicates that it can't resolve the domain, responds with
> > a redirection to a different server, or fails to respond (timeout).
>
> > **•** 'NeverConnect': The specified domains should never trigger a
> > VPN connection attempt.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "ConnectIfNeeded", "NeverConnect"

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.ActionParameters.\*.Domains**

> The domains to apply this evaluation.
>
> Requires: iOS \>= 4.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.ActionParameters.\*.RequiredDNSServers**

> An array of IP addresses of DNS servers to use for resolving the
> specified domains. These servers don't need to be part of the device's
> current network configuration. If these DNS servers aren't reachable,
> the system establishes a VPN connection. These DNS servers need to be
> either internal DNS servers or trusted external DNS servers. This key
> is valid only if the value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.ActionParameters.\*.RequiredURLStringProbe**

> An HTTP or HTTPS (preferred) URL to probe, using a GET request. If the
> URL's hostname can't be resolved, if the server is unreachable, or if
> the server doesn't respond with a 200 HTTP status code, a VPN
> connection is established in response. This key is valid only if the
> value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.DNSDomainMatch**

> An array of domain names. This rule matches if any of the domain names
> in the specified list matches any domain in the device's search
> domains list. The system supports a wildcard ('\*') prefix. For
> example, '\*.example.com' matches against either
> 'mydomain.example.com' or 'yourdomain.example.com'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.DNSServerAddressMatch**

> An array of IP addresses. This rule matches if any of the network's
> specified DNS servers match any entry in the array. The system
> supports matching with a single wildcard. For example, '17.\*' matches
> any DNS server in the '17.0.0.0/8' subnet.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.InterfaceTypeMatch**

> An interface type. If specified, this rule matches only if the primary
> network interface hardware matches the specified type.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "Ethernet", "WiFi", "Cellular"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.SSIDMatch**

> An array of SSIDs to match against the current network. If the network
> isn't a Wi-Fi network or if the SSID doesn't appear in this array, the
> match fails. Omit this key and the corresponding array to match
> against any SSID.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandRules.\*.URLStringProbe**

> A URL to probe. This rule matches when this URL is successfully
> fetched (returns a '200' HTTP status code) without redirection. Not
> available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.OnDemandUserOverrideDisabled**

> If '1', the system disables the Connect On Demand toggle in Settings
> for this configuration.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.PPK**

> The Post-quantum Pre-shared key (PPK) the device uses for this VPN.
> This key is is used with VPN servers that support RFC 8784. If this
> key is present 'PPKIdentifier' must also be present.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.PPKIdentifier**

> The identifier for the Post-quantum Pre-shared key (PPK) the device
> uses for this VPN. This key is is used with VPN servers that support
> RFC 8784. If this key is present 'PPK' must also be present.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.PPKMandatory**

> If set to '1', the VPN doesn't establish a connection if the server
> doesn't support RFC 8784 or doesn't accept the PPK identifier
> specified in 'PPKIdentifier'. The device ignores this key if 'PPK' and
> 'PPKIdentifier' are not present.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.Password**

> The password to use for the account credentials. Only used if
> 'AuthenticationMethod' is 'Password'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile to use as
> the account credential. If the value of 'AuthenticationMethod' is
> 'Certificate', the system sends this certificate out for IKEv2 machine
> authentication. If extended authentication (EAP) is used, the system
> sends this certificate out for EAP-TLS authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ProviderBundleIdentifier**

> If the VPNSubType field contains the bundle identifier of an app that
> contains multiple VPN providers of the same type (app-proxy or
> packet-tunnel), then the system uses this field to choose which
> provider to use for this configuration. If the VPN provider is
> implemented as a System Extension, then this field is required.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ProviderType**

> If the value of this key is 'app-proxy', the VPN service tunnels
> traffic at the application layer. If the value of this key is
> 'packet-tunnel', the VPN service tunnels traffic at the IP layer.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "packet-tunnel", "app-proxy"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.RemoteAddress**

> The IP address or host name of the VPN server.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.vpn.managed.IKEv2.RemoteIdentifier**

> The remote identifier.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.vpn.managed.IKEv2.ServerCertificateCommonName**

> The common name of the server certificate. The system uses this name
> to validate the certificate sent by the IKE server. If not set, the
> system uses the remote identifier to validate the certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.ServerCertificateIssuerCommonName**

> Common Name of the server certificate issuer. If set, this field
> causes IKE to send a certificate request based on this certificate
> issuer to the server. This key is required if the 'CertificateType'
> key is included and the 'ExtendedAuthEnabled' key is '1'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.SharedSecret**

> If 'AuthenticationMethod' is 'SharedSecret', this value is used for
> IKE authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.TLSMaximumVersion**

> The maximum TLS version to use with EAP-TLS authentication.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or one of "1.0", "1.1", "1.2"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.TLSMinimumVersion**

> The minimum TLS version to use with EAP-TLS authentication.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or one of "1.0", "1.1", "1.2"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IKEv2.UseConfigurationAttributeInternalIPSubnet**

> If '1', negotiations should use IKEv2 Configuration Attribute
> 'INTERNAL_IP4_SUBNET' and 'INTERNAL_IP6_SUBNET'.
>
> Requires: iOS \>= 9.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec**

> The dictionary that contains IPSec settings. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.AuthenticationMethod**

> The authentication method for L2TP and Cisco IPSec.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "SharedSecret", "Certificate"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.DisconnectOnIdle**

> If '1', disconnect after an on-demand connection idles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.DisconnectOnIdleTimer**

> The length of time to wait before disconnecting an on-demand
> connection.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.LocalIdentifier**

> The name of the group. For hybrid authentication, the string needs to
> end with "hybrid".
>
> Present only for Cisco IPSec if 'AuthenticationMethod' is
> 'SharedSecret'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.LocalIdentifierType**

> Present only if 'AuthenticationMethod' is 'SharedSecret'. The value is
> 'KeyID'. The system uses this value for L2TP and Cisco IPSec VPNs.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or value "KeyID" (singular enum)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandEnabled**

> If '1', enables bringing the VPN connection up on demand.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandMatchDomainsAlways**

> Deprecated. A list of domain names. In iOS 7 and later, if this key is
> present, the system treats associated domain names as though they're
> associated with the 'OnDemandMatchDomainsOnRetry' key. This behavior
> can be overridden by 'OnDemandRules'.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandMatchDomainsNever**

> Deprecated. A list of domain names. In iOS 7 and later, this key is
> deprecated (but still supported) in favor of 'EvaluateConnection'
> actions in the 'OnDemandRules' dictionaries.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandMatchDomainsOnRetry**

> Deprecated. A list of domain names. In iOS 7 and later, this field is
> deprecated (but still supported) in favor of 'EvaluateConnection'
> actions in the 'OnDemandRules' dictionaries.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules**

> The on-demand rules dictionary.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.Action**

> The action to take if this dictionary matches the current network.
> Possible values are:
>
> > **•** 'Allow': Deprecated. Allow VPN On Demand to connect if
> > triggered.
>
> > **•** 'Connect': Unconditionally initiate a VPN connection on the
> > next network attempt.
>
> > **•** 'Disconnect': Tear down the VPN connection and don't reconnect
> > on demand as long as this dictionary matches.
>
> > **•** 'EvaluateConnection': Evaluate the ActionParameters array for
> > each connection attempt.
>
> > **•** 'Ignore': Leave any existing VPN connection up, but don't
> > reconnect on demand as long as this dictionary matches. Only the
> > 'Disconnect' action is available on watchOS 10 and later.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "Allow", "Connect", "Disconnect", "EvaluateConnection",
> "Ignore"

**profiles.vpn.managed.IPSec.OnDemandRules.\*.ActionParameters**

> An array of dictionaries that provides rules similar to the
> 'OnDemandRules' dictionary, but evaluated on each connection instead
> of when the network changes. This value is only for use with
> dictionaries in which the 'Action' value is 'EvaluateConnection'. The
> system evaluates these dictionaries in order and the first dictionary
> that matches determines the behavior. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.ActionParameters.\*.DomainAction**

> Defines the VPN behavior for the specified domains. Allowed values
> are:
>
> > **•** 'ConnectIfNeeded': The specified domains should trigger a VPN
> > connection attempt if domain name resolution fails, such as when the
> > DNS server indicates that it can't resolve the domain, responds with
> > a redirection to a different server, or fails to respond (timeout).
>
> > **•** 'NeverConnect': The specified domains should never trigger a
> > VPN connection attempt.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "ConnectIfNeeded", "NeverConnect"

**profiles.vpn.managed.IPSec.OnDemandRules.\*.ActionParameters.\*.Domains**

> The domains to apply this evaluation.
>
> Requires: iOS \>= 4.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.vpn.managed.IPSec.OnDemandRules.\*.ActionParameters.\*.RequiredDNSServers**

> An array of IP addresses of DNS servers to use for resolving the
> specified domains. These servers don't need to be part of the device's
> current network configuration. If these DNS servers aren't reachable,
> the system establishes a VPN connection. These DNS servers need to be
> either internal DNS servers or trusted external DNS servers. This key
> is valid only if the value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.ActionParameters.\*.RequiredURLStringProbe**

> An HTTP or HTTPS (preferred) URL to probe, using a GET request. If the
> URL's hostname can't be resolved, if the server is unreachable, or if
> the server doesn't respond with a 200 HTTP status code, a VPN
> connection is established in response. This key is valid only if the
> value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.DNSDomainMatch**

> An array of domain names. This rule matches if any of the domain names
> in the specified list matches any domain in the device's search
> domains list. The system supports a wildcard ('\*') prefix. For
> example, '\*.example.com' matches against either
> 'mydomain.example.com' or 'yourdomain.example.com'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.DNSServerAddressMatch**

> An array of IP addresses. This rule matches if any of the network's
> specified DNS servers match any entry in the array. The system
> supports matching with a single wildcard. For example, '17.\*' matches
> any DNS server in the '17.0.0.0/8' subnet.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.InterfaceTypeMatch**

> An interface type. If specified, this rule matches only if the primary
> network interface hardware matches the specified type.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "Ethernet", "WiFi", "Cellular"
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.SSIDMatch**

> An array of SSIDs to match against the current network. If the network
> isn't a Wi-Fi network or if the SSID doesn't appear in this array, the
> match fails. Omit this key and the corresponding array to match
> against any SSID.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.OnDemandRules.\*.URLStringProbe**

> A URL to probe. This rule matches when this URL is successfully
> fetched (returns a '200' HTTP status code) without redirection. Not
> available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile to use for
> the account credentials.
>
> Only use this with Cisco IPSec VPNs and if the 'AuthenticationMethod'
> key is to 'Certificate'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.PromptForVPNPIN**

> If 'true', prompts for a PIN when connecting to Cisco IPSec VPNs.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.RemoteAddress**

> The IP address or host name of the VPN server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.SharedSecret**

> The shared secret for this VPN account.
>
> Only use this with L2TP and Cisco IPSec VPNs and if the
> 'AuthenticationMethod' key is to 'SharedSecret'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.XAuthEnabled**

> If '1', enables Xauth for Cisco IPSec VPNs.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.XAuthName**

> The user name for the VPN account for Cisco IPSec.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.XAuthPassword**

> The VPN account password for Cisco IPSec.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPSec.XAuthPasswordEncryption**

> A string that either has the value "Prompt" or isn't present.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or value "Prompt" (singular enum)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPv4**

> The dictionary that contains IPv4 settings. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.IPv4.OverridePrimary**

> If '1', the system sends all network traffic over VPN. Only applies to
> Cisco IPsec and L2TP VPN types.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP**

> The dictionary to use when 'VPNType' is 'L2TP' or 'PTPP'. Not
> available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.AuthEAPPlugins**

> An array of authentication plugins. For use of RSA SecurID, this array
> should only have one value: 'EAP-RSA'. This key is for use with L2TP
> and PPTP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (one of "EAP-RSA", "EAP-TLS", "EAP-KRB"))
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.AuthName**

> The VPN account user name. This key is for use with L2TP and PPTP
> networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.AuthPassword**

> If 'TokenCard' is '1', use this password for authentication. This key
> is for use with L2TP and PPTP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.AuthProtocol**

> An array of authentication protocols. For use of RSA SecurID, this
> array should have one value, 'EAP'. This key is for use with L2TP and
> PPTP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of value "EAP" (singular enum))
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.CCPEnabled**

> If '1', enables encryption on the connection. This key is for use with
> PPTP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.CCPMPPE128Enabled**

> If '1' and 'CCPEnabled' is also '1', enables CCPMPPE40 encryption.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.CCPMPPE40Enabled**

> If '1' and 'CCPEnabled' is also '1', enables CCPMPPE128 encryption.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.CommRemoteAddress**

> The IP address or host name of VPN server. This key is for use with
> L2TP and PPTP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.DisconnectOnIdle**

> If '1', disconnects after an on demand connection idles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.DisconnectOnIdleTimer**

> The length of time to wait before disconnecting an on demand
> connection
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.vpn.managed.PPP.TokenCard**

> If '1', uses a token card such as an RSA SecurID card for connecting.
> This key is for use with L2TP networks.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.vpn.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.vpn.managed"

**profiles.vpn.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.vpn.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.vpn.managed.Proxies**

> The dictionary to use to configure 'Proxies' for use with 'VPN'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPEnable**

> If '1', enables proxy for HTTP traffic.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPPort**

> The port number of the HTTP proxy. This field is required if
> 'HTTPProxy' is specified.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 65535 (both inclusive)
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPProxy**

> The host name of the HTTP proxy.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPProxyPassword**

> The password used for authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPProxyUsername**

> The user name used for authentication.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPSEnable**

> If 'true', enables proxy for HTTPS traffic.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPSPort**

> The port number of the HTTPS proxy. This field is required if
> 'HTTPSProxy' is specified.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 65535 (both inclusive)
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.HTTPSProxy**

> The host name of the HTTPS proxy.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.ProxyAutoConfigEnable**

> If 'true', enables automatic proxy configuration.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.ProxyAutoConfigURLString**

> The URL to the location of the proxy auto-configuration file. Used
> only when 'ProxyAutoConfigEnable' is 'true'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.ProxyAutoDiscoveryEnable**

> If 'true', enables proxy auto discovery.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.Proxies.SupplementalMatchDomains**

> An array of domains that defines which hosts use proxy settings for
> hosts.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.UserDefinedName**

> The description of the VPN connection that the system displays on the
> device. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.vpn.managed.VPN**

> The dictionary to use when 'VPNType' is 'VPN'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.AuthName**

> The VPN account username.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.AuthPassword**

> The VPN account password. Only use this if 'AuthenticationMethod' is
> set to 'Password'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.AuthenticationMethod**

> The authentication method to use.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "Password", "Certificate",
> "Password+Certificate"
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.DisconnectOnIdle**

> If '1', disconnects after an on-demand connection idles.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.DisconnectOnIdleTimer**

> The length of time to wait, in seconds, before disconnecting an
> on-demand connection. In watchOS, the maximum allowed value is '15'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.EnforceRoutes**

> If '1', all the VPN's non-default routes take precedence over any
> locally defined routes.
>
> If 'IncludeAllNetworks' is '1', the system ignores the value of
> 'EnforceRoutes'.
>
> Available in iOS 14.2 and later, and macOS 11 and later. Not available
> in watchOS.
>
> Requires: iOS \>= 14.2
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ExcludeAPNs**

> If '1' and 'IncludeAllNetworks' is '1', then the system excludes the
> network traffic for the Apple Push Notification service (APNs) from
> the tunnel. Not available in watchOS.
>
> Requires: iOS \>= 16.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ExcludeCellularServices**

> If '1' and 'IncludeAllNetworks' is '1', then the system excludes
> internet-routable network traffic for cellular services (VoLTE, Wi-Fi
> Calling, IMS, MMS, Visual Voicemail, etc.) from the tunnel. Note that
> some cellular carriers route cellular services traffic directly to the
> carrier network, bypassing the internet. Such cellular services
> traffic is always excluded from the tunnel. Not available in watchOS.
>
> Requires: iOS \>= 16.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ExcludeDeviceCommunication**

> If set to '1' and 'IncludeAllNetworks' is set to '1', the device
> excludes network traffic used for communicating with devices connected
> via USB or Wi-Fi from the tunnel.
>
> Requires: iOS \>= 17.4
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ExcludeLocalNetworks**

> If '1' and 'IncludeAllNetworks' is '1', routes all local network
> traffic outside the VPN. Not available in watchOS.
>
> Requires: iOS \>= 14.2
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.IncludeAllNetworks**

> If '1\`\`, routes all traffic through the VPN, with some exclusions.
> Several of the exclusions can be controlled with the
> 'ExcludeLocalNetworks', 'ExcludeCellularServices',
> 'ExcludeAPNs'and'ExcludeDeviceCommunication\` properties. The
> following traffic is always excluded from the tunnel:
>
> > **•** Traffic necessary for connecting and maintaining the device's
> > network connection, such as DHCP.
>
> > **•** Traffic necessary for connecting to captive networks.
>
> > **•** Certain cellular services traffic that is not routable over
> > the internet and is instead directly routed to the cellular network.
> > See the ExcludeCellularServices property for more details.
>
> > **•** Network communication with a companion device such as a
> > watchOS device.
>
> Not available in watchOS.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandEnabled**

> If '1', enables VPN On Demand.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandMatchDomainsAlways**

> A list of domain names. The system treats associated domain names as
> though they're associated with the 'OnDemandMatchDomainsOnRetry' key.
> This behavior can be overridden by 'OnDemandRules'.
>
> In iOS 7 and later, this key is deprecated (but still supported) in
> favor of 'EvaluateConnection' actions in the 'OnDemandRules'
> dictionaries.
>
> Not available in watchOS.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandMatchDomainsNever**

> A list of domain names. If the host name ends with one of these domain
> names, the system doesn't start the VPN automatically. The system uses
> this value to exclude a subdomain within an included domain.
>
> In iOS 7 and later, this key is deprecated (but still supported) in
> favor of 'EvaluateConnection' actions in the 'OnDemandRules'
> dictionaries.
>
> Not available in watchOS.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandMatchDomainsOnRetry**

> A list of domain names. If the host name ends with one of these domain
> names and a DNS query for that domain name fails, the system starts
> the VPN automatically.
>
> In iOS 7 and later, this key is deprecated (but still supported) in
> favor of 'EvaluateConnection' actions in the 'OnDemandRules'
> dictionaries.
>
> Not available in watchOS.
>
> Requires: iOS \>= 4.0\
> Deprecated in iOS 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules**

> An array of dictionaries defining On Demand Rules.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.Action**

> The action to take if this dictionary matches the current network.
> Possible values are:
>
> > **•** 'Allow': Deprecated. Allow VPN On Demand to connect if
> > triggered.
>
> > **•** 'Connect': Unconditionally initiate a VPN connection on the
> > next network attempt.
>
> > **•** 'Disconnect': Tear down the VPN connection and don't reconnect
> > on demand as long as this dictionary matches.
>
> > **•** 'EvaluateConnection': Evaluate the ActionParameters array for
> > each connection attempt.
>
> > **•** 'Ignore': Leave any existing VPN connection up, but don't
> > reconnect on demand as long as this dictionary matches. Only the
> > 'Disconnect' action is available on watchOS 10 and later.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "Allow", "Connect", "Disconnect", "EvaluateConnection",
> "Ignore"

**profiles.vpn.managed.VPN.OnDemandRules.\*.ActionParameters**

> An array of dictionaries that provides rules similar to the
> 'OnDemandRules' dictionary, but evaluated on each connection instead
> of when the network changes. This value is only for use with
> dictionaries in which the 'Action' value is 'EvaluateConnection'. The
> system evaluates these dictionaries in order and the first dictionary
> that matches determines the behavior. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.ActionParameters.\*.DomainAction**

> Defines the VPN behavior for the specified domains. Allowed values
> are:
>
> > **•** 'ConnectIfNeeded': The specified domains should trigger a VPN
> > connection attempt if domain name resolution fails, such as when the
> > DNS server indicates that it can't resolve the domain, responds with
> > a redirection to a different server, or fails to respond (timeout).
>
> > **•** 'NeverConnect': The specified domains should never trigger a
> > VPN connection attempt.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "ConnectIfNeeded", "NeverConnect"

**profiles.vpn.managed.VPN.OnDemandRules.\*.ActionParameters.\*.Domains**

> The domains to apply this evaluation.
>
> Requires: iOS \>= 4.0
>
> *Type:* list of string
>
> *Default:*
>
> > [ ]

**profiles.vpn.managed.VPN.OnDemandRules.\*.ActionParameters.\*.RequiredDNSServers**

> An array of IP addresses of DNS servers to use for resolving the
> specified domains. These servers don't need to be part of the device's
> current network configuration. If these DNS servers aren't reachable,
> the system establishes a VPN connection. These DNS servers need to be
> either internal DNS servers or trusted external DNS servers. This key
> is valid only if the value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.ActionParameters.\*.RequiredURLStringProbe**

> An HTTP or HTTPS (preferred) URL to probe, using a GET request. If the
> URL's hostname can't be resolved, if the server is unreachable, or if
> the server doesn't respond with a 200 HTTP status code, a VPN
> connection is established in response. This key is valid only if the
> value of 'DomainAction' is 'ConnectIfNeeded'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.DNSDomainMatch**

> An array of domain names. This rule matches if any of the domain names
> in the specified list matches any domain in the device's search
> domains list. The system supports a wildcard ('\*') prefix. For
> example, '\*.example.com' matches against either
> 'mydomain.example.com' or 'yourdomain.example.com'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.DNSServerAddressMatch**

> An array of IP addresses. This rule matches if any of the network's
> specified DNS servers match any entry in the array. The system
> supports matching with a single wildcard. For example, '17.\*' matches
> any DNS server in the '17.0.0.0/8' subnet.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.InterfaceTypeMatch**

> An interface type. If specified, this rule matches only if the primary
> network interface hardware matches the specified type.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "Ethernet", "WiFi", "Cellular"
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.SSIDMatch**

> An array of SSIDs to match against the current network. If the network
> isn't a Wi-Fi network or if the SSID doesn't appear in this array, the
> match fails. Omit this key and the corresponding array to match
> against any SSID.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandRules.\*.URLStringProbe**

> A URL to probe. This rule matches when this URL is successfully
> fetched (returns a '200' HTTP status code) without redirection. Not
> available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.OnDemandUserOverrideDisabled**

> If '1', the Connect On Demand toggle in Settings is disabled for this
> configuration. Available in iOS 14 and later. Not available in
> watchOS.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or one of 0, 1
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile to use for
> account credentials.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ProviderBundleIdentifier**

> The bundle identifier for the VPN provider. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.ProviderType**

> The type of VPN service. If the value is 'app-proxy', the service
> tunnels traffic at the app level. If the value is 'packet-tunnel', the
> service tunnels traffic at the IP layer. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "packet-tunnel", "app-proxy"
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPN.RemoteAddress**

> The IP address or hostname of the VPN server.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.vpn.managed.VPNSubType**

> An identifier for a vendor-specified configuration dictionary when the
> value for 'VPNType' is 'VPN'.
>
> If 'VPNType' is 'VPN', the system requires this field. If the
> configuration targets a VPN solution that uses a VPN plugin, then this
> field contains the bundle identifier of the plugin. Here are some
> examples:
>
> > **•** Cisco AnyConnect: 'com.cisco.anyconnect.applevpn.plugin'
>
> > **•** Juniper SSL: 'net.juniper.sslvpn'
>
> > **•** F5 SSL: 'com.f5.F5-Edge-Client.vpnplugin'
>
> > **•** SonicWALL Mobile Connect: 'com.sonicwall.SonicWALL-
> > SSLVPN.vpnplugin'
>
> > **•** \`\`Aruba VIA: 'com.arubanetworks.aruba-via.vpnplugin'
>
> If the configuration targets a VPN solution that uses a network
> extension provider, then this field contains the bundle identifier of
> the app that contains the provider. Contact the VPN solution vendor
> for the value of the identifier.
>
> If 'VPNType' is 'IKEv2', then the 'VPNSubType' field is optional and
> reserved for future use. If it's specified, it needs to contain an
> empty string.
>
> Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VPNType**

> The type of the VPN, which defines which settings are appropriate for
> this VPN payload.
>
> If the type is 'VPN' or 'TransparentProxy', then the system requires a
> value for 'VPNSubType'.
>
> 'TransparentProxy' is only available in macOS. 'L2TP' and 'IPSec'
> aren't available in tvOS. 'AlwaysOn' is only available on iOS and
> Apple Watch pairing isn't supported with 'AlwaysOn'. For a previously
> paired Apple Watch, all phone-watch communications cease when
> 'AlwaysOn' is enabled. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* one of "VPN", "L2TP", "IPSec", "IKEv2", "AlwaysOn",
> "TransparentProxy"

**profiles.vpn.managed.VendorConfig**

> The vendor-specific configuration dictionary, which the system reads
> only when 'VPNSubType' has a value. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.vpn.managed.VendorConfig.Group**

> The group to connect to on the head end. Valid for Cisco AnyConnect
> and Cisco Legacy AnyConnect. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VendorConfig.LoginGroupOrDomain**

> The login group or domain. Valid only for SonicWALL Mobile Connect.
> Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VendorConfig.Realm**

> The Kerberos realm name, which needs to be properly capitalized. Valid
> only for Juniper SSL and Pulse Secure. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed.VendorConfig.Role**

> The role to select when connecting to the server. Valid only for
> Juniper SSL and Pulse Secure. Not available in watchOS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer**

> The payload that configures a per-app VPN.
>
> The fields in this payload are the same as the VPN payload, with the
> addition of the fields shown below. On watchOS, only the IKEv2 VPN
> type is supported.
>
> This profile defines per-app VPN behavior and applies only to VPN
> services of type 'VPN', 'IPsec', and 'IKEv2'. All the properties of
> VPN apply to the top level of this profile as well.
>
> *Type:* submodule

**profiles.vpn.managed-applayer.enable**

> Whether to enable Enable the com.apple.vpn.managed.applayer profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.vpn.managed-applayer.AssociatedDomains**

> An array with entries that must each specify a domain that triggers
> this VPN. The domains must also be part of the
> 'apple-app-site-association' file, as described in 'Supporting
> associated domains'.
>
> Available in iOS 14 and later, and macOS 11 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.CalendarDomains**

> An array with entries that must each specify a domain that triggers
> this VPN connection in Calendar. Each entry is in the format
> 'www.apple.com'.
>
> This property is deprecated in iOS 13.4 and later; use the 'VPNUUID'
> property of the 'CalDAV' payload instead.
>
> Requires: iOS \>= 13.0\
> Deprecated in iOS 13.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.CellularSliceUUID**

> A string representing the data network name (DNN) or app category
> identifying a Cellular Slice. The device forces the VPN tunnel to use
> the specified Cellular Slice.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.ContactsDomains**

> An array with entries that must each specify a domain that triggers
> this VPN connection in Contacts. Each entry is in the format
> 'www.apple.com'.
>
> This property is deprecated in iOS 13.4 and later; use the 'VPNUUID'
> property of the 'CardDAV' payload instead.
>
> Requires: iOS \>= 13.0\
> Deprecated in iOS 13.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.ExcludedDomains**

> An array with entries that each specify a domain that doesn't trigger
> this VPN for connections to the domain.
>
> Available in iOS 14 and later, and macOS 11 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.MailDomains**

> An array with entries that must each specify a domain that triggers
> this VPN connection in Mail. Each entry is in the format
> 'www.apple.com'.
>
> This property is deprecated in iOS 13.4 and later; use the 'VPNUUID'
> property of the 'Mail' or 'ExchangeActiveSync' payload instead.
>
> Requires: iOS \>= 13.0\
> Deprecated in iOS 13.4
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.OnDemandMatchAppEnabled**

> If 'true', automatically connects the VPN when associated apps for
> this per-app VPN service initiate network communication. Otherwise,
> the user must initiate the connection manually before those apps can
> initiate network communication. If this key isn't present, the value
> of the 'OnDemandEnabled' key determines the status of per-app VPN On
> Demand.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.vpn.managed-applayer.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.vpn.managed.applayer"

**profiles.vpn.managed-applayer.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.vpn.managed-applayer.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.vpn.managed-applayer.SMBDomains**

> An array of SMB domains that's accessible through this VPN connection.
>
> Available in iOS 13 and later.
>
> Requires: iOS \>= 13.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.SafariDomains**

> An array with entries that must each specify a domain that triggers
> the VPN connection in Safari. Each entry is in the format
> 'www.apple.com'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.vpn.managed-applayer.VPNUUID**

> A globally unique identifier for this VPN configuration.
>
> Requires: iOS \>= 7.0
>
> *Type:* string

**profiles.webClip.managed**

> The profile that configures web clips on the device.
>
> Use this payload to add web clips to the Home Screen of the user's iOS
> device or to the Dock on a Mac. Web clips provide fast access to
> favorite webpages.
>
> For iOS devices, if you prevent the user from removing the web clip,
> the only way to remove it is to remove the configuration profile that
> installed it. Also, for iOS devices it must have a display name and an
> icon URL for the payload to be valid.
>
> A full-screen web clip on iOS devices opens the URL as a web app
> without a browser; there's no URL, search bar, or bookmarks.
>
> For Shared iPad devices, the system supports this payload on the user
> channel only.
>
> *Type:* submodule

**profiles.webClip.managed.enable**

> Whether to enable Enable the com.apple.webClip.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.webClip.managed.FullScreen**

> If 'true', the system launches the web clip as a full-screen web app.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webClip.managed.Icon**

> The PNG icon to show on the Home Screen. If not set, the system
> displays a white square. For best results, provide a square image
> that's no larger than 400 x 400 pixels and less than 1 MB when
> uncompressed. The graphics file is automatically scaled and cropped to
> fit, if necessary, and converted to PNG format. Web clip icons are 144
> x 144 pixels for iPad devices with a Retina display, and 114 x 114
> pixels for iPhone devices. To prevent the device from adding a shine
> to the image, set 'Precomposed' to 'true'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or Written as string or path, read as { \_\_type =
> "data", value = \... }
>
> *Default:*
>
> > null

**profiles.webClip.managed.IgnoreManifestScope**

> If 'true', a full screen web clip can navigate to an external web site
> without showing Safari UI. Otherwise, Safari UI appears when
> navigating away from the web clip's URL. This key has no effect when
> 'FullScreen' is 'false'. Available in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webClip.managed.IsRemovable**

> If 'true', the system enables removing the web clip.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webClip.managed.Label**

> The name of the web clip that the system displays on the Home Screen.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.webClip.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.webClip.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.webClip.managed"

**profiles.webClip.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.webClip.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.webClip.managed.Precomposed**

> If 'true', the system prevents SpringBoard from adding shine to the
> icon.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webClip.managed.TargetApplicationBundleIdentifier**

> The application bundle identifier of the application that opens the
> URL. To use this property, install the profile through MDM. Available
> in iOS 14 and later.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webClip.managed.URL**

> The URL of the web clip.
>
> Requires: iOS \>= 4.0
>
> *Type:* string

**profiles.webcontent-filter**

> The payload that configures web content filters.
>
> As of iOS 16.0 and visionOS 1.1, this can be installed on unsupervised
> devices and user enrollments if ContentFilterUUID is specified.
> Previously it could only be installed on supervised devices.
>
> The system matches URLs using string-based matching. A URL matches an
> allow list, deny list, or permitted list pattern if the exact
> characters of the pattern appear as a substring of the URL requested
> in the web browser. For example, if the system doesn't allow
> 'test.com/a', it blocks 'test.com/a', 'test.com/apple', and
> 'test.com/a/b'.
>
> The system matches list entries that terminate with a '/' character
> explicitly; if the system blocks or allows 'test.com/a/', it blocks or
> allows 'test.com/a' and 'test.com/a/b'.
>
> Matching discards a 'www' subdomain prefix if present, so if the
> system doesn't allow 'www.test.com', it also blocks 'm.test.com'.
>
> All filtering options are active simultaneously. The system only
> permits URLs and sites that pass all rules.
>
> *Type:* submodule

**profiles.webcontent-filter.enable**

> Whether to enable Enable the com.apple.webcontent-filter profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.webcontent-filter.AllowListBookmarks**

> An array of dictionaries that define the pages that the user can
> bookmark or visit. Use when 'FilterType' is 'BuiltIn'.
>
> Requires: iOS \>= 14.5
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.webcontent-filter.AllowListBookmarks.\*.Title**

> The title of the bookmark.
>
> Requires: iOS \>= 14.5
>
> *Type:* string

**profiles.webcontent-filter.AllowListBookmarks.\*.URL**

> The URL of the bookmark in the allow list.
>
> Requires: iOS \>= 14.5
>
> *Type:* string

**profiles.webcontent-filter.AutoFilterEnabled**

> If 'true', the system enables automatic filtering. Use when
> 'FilterType' is 'BuiltIn'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.BlacklistedURLs**

> Use 'DenyListURLs' instead.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 14.5
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.webcontent-filter.ContentFilterUUID**

> A globally unique identifier for this content filter configuration.
> The content filter processes network traffic for managed apps with the
> same 'ContentFilterUUID' in their app attributes. Use when
> 'FilterType' is 'Plugin'.This key must be present for unsupervised
> devices and user enrollment.
>
> Requires: iOS \>= 16.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.DenyListURLs**

> An array of URLs that are inaccessible. Use when 'FilterType' is
> 'BuiltIn'. Limit the number of these URLs to no more than 500.
>
> Requires: iOS \>= 14.5
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.webcontent-filter.FilterBrowsers**

> If 'true', the system enables filtering WebKit traffic. Use when
> 'FilterType' is 'Plugin'.
>
> > *""* Note: At least one of 'FilterBrowsers' or 'FilterSockets' needs
> > to be 'true'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.FilterSockets**

> If 'true', enables the filtering of socket traffic. Use when
> 'FilterType' is 'Plugin'.
>
> > *""* Note: At least one of 'FilterBrowsers' or 'FilterSockets' needs
> > to be 'true'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.FilterType**

> The type of filter, built-in or plug-in. In macOS, the system only
> supports the plug-in value.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or one of "BuiltIn", "Plugin"
>
> *Default:*
>
> > null

**profiles.webcontent-filter.FilterURLs**

> If 'true', the system filters URL requests. Use when 'FilterType' is
> 'Plugin'. Available in iOS 26 and macOS 26, and later.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.HideDenyListURLs**

> If 'true', the device hides the 'DenyListURLs' item in the profiles
> that display in Settings \> General \> VPN & Device Management.
>
> Requires: iOS \>= 18.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.Organization**

> The organization string to pass to the third-party plug-in. Use when
> 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.Password**

> The password for the service. Use when 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile that the
> system uses to authenticate the user. Use when 'FilterType' is
> 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.webcontent-filter.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.webcontent-filter.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.webcontent-filter"

**profiles.webcontent-filter.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.webcontent-filter.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.webcontent-filter.PermittedURLs**

> An array or URLs that are accessible whether or not the automatic
> filter allows access. Use when 'FilterType' is 'BuiltIn'. Requires
> that 'AutoFilterEnabled' is 'true'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.webcontent-filter.PluginBundleID**

> The bundle ID of the plug-in that provides filtering service. Required
> when 'FilterType' is 'Plugin'. Otherwise, it ignores this value.
> Consult your filtering solution vendor to determine what to specify
> for this value. Required when 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.SafariHistoryRetentionEnabled**

> If 'true', this payload enforces a policy which requires retention of
> browsing history. This causes Safari to disable clearing of browsing
> history, and prevents the use of private browsing mode because that
> mode doesn't keep browsing history.
>
> Requires: iOS \>= 26.0; supervised device
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.ServerAddress**

> The server address, which may be the IP address, hostname, or URL. Use
> when 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.URLFilterParameters**

> A dictionary containing URL filter parameters. Required when
> 'FilterURLs' is 'true'. Available in iOS 26 and macOS 26 and later.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.webcontent-filter.URLFilterParameters.PIRAuthenticationToken**

> The per-user authentication token string, which is an HTTP bearer
> token for the person using your app. The system uses this token to
> attest that it is a valid user when requesting anonymous
> authentication tokens for PIR exchanges.
>
> Requires: iOS \>= 26.0
>
> *Type:* string

**profiles.webcontent-filter.URLFilterParameters.PIRPrivacyPassIssuerURL**

> The URL containing the domain name of Privacy Pass Issuer.
>
> Requires: iOS \>= 26.0
>
> *Type:* string

**profiles.webcontent-filter.URLFilterParameters.PIRServerURL**

> The URL containing the domain name of the private information
> retrieval server.
>
> Requires: iOS \>= 26.0
>
> *Type:* string

**profiles.webcontent-filter.URLFilterParameters.URLFilterControlProviderBundleIdentifier**

> The bundle identifier string of the URL filter control provider app
> extension. The system uses this string to identify the URL filter
> control provider when the filter starts running.
>
> Requires: iOS \>= 26.0
>
> *Type:* string

**profiles.webcontent-filter.URLFilterParameters.URLFilterControlProviderDesignatedRequirement**

> The designated requirement string in the code signature of the URL
> filter control provider app extension. The system uses this string to
> identify the URL filter control provider when the filter starts
> running. Required in macOS.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.URLFilterParameters.URLFilterFailClosed**

> If 'true', the system blocks URLs if the filter is enabled, but it
> fails to make any filtering decision; for example, if there's a
> communication failure with the PIR server. If 'false', the system
> allows URLs if the filter is enabled, but it fails to make any
> filtering decision.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.webcontent-filter.URLFilterParameters.URLPrefilterFetchFrequency**

> The time interval in seconds that the system uses to periodically run
> the 'NEURLFilterControlProvider' app extension. The default value is
> 86400 seconds (1 day). The minimum allowed value is 2700 seconds (45
> minutes). The system allows 'NEURLFilterControlProvider'
> implementations to download prefilter Bloom filter data onto the
> device periodically at the specified interval. Implementations need to
> allow for a slight difference between the scheduled time and the
> actual runtime of the task, due to the scheduling mechanism on the
> system.
>
> Requires: iOS \>= 26.0
>
> *Type:* null or signed integer
>
> *Default:*
>
> > null

**profiles.webcontent-filter.UserDefinedName**

> The display name for this filtering configuration. Required when
> 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.UserName**

> The user name for the service. Use when 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.webcontent-filter.VendorConfig**

> The custom dictionary that the filtering service plug-in needs. Use
> when 'FilterType' is 'Plugin'.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (attribute set of anything)
>
> *Default:*
>
> > null

**profiles.webcontent-filter.WhitelistedBookmarks**

> Use 'AllowListBookmarks' instead.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 14.5
>
> *Type:* null or (list of (submodule))
>
> *Default:*
>
> > null

**profiles.webcontent-filter.WhitelistedBookmarks.\*.Title**

> The title of the bookmark.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 14.5
>
> *Type:* string

**profiles.webcontent-filter.WhitelistedBookmarks.\*.URL**

> The URL of the bookmark in the allow list.
>
> Requires: iOS \>= 7.0\
> Deprecated in iOS 14.5
>
> *Type:* string

**profiles.wifi.managed**

> The payload that configures Wi-Fi settings.
>
> *Type:* submodule

**profiles.wifi.managed.enable**

> Whether to enable Enable the com.apple.wifi.managed profile.
>
> *Type:* boolean
>
> *Default:*
>
> > false
>
> *Example:*
>
> > true

**profiles.wifi.managed.AutoJoin**

> If 'true', the device joins the network automatically.
>
> If 'false', the user must tap the network name to join it.
>
> Requires: iOS \>= 5.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.CaptiveBypass**

> If 'true', the system bypasses Captive Network detection when the
> device connects to the network.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.DisableAssociationMACRandomization**

> If 'true,' disables MAC address randomization for a Wi-Fi network
> while associated with that network. This feature also shows a privacy
> warning in Settings indicating that the network has reduced privacy
> protections.
>
> If 'false', then the system enables MAC address randomization on iOS,
> watchOS, and visionOS.
>
> This value is only locked when MDM installs the profile. If the
> profile is manually installed, the system sets the value but the user
> can change it.
>
> Requires: iOS \>= 14.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.DisplayedOperatorName**

> The operator name to display when connected to this network. Used only
> with Wi-Fi Hotspot 2.0 access points.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.DomainName**

> The primary domain of the tunnel.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration**

> The enterprise network configuration.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.AcceptEAPTypes**

> The EAP types that the system accepts. Allowed values:
>
> > **•** '13': EAP-TLS
>
> > **•** '17': LEAP
>
> > **•** '18': EAP-SIM
>
> > **•** '21': EAP-TTLS
>
> > **•** '23': EAP-AKA
>
> > **•** '25': PEAPv0/v1
>
> > **•** '43': EAP-FAST
>
> For EAP-TLS authentication without a network payload, install the
> necessary identity certificates and have your users select EAP-TLS
> mode in the 802.1X credentials dialog that appears when they connect
> to the network. For other EAP types, a network payload is necessary
> and must specify the correct settings for the network.
>
> Requires: iOS \>= 4.0
>
> *Type:* list of (one of 13, 17, 18, 21, 23, 25, 43)
>
> *Default:*
>
> > [ ]

**profiles.wifi.managed.EAPClientConfiguration.EAPFASTProvisionPAC**

> If 'true', allows PAC provisioning.
>
> This value is only applicable if 'EAPFASTUsePAC' is 'true'. This value
> must be 'true' for EAP-FAST PAC usage to succeed because there's no
> other way to provision a PAC.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.EAPFASTProvisionPACAnonymously**

> If 'true', provisions the device anonymously. Note that there are
> known machine-in-the-middle attacks for anonymous provisioning.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.EAPFASTUsePAC**

> If 'true', the device uses an existing PAC if it's present. Otherwise,
> the server must present its identity using a certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.EAPSIMNumberOfRANDs**

> The minimum number of RAND values to accept from the server. For use
> with EAP-SIM only.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or one of 2, 3
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.OneTimeUserPassword**

> If 'true', the user receives a prompt for a password each time they
> connect to the network.
>
> Requires: iOS \>= 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.OuterIdentity**

> A name that hides the user's true name. The user's actual name appears
> only inside the encrypted tunnel. For example, you might set this to
> anonymous or anon, or anon@mycompany.net. It can increase security
> because an attacker can't see the authenticating user's name in the
> clear. This key is only relevant to TTLS, PEAP, and EAP-FAST. This
> field is required if 'TLSMinimumVersion' is '1.3'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.PayloadCertificateAnchorUUID**

> An array of the UUID of each certificate payload in the same profile
> to trust for authentication. Use this key to prevent the device from
> asking the user whether to trust the listed certificates. Dynamic
> trust (the certificate dialogue) is in a disabled state if you specify
> this property without also enabling 'TLSAllowTrustExceptions'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$)
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.SystemModeCredentialsSource**

> Set this string to 'ActiveDirectory' to use the AD computer name and
> password credentials. If using this property, you can't use
> 'SystemModeUseOpenDirectoryCredentials'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.SystemModeUseOpenDirectoryCredentials**

> If 'true', the system mode connection tries to use the Open Directory
> credentials. If using this property, you can't use
> 'SystemModeCredentialsSource'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSAllowTrustExceptions**

> If 'true', allows a dynamic trust decision by the user. The dynamic
> trust is the certificate dialogue that appears when the system doesn't
> trust a certificate. If 'false', the authentication fails if the
> system doesn't already trust the certificate. As of iOS 8, Apple no
> longer supports this key.
>
> Requires: iOS \>= 4.0 and \< 8.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSCertificateIsRequired**

> If 'true', allows for two-factor authentication for EAP- TTLS, PEAP,
> or EAP-FAST. If 'false', allows for zero-factor authentication for
> EAP-TLS. If you don't specify a value, the default is 'true' for EAP-
> TLS, and 'false' for other EAP types.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSMaximumVersion**

> The maximum TLS version for EAP authentication.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or one of "1.0", "1.1", "1.2", "1.3"
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSMinimumVersion**

> The minimum TLS version for EAP authentication.
>
> Requires: iOS \>= 11.0
>
> *Type:* null or one of "1.0", "1.1", "1.2", "1.3"
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSTrustedCertificates**

> An array of trusted certificates. Each entry in the array must contain
> certificate data that represents an anchor certificate used for
> verifying the server certificate.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TLSTrustedServerNames**

> The list of accepted server certificate common names. If a server
> presents a certificate that isn't in this list, the system doesn't
> trust it. If you specify this property, the system disables dynamic
> trust (the certificate dialog) unless you also specify
> 'TLSAllowTrustExceptions' with the value 'true'. If necessary, use
> wildcards to specify the name, such as 'wpa.\*.example.com'.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.TTLSInnerAuthentication**

> The inner authentication that the TTLS module uses.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "PAP", "EAP", "CHAP", "MSCHAP", "MSCHAPv2"
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.UserName**

> The user name for the account. If you don't specify a value, the
> system prompts the user during login.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.EAPClientConfiguration.UserPassword**

> The user's password. If you don't specify a value, the system prompts
> the user during login.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.EnableIPv6**

> If 'true', enables IPv6 on this interface.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.EncryptionType**

> The encryption type for the network.
>
> If set to anything except 'None', the payload may contain the
> following three keys: 'Password', 'PayloadCertificateUUID', or
> 'EAPClientConfiguration'.
>
> As of iOS 16, tvOS 16, watchOS 9, and macOS 13:
>
> > **•** 'WPA' allows joining WPA or WPA2 networks
>
> > **•** 'WPA2' allows joining WPA2 or WPA3 networks
>
> > **•** 'WPA3' allows joining WPA3 networks only
>
> > **•** 'Any' allows joining WPA, WPA2, WPA3, and WEP networks
>
> Prior to iOS 16, tvOS 16, and watchOS 9, specifying 'WPA', 'WPA2', and
> 'WPA3' were equivalent and would allow joining any WPA network.
>
> Prior to macOS 13, the encryption type, if specified explicitly,
> needed to match the encryption type of the network exactly.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "WEP", "WPA", "WPA2", "WPA3", "Any", "None"
>
> *Default:*
>
> > null

**profiles.wifi.managed.HESSID**

> The HESSID used for Wi-Fi Hotspot 2.0 negotiation.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.HIDDEN_NETWORK**

> If 'true', defines this network as hidden.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.IsHotspot**

> If 'true', the device treats the network as a hotspot.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.MCCAndMNCs**

> An array of Mobile Country Code/Mobile Network Code (MCC/MNC) pairs
> used for Wi-Fi Hotspot 2.0 negotiation. Each string must contain
> exactly six digits.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of string matching the pattern \^\[0-9\]{6}\$)
>
> *Default:*
>
> > null

**profiles.wifi.managed.NAIRealmNames**

> An array of Network Access Identifier Realm names used for Wi-Fi
> Hotspot 2.0 negotiation.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.wifi.managed.Password**

> The password for the access point.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.PayloadCertificateUUID**

> The UUID of the certificate payload within the same profile to use for
> the client credential.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string matching the pattern
> \^\[0-9A-Za-z\]{8}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{4}-\[0-9A-Za-z\]{12}\$
>
> *Default:*
>
> > null

**profiles.wifi.managed.PayloadIdentifier**

> The payload identifier for this profile
>
> *Type:* string

**profiles.wifi.managed.PayloadType**

> The payload type for this profile
>
> *Type:* string
>
> *Default:*
>
> > "com.apple.wifi.managed"

**profiles.wifi.managed.PayloadUUID**

> The payload UUID for this profile
>
> *Type:* string

**profiles.wifi.managed.PayloadVersion**

> The payload version for this profile
>
> *Type:* signed integer
>
> *Default:*
>
> > 1

**profiles.wifi.managed.ProxyPACFallbackAllowed**

> If 'true', allows connecting directly to the destination if the PAC
> file is unreachable.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyPACURL**

> The URL of the PAC file that defines the proxy configuration.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyPassword**

> The password used to authenticate to the proxy server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyServer**

> The proxy server's network address.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyServerPort**

> The proxy server's port number.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or integer between 0 and 65535 (both inclusive)
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyType**

> The proxy type, if any, to use. If you choose the manual proxy type,
> you need the proxy server address, including its port and optionally a
> user name and password into the proxy server. If you choose the auto
> proxy type, you can enter a proxy autoconfiguration (PAC) URL.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or one of "None", "Manual", "Auto"
>
> *Default:*
>
> > null

**profiles.wifi.managed.ProxyUsername**

> The user name used to authenticate to the proxy server.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.QoSMarkingPolicy**

> A dictionary that contains the list of apps that the system allows to
> benefit from L2 and L3 marking. When this dictionary isn't present,
> the system allows all apps to use L2 and L3 marking when the Wi-Fi
> network supports Cisco QoS fast lane.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or (submodule)
>
> *Default:*
>
> > null

**profiles.wifi.managed.QoSMarkingPolicy.QoSMarkingAllowListAppIdentifiers**

> An array of app bundle identifiers that defines the allow list for L2
> and L3 marking for traffic that goes to the Wi- Fi network. If the
> array isn't present, but the 'QoSMarkingPolicy' key is present ---
> even empty --- no apps can use L2 and L3 marking.
>
> Requires: iOS \>= 14.5
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.wifi.managed.QoSMarkingPolicy.QoSMarkingAppleAudioVideoCalls**

> If 'true', adds audio and video traffic of built-in audio or video
> services, such as FaceTime and Wi-Fi Calling, to the allow list for L2
> and L3 marking for traffic that goes to the Wi-Fi network.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.QoSMarkingPolicy.QoSMarkingEnabled**

> If 'true', disables L3 marking and only uses L2 marking for traffic
> that goes to the Wi-Fi network.
>
> If 'false', the system behaves as if Wi-Fi doesn't have an association
> with a Cisco QoS fast lane network.
>
> Requires: iOS \>= 10.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.QoSMarkingPolicy.QoSMarkingWhitelistedAppIdentifiers**

> Use 'QoSMarkingAllowListAppIdentifiers' instead.
>
> Requires: iOS \>= 10.0\
> Deprecated in iOS 14.5
>
> *Type:* null or (list of string)
>
> *Default:*
>
> > null

**profiles.wifi.managed.RoamingConsortiumOIs**

> An array of Roaming Consortium Organization Identifiers used for Wi-Fi
> Hotspot 2.0 negotiation.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or (list of string matching the pattern
> \^(\[0-9A-Za-z\]{6})\|(\[0-9A-Za-z\]{9})\$)
>
> *Default:*
>
> > null

**profiles.wifi.managed.SSID_STR**

> The SSID of the Wi-Fi network to use. In iOS 7.0 and later, the SSID
> is optional if a value exists for 'DomainName' value.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or string
>
> *Default:*
>
> > null

**profiles.wifi.managed.ServiceProviderRoamingEnabled**

> If 'true', allows connection to roaming service providers.
>
> Requires: iOS \>= 7.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**profiles.wifi.managed.TLSCertificateRequired**

> If 'true', allows for two-factor authentication for EAP- TTLS, PEAP,
> or EAP-FAST. If 'false', allows for zero-factor authentication for
> EAP-TLS.
>
> Requires: iOS \>= 4.0
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**target.isSupervised**

> Whether the target device is supervised. Only used for validating
> profile options.
>
> *Type:* null or boolean
>
> *Default:*
>
> > null

**target.udid**

> The UDID of the target device used for deployment. If null, the
> deployment will run on the default device selected by 'go-ios'.
>
> *Type:* null or string
>
> *Default:*
>
> > null

**target.version**

> The iOS version of the target device. Only used for validating profile
> options.
>
> *Type:* null or string
>
> *Default:*
>
> > null
