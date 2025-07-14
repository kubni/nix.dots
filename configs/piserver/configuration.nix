{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    optimise.automatic = true;
  };

  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  networking = {
    hostName = "piserver";
    hostId = "87714217";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [ "192.168.100.1" ];
    # nameservers = [ "192.168.100.39" ];
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
      	enable = true;
	setSocketVariable = true;
      };
    };
  };

  services = {
    openssh = {
      enable = true;
    };
    fstrim = {
      enable = true;
    };
    udisks2.enable = true;

    zfs = {
      autoScrub.enable = true;
    };
  };

  users.users.pi = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs = {
    starship.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];
    };

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
    };
  };

  fonts.packages = with pkgs; [
    commit-mono
    intel-one-mono
    atkinson-hyperlegible
  ];

  # zramSwap = {
  #   enable = true;
  # };

  environment = {
    systemPackages = with pkgs; [
      zsh
      wget
      curl
      git
      cliphist
      unrar
      unzip
      p7zip
      fzf
      fd
      rsync
      tree
      ncdu
      btop
      lm_sensors
      starship
      cmake
      gnumake
      nixd
      usbutils
      ripgrep
    ];

    variables.EDITOR = "nvim";

    pathsToLink = [ "/share/zsh" ];
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
