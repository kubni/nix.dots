{
  config,
  pkgs,
  # agenix,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./wireguard-server.nix
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

    initrd ={
      network = {
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
      systemd.enable = false;
    };

    zfs.forceImportRoot = false;
  };
 
  networking = {
    hostName = "thinkcentre";
    hostId = "f14e8e97";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = [ "192.168.1.1" ];
    useDHCP = false;
    dhcpcd.enable = false;
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/thinker/docker-data-root";
      };
    };
  };

  systemd = {
    services.tailscaled.serviceConfig.Environment = [ "TS_DEBUG_FIREWALL_MODE=nftables"];
    network.wait-online.enable = false;
  };
  services = {
    xserver = {
      videoDrivers = [ "mesa" ];
    };
    openssh = {
      enable = true;
    };
    tailscale = {
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
    mosh.enable = true;
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
      lm_sensors
      nurl
      pciutils
      usbutils
      libtool
      ethtool
      wireguard-tools
      qrencode
      dig
      # agenix.packages."${system}".default      
    ];
    sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  };

  system.stateVersion = "25.05"; 
}
