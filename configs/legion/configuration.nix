{
  config,
  lib,
  pkgs,
  hyprland,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./emacs
    ../shared/packages

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
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "amdgpu" ];

    supportedFilesystems = [ "ntfs" ];

    initrd.systemd.network.wait-online.enable = false;
  };

  networking = {
    hostName = "legion";
    hostId = "781678cc";
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
    networkmanager.enable = true;
  };

  systemd = {
    services.tailscaled.serviceConfig.Environment = [ 
      "TS_DEBUG_FIREWALL_MODE=nftables" 
    ];
    network.wait-online.enable = false; 
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {

    amdgpu.initrd.enable = false;
    enableRedistributableFirmware = lib.mkDefault true;
    graphics.enable = true;

    nvidia-container-toolkit.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        sync.enable = true;
        # offload.enable = true;
        # offload.enableOffloadCmd = true;
        nvidiaBusId = "PCI:1@0:0:0";
        amdgpuBusId = "PCI:5@0:0:0";
      };
      powerManagement = {
        enable = true;
        # finegrained = true;
      };

      # TODO: powerManagement.enable and powerManagement.finegrained
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      # enableNvidia = true; # DEPRECATED
      daemon.settings = {
        data-root = "/home/nikola/docker-data-root";
      };
    };
  };

  services = {
    tailscale = {
      enable = true;
    };
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
    libinput.enable = true;
    fwupd.enable = true;

    udev = {
     packages = [
      pkgs.vial 
      pkgs.qmk-udev-rules
     ];
    };

    xserver.videoDrivers = [ "amdgpu" "nvidia" ];
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
    zsh.enable = true;
    steam.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;
    virt-manager.enable = true;


    nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          options = {
            tabstop = 2;
            shiftwidth = 2;
          };

          clipboard = {
            enable = true;
            providers = {
              wl-copy.enable = true;
            };
            registers = "unnamedplus";
          };

          lsp = {
            enable = true;
            lspSignature.enable = true;
          };

          languages = {
            enableTreesitter = true;
            nix.enable = true;
          };

          visuals = {
            nvim-web-devicons.enable = true;
          };

          tabline = {
            nvimBufferline.enable = true;
          };

          extraPlugins = {
            nord = {
              package = pkgs.vimPlugins.nordic-nvim;
              setup = "vim.cmd[[colorscheme nordic]]";
            };
          };
        };
      };
    };
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
      zsh
      wget
      curl
      git
      mako
      libnotify
      grim
      slurp
      cliphist
      unrar
      unzip
      p7zip
      fzf
      fd
      rsync
      tree
      ncdu
      wlsunset
      btop
      lm_sensors
      pulsemixer
      wl-clipboard
      mono
      qbittorrent
      wofi
      waybar
      starship
      mpv
      cmake
      gnumake
      nixd
      # bitwarden-desktop
      jdk21
      xeyes
      brightnessctl
      nix-prefetch-git
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
      nix-search-cli
      mosh
      nix-tree
      cpu-x
      vial
      qmk 
      qmk-udev-rules
      android-tools
      libinput
      lenovo-legion
      devenv
      wireguard-tools
      powertop
      ### Claude Desktop stuff
      claude-desktop
      bubblewrap
      qemu_kvm
      socat
      virtiofsd
      nodejs
      ###

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
     
    variables.EDITOR = "nvim";
    sessionVariables.NIXOS_OZONE_WL = "1";

    pathsToLink = [ "/share/zsh" ];
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
