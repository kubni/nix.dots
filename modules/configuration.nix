{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  hyprland,
  ...
}: {
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
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
    kernelPackages = pkgs-unstable.linuxPackages_zen;
    kernelModules = ["kvm-intel"];
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opengl = {
    enable = true;
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

  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;

    #package = config.boot.kernelPackages.nvidiaPackages.beta;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "560.35.03";
      sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
      persistencedSha256 = lib.fakeSha256;
    };
  };

  users.users.nikola = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "libvirtd"];
    shell = pkgs.zsh;
  };

  programs = {
    hyprland = {
      enable = true;
      #package = pkgs-unstable.hyprland;
      package = hyprland.packages.${pkgs.system}.hyprland;
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
          
          lsp = {
            enable = true;
            lspSignature.enable = true;
          };
          
          languages = {
            enableLSP = true;
            enableTreesitter = true;
            nix.enable = true;
          };

          #theme = {
          #  enable = true;
          #  name = "rose-pine";
          #  style = "main";
          #  transparent = false;
          #};

          autopairs.enable = true;

          autocomplete = {
            enable = true;
            type = "nvim-cmp";
          };

          visuals = {
            nvimWebDevicons.enable = true;
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
    noto-fonts
    nerdfonts
    commit-mono
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
      wineWowPackages.stable
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
      direnv
      nix-direnv
      bitwarden 

      keycloak
      jdk21


      (pkgs.writeShellApplication {
        name = "toggle-nightlight";
        runtimeInputs = [wlsunset];
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

    variables.EDITOR = "nvim";

    pathsToLink = ["/share/zsh"];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
