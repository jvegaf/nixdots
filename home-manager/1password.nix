{ lib, pkgs, user, config, ... }:
{
  # programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "${user}" ];
    # polkitPolicyOwners = [ "th3g3ntl3man" ];
  };

  config.environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
        chromium
      '';
      mode = "0755";
    };
  }
}
