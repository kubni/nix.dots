{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./hyprland
  ];


  # Install some commonly found programs that don't need additional configs
  home.packages = with pkgs; [
    neofetch
    zip
    unzip
    ripgrep
    kitty

    vesktop
  ];
}
