{ ... }:

{
  programs.zsh = {
    shellAliases = {
      nightlight = "wlsunset -l 44.8 -L 20.4";
    };

    interactiveShellInit = ''
      wcp() {
        wl-copy < "$1"
      }
    '';
  };
}
