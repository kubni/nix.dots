{
  config,
  lib,
  pkgs,
  ...
}:
let
  allowedSigners = pkgs.writeText "git-allowed-signers" ''
    nikola.kuburovic123@gmail.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUQ+2rzvhuAm69XftteVgnnwcaNR7eBO8qE9CwN2IL8
    nikola.kuburovic123@gmail.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJjZmsLyiiMZvYb6sYkIeUBPgW2TsScXULL2BTmwkgr
    nikola.kuburovic@next-halo.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqKlSZdUJp9AqHS/qiBeNeLRNFMihf0dBkzsLfjL6mi
  '';
in
{
  xdg.configFile."git/allowed_signers".source = allowedSigners;

  programs.git = {
    enable = true;

    # The allowed signers file will allow us to verify commits signed via ssh keys
    settings.gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";

    includes = [
      # Personal
      {
        condition = "hasconfig:remote.*.url:git@personal.github.com:*/**";
        contents = {
          gpg.format = "ssh";
          user = {
            name = "kubni";
            email = "nikola.kuburovic123@gmail.com";
            signingKey = "~/.ssh/id_ed25519_personal.pub";
          };
        };
      }

      # Work
      {
        condition = "hasconfig:remote.*.url:git@work.github.com:*/**";
        contents = {
          gpg.format = "ssh";
          user = {
            name = "nikola-next-halo";
            email = "nikola.kuburovic@next-halo.com";
            signingKey = "~/.ssh/id_ed25519_work.pub";
          };
        };
      }

      # Forgejo
      {
        condition = "hasconfig:remote.*.url:forgejo:*/**";
        contents = {
          gpg.format = "ssh"; # TODO: Check whether the Forgejo instance supports this
          user = {
            name = "kubni";
            email = "nikola.kuburovic123@gmail.com";
            signingKey = "~/.ssh/id_ed25519_forgejo.pub";
          };
        };
      }
    ];

  };
}
