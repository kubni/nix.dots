{ pkgs, lib, ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;

    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      config.font_size = 20.0

      wezterm.on('format-tab-title', function(tab)
        local pane = tab.active_pane
        local cwd = pane.current_working_dir

        local folder = ""
        if cwd then
          local path = cwd.file_path or tostring(cwd)
          path = path:gsub("^file://", "")
          folder = path:match("([^/\\]+)$") or path
        end

        return { { Text = " " .. folder .. " " } }
      end)

      return config
    '';
  };
}
