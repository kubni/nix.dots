{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./waybar
    ./terminals
    ./mako.nix
    ./direnv.nix
    ./browsers.nix
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    fastfetch
    lsd
    vesktop
    mangohud
    jellyfin-media-player
    jellyfin-mpv-shim
    libreoffice-qt6-fresh
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
    signal-desktop
    prismlauncher

    (pkgs.lutris.override {
      extraPkgs = pkgs: [
        pkgs.wineWow64Packages.stagingFull
        pkgs.winetricks
      ];
    })
  ];
}
