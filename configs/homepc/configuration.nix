{
  config,
  lib,
  pkgs,
  hyprland,
  ...
}:
let
  pkgs-unstable = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./emacs
    ./hardware-configuration.nix
    # ./proton-wireguard.nix
    ./mullvad-wireguard.nix
    ./virt.nix
    ./sanoid.nix
    ./zsh.nix
    ../shared/by-all
    ../shared/by-pcs
  ];

  networking = {
    hostName = "homepc";
    hostId = "dae119c6";
    nameservers = [ "192.168.1.112" ];
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    graphics = {
      package = pkgs-unstable.mesa;
      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };
  };

  services = {
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      server.port = 6742;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      texlive.combined.scheme-medium
      texlab
      openrgb-with-all-plugins
      amdgpu_top
    ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
