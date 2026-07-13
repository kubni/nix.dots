{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../shared/by-all
    ../shared/by-pcs
  ];

  boot = {
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
    fwupd.enable = true;

    xserver.videoDrivers = [
      "amdgpu"
      "nvidia"
    ];
  };

  environment.systemPackages = with pkgs; [
    nixd
    lenovo-legion
    wireguard-tools
    powertop
    nodejs
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
