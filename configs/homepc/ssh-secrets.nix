{ ... }:
{
  age.secrets = {

    ssh-personal = {
      file = ../../secrets/ssh-personal-homepc.age;
      path = "/home/nikola/.ssh/id_ed25519_personal";
      owner = "nikola";
      mode = "0400";
    };

    ssh-work = {
      file = ../../secrets/ssh-work-homepc.age;
      path = "/home/nikola/.ssh/id_ed25519_work";
      owner = "nikola";
      mode = "0400";
    };

    ssh-forgejo = {
      file = ../../secrets/ssh-forgejo-homepc.age;
      path = "/home/nikola/.ssh/id_ed25519_forgejo";
      owner = "nikola";
      mode = "0400";
    };
  };
}
