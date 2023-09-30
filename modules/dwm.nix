{ pkgs, ... }: {
  
  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };

    displayManager.startx = {
      enable = true;
    };


    # Enable dwm
    windowManager.dwm =  {
      enable = true;
    };
  };

}
