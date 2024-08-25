{pkgs, ...}: {

  imports = [
    ./browsers.nix
    ./zsh.nix
    ./kitty.nix
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
