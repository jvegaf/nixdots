{ user, ... }:

{
  # Herramienta de terminal (CLI) - Aquí estaba el error
  programs._1password.enable = true;

  # Aplicación de escritorio (GUI) - Esta se queda igual
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "${user}" ]; 
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        firefox
        chromium
      '';
      mode = "0755";
    };
  };
}
