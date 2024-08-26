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
      cp = "cpz"; # !
      rm = "rmz"; # !
      cat = "bat";


    };

    oh-my-zsh = {
      enable = true;
      plugins = [
	"git"
      ];
      theme = "lambda";
    };

    # These get added to .zshrc
    initExtra = ''
      source <(fzf --zsh) 
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd j"
    ];
  };

}
