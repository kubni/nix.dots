{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;

    includes = [
      # Personal
      {
        condition = "hasconfig:remote.*.url:git@personal.github.com:*/**";
        contents = {
          gpg.format = "ssh";
          user = {
            name = "kubni";
            email = "nikola.kuburovic123@gmail.com";
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUQ+2rzvhuAm69XftteVgnnwcaNR7eBO8qE9CwN2IL8 nikola.kuburovic123@gmail.com";
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
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqKlSZdUJp9AqHS/qiBeNeLRNFMihf0dBkzsLfjL6mi nikola.kuburovic@next-halo.com";
          };
        };
      }

      # Forgejo
      {
        condition = "hasconfig:remote.*.url:forgejo:*/**";
        contents = {
          # gpg.format = "ssh";  # TODO: Check whether the Forgejo instance supports this
          user = {
            name = "kubni";
            email = "nikola.kuburovic123@gmail.com";
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGJjZmsLyiiMZvYb6sYkIeUBPgW2TsScXULL2BTmwkgr nikola.kuburovic123@gmail.com";
          };
        };
      }
    ];

  };
}
