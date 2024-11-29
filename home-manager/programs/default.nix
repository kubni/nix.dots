{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./zsh.nix
    ./kitty.nix
    ./mako.nix
    ./starship.nix
    ./direnv.nix
    ./gtk.nix
    ./dconf.nix
    ./kdeconnect.nix
    ./hyprland
    ./mpv
  ];

  programs = {
    obs-studio.enable = true;    
  };

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
    vesktop
    mono
    hyprpaper
    mangohud
    jellyfin-media-player
    unigine-valley
    libreoffice-qt6-fresh
    yarn-berry
    teams-for-linux
    droidcam
    pandoc
    foliate
    qview
    viber
    freetube
    zathura
  ];
}
