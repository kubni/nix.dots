{pkgs, ...}:
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#D8DEE9";
    borderSize = 2;
    borderColor = "#81A1C1";
    defaultTimeout = 3000;
    font = "CommitMono 10";
    height = 200;
    width = 350;
    textColor = "#5E81AC";
    layer = "overlay";
    sort = "-time";
    extraConfig = ''
[urgency=low]
border-color=#A3BE8C
[urgency=normal]
border-color=#81A1C1
[urgency=high]
border-color=#BF616A
border-size=4
default-timeout=0'';
  };
}
