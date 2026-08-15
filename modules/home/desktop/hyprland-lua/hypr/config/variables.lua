-- Hyprland default apps

TERMINAL = "kitty"
FILE_MANAGER = "dolphin"
BROWSER = "firefox"
-- EDITOR       = "gnome-text-editor --new-window"
EDITOR = "nvim"
CALCULATOR = "gnome-calculator"
-- WHISPER is CachyOS-only (/usr/lib/hyprwhspr does not exist on NixOS);
-- the SUPER+ALT+Z bind is commented out in config/binds.lua.
-- WHISPER = "/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"

-- Monitors
MONITOR1 = "eDP-1"
MONITOR2 = ""
MONITOR3 = ""
PRIMARY_MONITOR = MONITOR1

-- Workspaces
NUM_WPM = 3 -- Number of workspaces per monitor (Max 10)
