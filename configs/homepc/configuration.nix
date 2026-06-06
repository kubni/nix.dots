{
  config,
  lib,
  pkgs,
  hyprland,
  ...
}:
let pkgs-unstable = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./emacs
    ./hardware-configuration.nix
    # ./proton-wireguard.nix
    ./mullvad-wireguard.nix
    ./virt.nix
    ./sanoid.nix
    ./claude-desktop.nix
    ./zsh.nix # Zsh related things, specific to this configuration
    ../shared
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    optimise.automatic = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;
    kernelModules = [ "ntsync" ];
    supportedFilesystems = [ "ntfs" ];
    zfs.forceImportRoot = false;
  };

  networking = {
    hostName = "homepc";
    domain = "lan";
    hostId = "dae119c6";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [ "192.168.1.112" ];
    enableIPv6 = false;
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    graphics = {
      package = pkgs-unstable.mesa;
      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/nikola/docker-data-root";
      };
    };
  };

  services = {
    openssh = {
      enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    blueman = {
      enable = true;
    };
    gvfs.enable = true;
    udisks2.enable = true;
    gnome.gnome-keyring.enable = true;

    zfs = {
      autoScrub.enable = true;
    };
    udev = {
     packages = [
      pkgs.vial 
      pkgs.qmk-udev-rules
     ];
    };
    hardware.openrgb = { 
      enable = true; 
      package = pkgs.openrgb-with-all-plugins; 
      motherboard = "amd"; 
      server.port = 6742; 
    };
  };



    users.users.nikola = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
        "docker"
        "adbusers"
      ];
    shell = pkgs.zsh;
  };


    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      fonts = {
        serif = config.stylix.fonts.sansSerif;
        sansSerif = {
          package = pkgs.atkinson-hyperlegible;
          name = "Atkinson Hyperlegible";
        };
        monospace = {
          package = pkgs.atkinson-hyperlegible-mono;
          name = "Atkinson Hyperlegible Mono";
        };
      };
    };


  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;
    virt-manager.enable = true;


    ssh = {
      extraConfig = "
        Host *
        ServerAliveInterval 100
      ";
    };
  };

  fonts.packages = with pkgs; [
    commit-mono
    intel-one-mono
    atkinson-hyperlegible
    nerd-fonts.symbols-only
  ];

  zramSwap = {
    enable = true;
  };

  environment = let 
                # NOTE: Creates a `wine64` symlink thats just pointing to our wine, this fixes winetricks which seemingly has hardcoded calls to wine64, even though not all wine builds ship with it.
                # winePkg = pkgs.wineWow64Packages.waylandFull;
                winePkg = pkgs.wineWow64Packages.stagingFull;
                wineSymlink = pkgs.runCommand "wine-symlink" {
                  nativeBuildInputs = [ pkgs.makeWrapper ];
                } ''
                    mkdir -p $out/bin
                    ln -s ${winePkg}/bin/wine $out/bin/wine64
                  '';
                in {
    systemPackages = with pkgs; [
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
      nurl
      pciutils
      pcmanfm
      usbutils
      xdg-utils
      gnome-keyring
      libtool
      ethtool
      lsof
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
      texlive.combined.scheme-medium
      texlab
      openrgb-with-all-plugins
      amdgpu_top
      devenv

      (pkgs.writeShellApplication {
        name = "toggle-nightlight";
        runtimeInputs = [ wlsunset ];
        text = ''
          if pgrep -x "wlsunset" > /dev/null; then
          	pkill -x "wlsunset"
          else
          	wlsunset -l 44.8 -L 20.4 &
          fi
        '';
      })
    ];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
