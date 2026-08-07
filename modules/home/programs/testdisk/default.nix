{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # testdisk
      testdisk-qt
    ];
  };
}
