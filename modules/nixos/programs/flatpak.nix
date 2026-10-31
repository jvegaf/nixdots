{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  options.programs.flatpak.enable = lib.mkEnableOption "flatpak";

  config = lib.mkIf config.programs.flatpak.enable {
    services = {
      flatpak = {
        enable = true;

        remotes = lib.mkOptionDefault [
          {
            name = "solidcraft";
            location = "https://docs.solidcraft.io/flatpak/solidcraft.flatpakrepo";
          }
        ];

        # List the Flatpak applications you want to install
        # Use the official Flatpak application ID (e.g., from flathub.org)
        # Examples:
        packages = [
          # Manage flatpak permissions - should always have this
          {
            appId = "solidcraft io.tangencylabs.solidcraft";
            origin = "solidcraft";
          }
          #"it.mijorus.gearlever"           # Manage and support AppImages
          #"com.rtosta.zapzap"              # WhatsApp client
          #"io.github.freedoom.Phase1"      #  Classic Doom FPS 1
          #"io.github.freedoom.Phase2"      #  Classic Doom FPS 2
          #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
          #"de.schmidhuberj.tubefeeder"     # watch YT videos

          # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"
          # { appId = "io.github.jpietek.PenguinBurner"; origin = "penguinburner";  }
        ];

        # Optional: Automatically update Flatpaks when you run nixos-rebuild swit ch
        update.onActivation = true;
      };
    };
  };
}
