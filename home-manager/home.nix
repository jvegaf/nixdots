{ config, pkgs, ...}: {
	imports = [
		./modules
		./home-packages.nix
	];
	home = {
		username = "th3g3ntl3man";
		homeDirectory = "/home/th3g3ntl3man";
		stateVersion = "25.11";
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			rebuild = "sudo nixos-rebuild switch";
		};
	};
}
