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
    ./wireguard.nix
    ./virt.nix
    ./emacs
    ./coding
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
    kernelPackages = pkgs.linuxPackages_6_15;

    kernelModules = [
      # "vfio-pci"
      "kvm-intel"
    ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };


  networking = {
    hostName = "nixos";
    hostId = "dae119c6";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [ "192.168.100.1" ];
    # nameservers = [ "192.168.100.39" ];
    interfaces = {
      enp0s31f6.wakeOnLan = {
        enable = true;
      };
    };
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    #opengl.enable = true;
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = false;

      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "575.64";
        # sha256_64bit = "sha256-XZ0N8ISmoAC8p28DrGHk/YN1rJsInJ2dZNL8O+Tuaa0=";
        sha256_64bit = "sha256-6wG8/nOwbH0ktgg8J+ZBT2l5VC8G5lYBQhtkzMCtaLE=";
        sha256_aarch64 = lib.fakeSha256;
        openSha256 = lib.fakeSha256;
        settingsSha256 = lib.fakeSha256;
        persistencedSha256 = lib.fakeSha256;
      };
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
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
    openssh = {
      enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    fstrim = {
      enable = true;
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

  programs = {
    hyprland = {
      enable = true;
      # package = hyprland.packages.${pkgs.system}.hyprland;
    };
    zsh.enable = true;
    steam.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;
    virt-manager.enable = true;
    adb.enable = true;

    nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;

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

  environment = {
    systemPackages = with pkgs; [
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
      wineWowPackages.unstableFull
      winetricks
      mono
      qbittorrent
      wofi
      waybar
      starship
      mpv
      cmake
      gnumake
      nixd
      bitwarden
      jdk21
      xorg.xeyes
      brightnessctl
      nix-prefetch-git
      nurl
      pciutils
      cudatoolkit
      pcmanfm
      usbutils
      xdg-utils
      gnome-keyring
      nvidia-vaapi-driver
      libtool
      ethtool
      lsof
      virtio-win
      appimage-run
      libxml2
      OVMF
      nix-search-cli
      mosh

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

      (pkgs.writeShellApplication {
        name = "toggle-vpn";
        text = ''
          if systemctl is-active --quiet wg-quick-wg0.service; then
          	systemctl stop wg-quick-wg0.service;
          else
                systemctl start wg-quick-wg0.service;
          fi
        '';
      })
    ];
    # ] ++ [
    #   pkgs-stable.OVMF
    # ];

    variables.EDITOR = "nvim";
    sessionVariables.NIXOS_OZONE_WL = "1";

    pathsToLink = [ "/share/zsh" ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
