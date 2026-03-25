{ config, pkgs, ...}: 
let
  nixvim = import (builtins.fetchGit {
    # url = "https://github.com/nix-community/nixvim";
    url = "https://github.com/dc-tec/nixvim";
    # When using a different channel you can use `ref = "nixos-<version>"` to set it here
  });
in
{
	imports = [
		nixvim.homeModules.nixvim
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
			ngc = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3";
		};
	};

	programs.ssh = {
		enable = true;
		extraConfig = ''
			Host github.com
			IdentityFile ~/.ssh/jvegaf_ed25519
		'';
	};

	
	programs.nixvim.imports = [ ./modules/nixvim.nix ];

}
