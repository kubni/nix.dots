{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./zsh.nix
    ./kitty.nix
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
    p7zip

    vesktop
    mono

  ];
}
