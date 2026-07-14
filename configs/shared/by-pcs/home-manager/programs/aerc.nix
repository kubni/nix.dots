{ config, pkgs, ... }:
{
  programs.aerc = {
    enable = true;

    # TODO
    # extraAccounts = { };

    extraConfig = {
      general.unsafe-accounts-conf = false;

      filters = {
        "text/plain" = "${pkgs.aerc}/libexec/aerc/filters/colorize";
        "text/calendar" = "${pkgs.aerc}/libexec/aerc/filters/calendar";
        "text/html" = "${pkgs.aerc}/libexec/aerc/filters/html";
      };
    };
  };
}
