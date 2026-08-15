{
  inputs,
  lib,
  pkgs,
  ...
}:
pkgs.buildGoModule rec {
  pname = "gentle-ai";
  version = "1.43.3";

  src = inputs.gentle-ai;

  subPackages = [ "cmd/gentle-ai" ];

  vendorHash = "sha256-g886XpkhuCJlh+K8SPJWDbKl+Y/w0pk38fkpBb9kNC8=";

  meta = {
    description = "Ecosystem configurator for AI coding agents";
    homepage = "https://github.com/Gentleman-Programming/gentle-ai";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "gentle-ai";
  };
}
