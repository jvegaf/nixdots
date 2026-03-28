{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    # kdenlive
    neovim
    git
    eza
    # jetbrains.pycharm-professional
    # jre8
    # qemu
    # quickemu
  ];
}
