{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./mako.nix
    ./starship.nix
    ./direnv.nix
    ./gtk.nix
    ./dconf.nix
    ./kdeconnect.nix
    ./mangowc.nix
    ./hyprland
    ./zsh
    ./mpv
    ./terminals
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
    bat
    vesktop
    mono
    hyprpaper
    mangohud
    # jellyfin-media-player
    jellyfin-mpv-shim
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
    thunderbird-latest
    browsh
    wezterm
    bottles
    # webcord-vencord
    signal-desktop
    prismlauncher

    (pkgs.lutris.override {
        extraPkgs = pkgs: [
          pkgs.wineWowPackages.stagingFull
          pkgs.winetricks
        ];
    })
  ];
}
