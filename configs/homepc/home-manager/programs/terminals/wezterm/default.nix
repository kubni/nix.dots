{pkgs, lib, ...}:
{
 programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = {}
      config.color_scheme = 'Nord (base16)'
      config.font_size = 14
      return config
    '';
  };
}
