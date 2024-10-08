{pkgs, ...}: {

  imports = [
    ./hyprland
    ./mpv
    ./browsers.nix
    ./zsh.nix
    ./kitty.nix
    ./mako.nix
    ./starship.nix
    ./kdeconnect.nix
    ./vscodium.nix    
    ./direnv.nix
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
    mangohud
    jellyfin-media-player
    unigine-valley
    libreoffice-qt6-fresh
    yarn-berry
    teams-for-linux
    obs-studio
  ];
}
