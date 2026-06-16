{
  config,
  lib,
  pkgs,
  ...
}:

let
  winePkg = pkgs.wineWow64Packages.stagingFull;

  wineSymlink =
    pkgs.runCommand "wine-symlink"
      {
        nativeBuildInputs = [ pkgs.makeWrapper ];
      }
      ''
        mkdir -p $out/bin
        ln -s ${winePkg}/bin/wine $out/bin/wine64
      '';

  toggleNightlight = pkgs.writeShellApplication {
    name = "toggle-nightlight";
    runtimeInputs = [ pkgs.wlsunset ];
    text = ''
      if pgrep -x "wlsunset" > /dev/null; then
          pkill -x "wlsunset"
      else
          wlsunset -l 44.8 -L 20.4 &
      fi
    '';
  };
in
{
  environment = {
    systemPackages =
      with pkgs;
      [
        winePkg
        wineSymlink
        winetricks
        mako
        libnotify
        grim
        slurp
        cliphist
        wlsunset
        pulsemixer
        wl-clipboard
        mono
        qbittorrent
        wofi
        waybar
        mpv
        jdk21
        xeyes
        brightnessctl
        pcmanfm
        xdg-utils
        gnome-keyring
        virtio-win
        appimage-run
        libxml2
        OVMF
        mosh
        nix-tree
        cpu-x
        vial
        qmk
        qmk-udev-rules
        android-tools
        devenv
        toggleNightlight
        # bitwarden-desktop
      ];

    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
