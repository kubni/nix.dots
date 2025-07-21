{pkgs, lib, ...}:



{
  # imports = [
  #   ./zsh-plugins.nix
  # ];


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake .#homepc";
      ls = "lsd";
      df = "duf";
      nightlight = "wlsunset -l 44.8 -L 20.4";
    };

    plugins = [
        {
            name = "fzf-tab";
            src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
    ];

	#    oh-my-zsh = {
	#      enable = true;
	#      plugins = [
	# "git"
	#      ];
	#    };

    # These get added to .zshrc
    initContent = ''
      source <(fzf --zsh) 
      eval "$(starship init zsh)"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

}
