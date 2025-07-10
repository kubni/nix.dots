{pkgs, lib, ...}:
{
 programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = {}
      config.color_scheme = 'Nord (base16)'
      return config
    '';
  };
}
