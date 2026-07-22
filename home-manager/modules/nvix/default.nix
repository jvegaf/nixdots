{ pkgs, inputs, lib, ... }:
let

  nvix = inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.core;
in
{
  home.packages = [

    (nvix.extend {

      config = {

        vimAlias = true;
        # colorschemes.kanagawa.enable = lib.mkForce false;
        # colorschemes.tokyonight = {
        #
        #   enable = true;
        #   settings.style = "night";
        #
        # };

        # Disable a plugin
        plugins.leetcode.enable = lib.mkForce false;

        # keymaps = [
        #   (mkKeymap "n" "<leader>tt" "<cmd>echo 'Test'<CR>" "Test Keymap")
        # ];
      };

    })

  ];
}
