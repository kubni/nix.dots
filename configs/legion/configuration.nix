{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./emacs
    ../shared/by-all
    ../shared/by-pcs
  ];

  boot = {
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
  };

  systemd = {
    services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
  };

  hardware = {
    amdgpu.initrd.enable = false;
    enableRedistributableFirmware = lib.mkDefault true;

    nvidia-container-toolkit.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1@0:0:0";
        amdgpuBusId = "PCI:5@0:0:0";
      };
      powerManagement = {
        enable = true;
      };

    };
  };

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    fwupd.enable = true;

    xserver.videoDrivers = [
      "amdgpu"
      "nvidia"
    ];
  };

  programs = {
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

  environment.systemPackages = with pkgs; [
    nixd
    lenovo-legion
    wireguard-tools
    powertop
    claude-desktop-fhs
    bubblewrap
    qemu_kvm
    socat
    virtiofsd
    nodejs
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
