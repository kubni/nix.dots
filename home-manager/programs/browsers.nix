{ pkgs, ... }: {
  programs = {
    librewolf = {
      enable = true;
    };
    chromium = {
      enable = true;
    };
  };

}
