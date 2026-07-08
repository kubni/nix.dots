{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zsh = {
    interactiveShellInit = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
