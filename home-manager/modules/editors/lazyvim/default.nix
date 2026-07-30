{ inputs, ... }:
{
  imports = [ inputs.lazyvim.homeManagerModules.default ];
  programs.lazyvim = {
    enable = true;
    configFiles = ./my-lazyvim;

    installCoreDependencies = true;

    extras = {
      lang.nix.enable = true;
      lang.nix.installDependencies = true;

      lang.python = {
        enable = true;
        installDependencies = true; # Install ruff
        installRuntimeDependencies = true; # Install python3
      };
      # lang.go = {
      #   enable = true;
      #   installDependencies = true; # Install gopls, gofumpt, etc.
      #   installRuntimeDependencies = true; # Install go compiler
      # };
    };

    # Additional packages (optional)
    # extraPackages = with pkgs; [
    #   nixd # Nix LSP
    #   alejandra # Nix formatter
    # ];

  };
}
