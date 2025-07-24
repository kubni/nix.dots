{ pkgs }: 

{

  environment = {
    systemPackages = with pkgs; [
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
    ];
    variables.EDITOR = "nvim";
    pathsToLink = [ "/share/zsh" ];
  };
}
