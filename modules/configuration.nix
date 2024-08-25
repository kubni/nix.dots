# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, hyprland, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opengl = {
    enable = true;
  };
  
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.nikola = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     curl 
     git
     dunst
     grim
     slurp
     cliphist
     unrar
     unzip

     wineWowPackages.stable
     winetricks
     mono
     qbittorrent

     (waybar.overrideAttrs (oldAttrs: {
     	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
     )
   ];
   environment.variables.EDITOR = "nvim";

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    #package = pkgs-unstable.hyprland;
    package = hyprland.packages.${pkgs.system}.hyprland;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

