{
  config,
  lib,
  pkgs,
  ...
}:
let
  pubkeys = import ../../../by-all/ssh-pubkeys.nix;

  # Flatten every host's identities into "email namespaces=git key" lines.
  # TODO: Adjust this
  toLine = id: ''${id.email} namespaces="git" ${id.key}'';
  allLines = lib.concatMapStringsSep "\n" toLine (
    lib.concatMap lib.attrValues (lib.attrValues pubkeys)
  );

  allowedSigners = pkgs.writeText "git-allowed-signers" (allLines + "\n");
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
