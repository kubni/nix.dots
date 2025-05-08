{pkgs, lib, ...}:
{
 programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      config.color_scheme = 'Nord (base16)'
    '';
  };
}
