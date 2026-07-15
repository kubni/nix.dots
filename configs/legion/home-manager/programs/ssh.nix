{ config, pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "personal.github.com" = {
        hostname = "github.com";
        user = "git";
        # preferredAuthentications = "publickey";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_personal";
        addKeysToAgent = "confirm";
      };
      "work.github.com" = {
        hostname = "github.com";
        user = "git";
        # preferredAuthentications = "publickey";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_work";
        addKeysToAgent = "confirm";
      };
      "forgejo" = {
        hostname = "192.168.1.112";
        user = "git";
        port = 222;
        # preferredAuthentications = "publickey";
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_forgejo";
        addKeysToAgent = "confirm";
      };
      # "forgejo-ts" = {

      # };
    };
  };
}
