{ config, pkgs, ... }:
{
  programs.aerc = {
    enable = true;

    # TODO
    # extraAccounts = { };

    extraConfig = {
      general.unsafe-accounts-conf = false;
    };
  };
}
