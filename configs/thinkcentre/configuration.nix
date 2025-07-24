{
  pkgs,
  lib,
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
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ "ip=dhcp" ];
    initrd.kernelModules = [
      "e1000e" # Found with nix run nixpkgs#lshw -- -C network | grep -Poh 'driver=[[:alnum:]]+'
    ];
    initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        port = 2222;
        hostKeys = [
          "/etc/secrets/initrd/ssh_host_ed25519_key"
        ];
        authorizedKeyFiles = [
          ./ssh/authorized_keys 
        ];
      };
      postCommands = ''
        touch /root/.profile
        echo "zfs load-key -a" >> /root/.profile   # This gives us a decryption passphrase prompt after we ssh into the server.
        echo "killall zfs" >> /root/.profile       # This kills the initrd ssh connection and allows the server to unlock itself.
      '';
    };
  };
 

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };


  networking = {
    hostName = "thinkcentre";
    hostId = "f14e8e97";
    networkmanager = {
      enable = true;
    };
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = [ "192.168.100.1" ];
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    # graphics.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/thinker/docker-data-root";
      };
    };
  };

  services = {
    xserver = {
      videoDrivers = [ "mesa" ];
    };
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

  users.users.thinker = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
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

    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
  };

  fonts.packages = with pkgs; [
    commit-mono
    atkinson-hyperlegible
    nerd-fonts.symbols-only
  ];

  zramSwap = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      mesa
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
      ranger
      wlsunset
      btop
      lm_sensors
      starship
      cmake
      gnumake
      nixd
      nix-prefetch-git
      nurl
      pciutils
      usbutils
      libtool
      ethtool
      lsof
      nix-search-cli
      zoxide
    ];

    variables.EDITOR = "nvim";

    pathsToLink = [ "/share/zsh" ];
  };

  system.stateVersion = "25.05"; 
}
