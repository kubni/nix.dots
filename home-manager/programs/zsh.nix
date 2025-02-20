{pkgs, lib, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake .#nikola";
      ls = "lsd";
      df = "duf";
      nightlight = "wlsunset -l 44.8 -L 20.4";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
	"git"
      ];
    };

    # These get added to .zshrc
    initExtra = ''
      source <(fzf --zsh) 
      eval "$(starship init zsh)"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}
