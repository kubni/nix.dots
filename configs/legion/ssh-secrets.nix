{ ... }:
{
  age.secrets = {
    ssh-personal = {
      file  = ../../secrets/ssh-personal-legion.age;
      path  = "/home/nikola/.ssh/id_ed25519_personal";
      owner = "nikola";
      mode  = "0400";           # ssh rejects group/other-readable private keys
    };
    ssh-work = {
      file  = ../../secrets/ssh-work-legion.age;
      path  = "/home/nikola/.ssh/id_ed25519_work";
      owner = "nikola";
      mode  = "0400";
    };
    ssh-forgejo = {
      file  = ../../secrets/ssh-forgejo-legion.age;
      path  = "/home/nikola/.ssh/id_ed25519_forgejo";
      owner = "nikola";
      mode  = "0400";
    };
  };
}
