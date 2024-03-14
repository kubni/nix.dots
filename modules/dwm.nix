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

    windowManager.dwm =  {
      enable = true;

      package = pkgs.dwm.overrideAttrs(oldAttrs: {
        src = pkgs.fetchgit {
          url = "https://github.com/kubni/voidwm";
          hash = "sha256-a6u30/6fy7xsmib2ECr5nQFv2P8VmpbyysFbv+G/IlY=";
        };

        prePatch = oldAttrs.prePatch + ''
          sed -i "s@/usr/share@$out/share@" Makefile
        '';
      });
    };
  };
}
