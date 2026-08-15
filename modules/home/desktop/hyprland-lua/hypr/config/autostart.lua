-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	-- gnome-keyring-daemon is managed by GNOME/systemd on NixOS; the
	-- /usr/bin path does not exist there.
	-- hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=gpg")
	-- hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11")
	-- hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets")
	-- hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=ssh")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("xhost +SI:localuser:root")
end)
