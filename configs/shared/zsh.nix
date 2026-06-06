{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # histSize = 10000;
    # histFile = "$HOME/.zsh_history";
    # setOptions = [
    #   "HIST_IGNORE_ALL_DUPS"
    # ];

    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
      ls = "lsd";
      df = "duf";
    };

    interactiveShellInit = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      eval "$(fzf --zsh)"

      dcud() {
        local name
        name=$(basename "$PWD")
        echo "Building act/$name:latest and composing a daemon..."
        docker build . -t "act/$name:latest" && docker compose up -d
      }
    '';
  };

  # environment.systemPackages = [ pkgs.zsh pkgs.zsh-fzf-tab ];

  programs.starship.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
