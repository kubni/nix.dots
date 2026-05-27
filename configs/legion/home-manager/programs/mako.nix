{pkgs, lib, ...}:
{
  services.mako = {
    enable = true;
    settings = {
        anchor = "top-right";
        # backgroundColor = "#D8DEE9";
        borderSize = 2;
        # borderColor = "#81A1C1";
        defaultTimeout = 3000;
        # font = "CommitMono 10";
        height = 200;
        width = 350;
        # textColor = "#5E81AC";
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
