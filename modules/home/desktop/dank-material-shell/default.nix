{
  inputs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.homeModules.dms-plugin-registry
  ];

  programs.dank-material-shell = {
    enable = true;

    settings = {
      firstDayOfWeek = 1;
      theme = "dark";
      dynamicTheming = true;
      controlCenterWidgets = {
        battery.enable = true;
        iddleInhibitor.enable = true;
      };
      soundNewNotification = false;
      dankIslandBarId = "default";
      # Add any other settings here
    };

    plugins = {
      # Simply enable plugins by their ID (from the registry)
      dankBatteryAlerts.enable = true;
      colorPickerDms.enable = true;
      developerUtilities.enable = true;

      webSearch = {
        enable = true;
        settings = {
          searchEngines = {
            aliexpress = {
              name = "Aliexpress";
              icon = "unicode:🔍";
              url = "http://www.aliexpress.com/wholesale?SearchText=%s";
              keywords = [
                "aliex"
              ];
            };
          };
        };
      };
      screenCaptureToolbar.enable = true;
      dankKDEConnect.enable = true;
      dmsThemeSync.enable = true;
      # Add plugin-specific settings
      # mediaPlayer = {
      #   enable = true;
      #
      #   # You can only define settings here if using the home-manager module
      #   settings = {
      #     preferredSource = "spotify";
      #   };
      # };
    };

    session = {
      isLightMode = false;
      idleInhibited = true;
      weatherLocation = "Getafe, Comunidad de Madrid";
      weatherCoordinates = "40.3070639,-3.7331808";
      showThirdPartyPlugins = true;
      # Add any other session state settings here
    };

    clipboardSettings = {
      maxHistory = 25;
      maxEntrySize = 5242880;
      autoClearDays = 1;
      clearAtStartup = true;
      disabled = false;
      disableHistory = false;
      disablePersist = true;
    };
  };
}
