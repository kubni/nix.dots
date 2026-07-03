{
  config,
  lib,
  pkgs,
  ...
}:

{

  boot = {
    kernelPackages = pkgs.linuxPackages_7_0;
    kernelModules = [ "ntsync" ];
    # supportedFilesystems = [ "ntfs" ];
  };

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
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
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

}
