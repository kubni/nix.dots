{ config, pkgs, ... }: 

{

  environment = {
    systemPackages = with pkgs; [
      nixfmt
      zsh
      wget
      curl
      git
      unrar
      unzip
      p7zip
      fzf
      fd
      rsync
      tree
      ncdu
      ranger
      btop
      starship
      cmake
      gnumake
      nixd
      nix-prefetch-git
      nix-search-cli
      ripgrep
      lsof
      zoxide
      lm_sensors
      net-tools
      lsd
      duf
    ];
    variables.EDITOR = "nvim";
    pathsToLink = [ "/share/zsh" ];
  };
}
