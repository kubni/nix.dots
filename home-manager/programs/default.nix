{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./zsh.nix
    ./kitty.nix
    ./mako.nix
    ./hyprland
  ];


  # Install some commonly found programs that don't need additional configs
  home.packages = with pkgs; [
    neofetch
    zip
    unzip
    ripgrep
    kitty
    ranger
    lsd
    duf
    fuc # Provides cpz and rmz
    bat
    thunderbird

    vesktop
    mono
    hyprpaper
  ];
}
