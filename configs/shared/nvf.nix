{ config, lib, pkgs, ... }:

{
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          options = {
            tabstop = 2;
            shiftwidth = 2;
          };

          lsp = {
            enable = true;
            lspSignature.enable = true;
          };

          languages = {
            enableTreesitter = true;
            nix.enable = true;
          };

          visuals = {
            nvim-web-devicons.enable = true;
          };

          tabline = {
            nvimBufferline.enable = true;
          };

          extraPlugins = {
            nord = {
              package = pkgs.vimPlugins.nordic-nvim;
              setup = "vim.cmd[[colorscheme nordic]]";
            };
          };
        };
      };
    };
}
