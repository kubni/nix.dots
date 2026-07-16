{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./mango
    # ./waybar
    ./terminals
    ./mako.nix
    ./direnv.nix
    ./browsers.nix
    ./dconf.nix
    ./noctalia.nix
    ./aerc.nix
    ./git.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    fastfetch
    lsd
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
    # bottles
    prismlauncher

    (pkgs.lutris.override {
      extraPkgs = pkgs: [
        pkgs.wineWow64Packages.stagingFull
        pkgs.winetricks
      ];
    })
  ];
}
