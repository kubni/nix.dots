{ pkgs, ... }: {

  imports = [
    ./kdeconnect.nix
    ./hyprland
    ./mpv
  ];

  programs = {
    obs-studio.enable = true;
  };

  # Install some commonly found programs that don't need additional configs
  # home.packages = with pkgs; [
  #   fastfetch
  #   zip
  #   unzip
  #   ripgrep
  #   kitty
  #   ranger
  #   lsd
  #   duf
  #   bat
  #   vesktop
  #   mono
  #   hyprpaper
  #   mangohud
  #   jellyfin-media-player
  #   jellyfin-mpv-shim
  #   libreoffice-qt6-fresh
  #   pandoc
  #   foliate
  #   qview
  #   viber
  #   freetube
  #   zathura
  #   thunderbird-latest
  #   browsh
  #   wezterm
  #   bottles
  #   # webcord-vencord
  #   signal-desktop
  #   prismlauncher
  #  # tailscale

  #   (pkgs.lutris.override {
  #       extraPkgs = pkgs: [
  #         pkgs.wineWow64Packages.stagingFull
  #         pkgs.winetricks
  #       ];
  #   })
  # ];
}
