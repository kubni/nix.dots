{ ... }:
{
  imports = [
    ./system.nix
    ./packages.nix
    ./stylix.nix
    ./claude-desktop.nix
    ./hyprland.nix
    ./zsh.nix
    ./mail-secrets.nix
    ./emacs
  ];
}
