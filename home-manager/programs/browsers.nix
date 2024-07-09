{ pkgs, ... }: {
  programs = {
    librewolf = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
  };
}
