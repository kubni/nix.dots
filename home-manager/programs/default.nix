{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./hyprland.nix
  ];


  # Install some commonly found programs that don't need additional configs
  home.packages = with pkgs; [
    neofetch
    zip
    unzip
    ripgrep
    kitty
  ];
}
