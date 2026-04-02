{pkgs, lib, ...}:

{
  programs.kitty = { 
    enable = true;
    settings = {
      font_family = "CommitMono Regular";
      bold_font  = "CommitMono Bold";
      italic_font = "CommitMono Italic";
      bold_italic_font = "CommitMono Bold Italic";
      font_size = "22.0";

# Base colors
      foreground = "#4A4543";
      background = "#F7F7F7";
      selection_foreground = "#4A4543";
      selection_background = "#D6D5D4";
      url_color = "#01A0E4";

      # black
      color0  = "#090300";
      color8  = "#5C5855";

      # red
      color1  = "#DB2D20";
      color9  = "#E74B3B";

      # green
      color2  = "#01A252";
      color10 = "#3A9D23";

      # yellow
      color3  = "#FDED02";
      color11 = "#FDED02";

      # blue
      color4  = "#01A0E4";
      color12 = "#807D7C";

      # magenta
      color5  = "#A16A94";
      color13 = "#D6D5D4";

      # cyan
      color6  = "#B5E4F4";
      color14 = "#CDAB53";

      # white
      color7  = "#A5A2A2";
      color15 = "#F7F7F7";
    };
  };
}
