# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, hyprland, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./wireguard.nix
      ./emacs
      ./go
    ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nix.optimise.automatic = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use unstable kernel
  boot.kernelPackages = pkgs-unstable.linuxPackages_zen;

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.opengl = {
    enable = true;
  };
  
  services.xserver.videoDrivers = ["nvidia"];

  services.openssh = {
    enable = true;
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.nikola = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  programs.hyprland = {
   enable = true;
   #package = pkgs-unstable.hyprland;
   package = hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.zsh = {
    enable = true;
  };

  programs.steam = {
    enable = true;
  };

  programs.gamemode = {
    enable = true;
  };

  programs.kdeconnect = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    nerdfonts
    commit-mono
  ];

  zramSwap = {
    enable = true;
  };

  services.fstrim = {
    enable = true;
  };

  environment = { 
    systemPackages = with pkgs; [
      zsh
      neovim
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

      (pkgs.writeShellApplication {
	name = "toggle-nightlight";
	runtimeInputs = [ wlsunset ];
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

    pathsToLink = [ "/share/zsh" ];
  
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

