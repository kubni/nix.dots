{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      format = ''
         (bold fg:81a1c1) in $directory $git_branch   
        [└─>](bold fg:81a1c1) $character
      '';
      character = {
	success_symbol = "[λ](bold fg:#81a1c1)";
	error_symbol = "[λ](bold fg:#bf616a)";
      };

      directory = {
      	truncation_length = 1;
      };
    };
  };
}
