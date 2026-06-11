{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.atkinson-hyperlegible;
        name = "Atkinson Hyperlegible";
      };
      monospace = {
        package = pkgs.atkinson-hyperlegible-mono;
        name = "Atkinson Hyperlegible Mono";
      };
    };
  };
}
