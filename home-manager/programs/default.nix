{pkgs, ...}: {

  imports = [
    ./browsers.nix
  ];


  # Install some commonly found programs that don't need additional configs
  home.packages = with pkgs; [
    neofetch
    zip
    unzip
    ripgrep
    kitty

    (dwmblocks.overrideAttrs(oldAttrs: {
      src = pkgs.fetchgit {
        url = "https://github.com/jitessh/dwmblocks";
        hash = "sha256-nS8BHON4FbbHXbsejc741Rw+uZXntlT0NsR4H8PvOco=";
      };
    }))
  ];
}
