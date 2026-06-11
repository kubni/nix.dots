{
  config,
  lib,
  pkgs,
  ...
}:

{

  # Users
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

  # Virtualisation
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/home/nikola/docker-data-root";
      };
    };
  };

  # Hardware
  hardware = {
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Services
  services = {
    tailscale.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    blueman.enable = true;
    libinput.enable = true;
    udev = {
      packages = [
        pkgs.vial
        pkgs.qmk-udev-rules
      ];
    };
  };

}
