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
			nrs = "sudo nixos-rebuild switch";
			neh = "sudo nvim /etc/nixos/home.nix";
			nec = "sudo nvim /etc/nixos/configuration.nix";
			ngc = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3"
		};
	};
}
