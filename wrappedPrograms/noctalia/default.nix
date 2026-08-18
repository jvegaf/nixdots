{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages = {
      noctalia-shell = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        env = {
          "NOCTALIA_CACHE_DIR" = "/tmp/noctalia-cache/";
        };
        colors = {
          mError = "#fb4934";
          mHover = "#83a598";
          mOnError = "#282828";
          mOnHover = "#282828";
          mOnPrimary = "#282828";
          mOnSecondary = "#282828";
          mOnSurface = "#fbf1c7";
          mOnSurfaceVariant = "#ebdbb2";
          mOnTertiary = "#282828";
          mOutline = "#57514e";
          mPrimary = "#b8bb26";
          mSecondary = "#fabd2f";
          mShadow = "#282828";
          mSurface = "#282828";
          mSurfaceVariant = "#3c3836";
          mTertiary = "#83a598";
        };
        settings = {
          appLauncher = {
            customLaunchPrefix = "";
            customLaunchPrefixEnabled = false;
            enableClipPreview = true;
            enableClipboardHistory = false;
            iconMode = "tabler";
            pinnedExecs = [];
            position = "center";
            showCategories = true;
            sortByMostUsed = true;
            terminalCommand = "kitty -e";
            useApp2Unit = false;
            viewMode = "list";
          };
          audio = {
            cavaFrameRate = 30;
            externalMixer = "pwvucontrol || pavucontrol";
            mprisBlacklist = [];
            preferredPlayer = "";
            visualizerType = "linear";
            volumeOverdrive = false;
            volumeStep = 5;
          };
          bar = {
            capsuleOpacity = 1;
            density = "comfortable";
            exclusive = true;
            floating = false;
            marginHorizontal = 0.25;
            marginVertical = 0.25;
            monitors = [];
            outerCorners = true;
            position = "left";
            showCapsule = false;
            showOutline = false;
            transparent = false;
            widgets = {
              center = [];
              left = [
                {
                  colorizeDistroLogo = true;
                  colorizeSystemIcon = "tertiary";
                  customIconPath = "";
                  enableColorization = true;
                  id = "ControlCenter";
                  useDistroLogo = true;
                }
                {
                  characterCount = 2;
                  colorizeIcons = false;
                  enableScrollWheel = true;
                  followFocusedScreen = false;
                  hideUnoccupied = true;
                  id = "Workspace";
                  labelMode = "none";
                  showApplications = false;
                  showLabelsOnlyWhenOccupied = true;
                }
              ];
              right = [
                {
                  hideWhenZero = false;
                  id = "NotificationHistory";
                  showUnreadBadge = true;
                }
                {
                  id = "PowerProfile";
                }
                {
                  displayMode = "alwaysHide";
                  id = "Volume";
                }
                {
                  deviceNativePath = "";
                  displayMode = "alwaysShow";
                  hideIfNotDetected = true;
                  id = "Battery";
                  showNoctaliaPerformance = false;
                  showPowerProfiles = false;
                  warningThreshold = 20;
                }
                {
                  displayMode = "alwaysHide";
                  id = "Microphone";
                }
                {
                  displayMode = "forceOpen";
                  id = "KeyboardLayout";
                }
                {
                  customFont = "";
                  formatHorizontal = "HH:mm ddd, MMM dd";
                  formatVertical = "HH mm - dd MM";
                  id = "Clock";
                  useCustomFont = false;
                  usePrimaryColor = true;
                }
                {
                  blacklist = [];
                  colorizeIcons = false;
                  drawerEnabled = true;
                  hidePassive = false;
                  id = "Tray";
                  pinned = [];
                }
              ];
            };
          };
          general = {
            allowPanelsOnScreenWithoutBar = true;
            animationDisabled = false;
            animationSpeed = 1;
            avatarImage = inputs.self + /nixos/features/wallpaper/gruvbox-mountain-village.png;
            boxRadiusRatio = 1;
            compactLockScreen = false;
            dimmerOpacity = 0.15;
            enableShadows = true;
            forceBlackScreenCorners = false;
            iRadiusRatio = 1;
            language = "";
            lockOnSuspend = true;
            radiusRatio = 1;
            scaleRatio = 1;
            screenRadiusRatio = 1;
            shadowDirection = "bottom_right";
            shadowOffsetX = 2;
            shadowOffsetY = 3;
            showHibernateOnLockScreen = false;
            showScreenCorners = false;
            showSessionButtonsOnLockScreen = true;
          };
          notifications = {
            backgroundOpacity = 1;
            criticalUrgencyDuration = 15;
            enableKeyboardLayoutToast = true;
            enabled = true;
            location = "top_right";
            lowUrgencyDuration = 8;
            monitors = [];
            normalUrgencyDuration = 8;
            overlayLayer = true;
            respectExpireTimeout = false;
            sounds = {
              criticalSoundFile = "";
              enabled = false;
              excludedApps = "discord,firefox,chrome,chromium,edge";
              lowSoundFile = "";
              normalSoundFile = "";
              separateSounds = false;
              volume = 0.5;
            };
          };
          osd = {
            autoHideMs = 3000;
            backgroundOpacity = 1;
            enabled = true;
            enabledTypes = [0 1 2 4];
            location = "bottom";
            monitors = [];
            overlayLayer = true;
          };
          screenRecorder = {
            audioCodec = "opus";
            audioSource = "default_output";
            colorRange = "limited";
            directory = "/home/th3g3ntl3man/Videos";
            frameRate = 60;
            quality = "very_high";
            showCursor = true;
            videoCodec = "h264";
            videoSource = "portal";
          };
          sessionMenu = {
            countdownDuration = 10000;
            enableCountdown = true;
            largeButtonsStyle = false;
            position = "center";
            powerOptions = [
              { action = "lock"; command = ""; countdownEnabled = true; enabled = true; }
              { action = "suspend"; command = ""; countdownEnabled = true; enabled = true; }
              { action = "hibernate"; command = ""; countdownEnabled = true; enabled = true; }
              { action = "reboot"; command = ""; countdownEnabled = true; enabled = true; }
              { action = "logout"; command = ""; countdownEnabled = true; enabled = true; }
              { action = "shutdown"; command = ""; countdownEnabled = true; enabled = true; }
            ];
            showHeader = true;
          };
          settingsVersion = 32;
          ui = {
            bluetoothDetailsViewMode = "grid";
            bluetoothHideUnnamedDevices = false;
            fontDefault = "Sans Serif";
            fontDefaultScale = 1;
            fontFixed = "monospace";
            fontFixedScale = 1;
            panelBackgroundOpacity = 1;
            panelsAttachedToBar = true;
            settingsPanelMode = "attached";
            tooltipsEnabled = true;
            wifiDetailsViewMode = "grid";
          };
          wallpaper.enabled = false;
        };
      };
    };
  };
}
