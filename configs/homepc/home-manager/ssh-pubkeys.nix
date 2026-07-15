{ lib, ... }:
let
  # TODO: Adjust this
  hostKeys = (import ../../shared/by-all/ssh-pubkeys.nix).homepc;
in
{
  home.file = lib.mapAttrs' (
    name: id: lib.nameValuePair ".ssh/id_ed25519_${name}.pub" { text = id.key + "\n"; }
  ) hostKeys;
}
