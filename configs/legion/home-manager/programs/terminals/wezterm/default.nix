{pkgs, lib, ...}:
{
 programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = {}
      config.font_size = 20.0
      return config
    '';
  };
}
