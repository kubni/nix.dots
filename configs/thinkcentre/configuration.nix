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
    ./ssh
    ../shared/by-all
  ];

  boot = {
    kernelParams = [ "ip=dhcp" ];
    initrd.kernelModules = [
      "e1000e" # Found with nix run nixpkgs#lshw -- -C network | grep -Poh 'driver=[[:alnum:]]+'
    ];

    initrd = {
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
        # TODO: Will be removed in 26.11, migrate to systemd equivalent
        postCommands = ''
          touch /root/.profile
          echo "zfs load-key -a" >> /root/.profile   # This gives us a decryption passphrase prompt after we ssh into the server.
          echo "killall zfs" >> /root/.profile       # This kills the initrd ssh connection and allows the server to unlock itself.
        '';
      };
      systemd.enable = false;
    };
  };

  networking = {
    hostName = "thinkcentre";
    hostId = "f14e8e97";
    nameservers = [ "192.168.1.112" ];
    nftables.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

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
    services.tailscaled.serviceConfig.Environment = [ "TS_DEBUG_FIREWALL_MODE=nftables" ];
    network.wait-online.enable = false;
  };

  services = {
    # TODO: Why? Because of GPU acceleration for video decoding? Does that even make sense?
    xserver = {
      videoDrivers = [ "mesa" ];
    };
    tailscale = {
      enable = true;
    };
    fstrim = {
      enable = true;
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
    openssh.authorizedKeys.keyFiles = [ ./ssh/authorized_keys ];
  };

  programs = {
    mosh.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      mesa
      wireguard-tools
      qrencode
      git
      # agenix.packages."${system}".default
    ];

    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

  };

  system.stateVersion = "25.05";
}
