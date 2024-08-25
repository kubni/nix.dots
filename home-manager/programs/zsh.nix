{pkgs, lib, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion= true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake .#nikola";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
	"git"
	"autojump"
      ];
      theme = "lambda";
    };
  };

  programs.autojump = {
    enable = true;
  };
}
