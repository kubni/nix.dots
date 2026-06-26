{pkgs, lib, ...}:
{
  services.mako = {
    enable = true;
    settings = {
        anchor = "top-right";
        default-timeout = 3000;
        border-size = 2;
        icons = true;
        height = 200;
        width = 350;
        layer = "overlay";
        sort = "-time";
        "urgency=low" = {
            border-color = lib.mkForce "#A3BE8C";
        };
        "urgency=normal" = {
            border-color= lib.mkForce "#81A1C1";
        };
        "urgency=high" = {
          border-color= lib.mkForce "#BF616A";
          border-size=4;
          default-timeout=0;
        };
    };
  };
}
