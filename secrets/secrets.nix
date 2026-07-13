let
  nikola = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUQ+2rzvhuAm69XftteVgnnwcaNR7eBO8qE9CwN2IL8";
  legion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhmortMQg25LEATNjpGJ7Gqst7EzIXUhRYON3Pwrw5E root@legion"; # iz Koraka 1
  # homepc = "ssh-ed25519 AAAA...";
  all = [
    nikola
    legion
    # homepc
  ];
in
{
  "gmail-aerc.age".publicKeys = all;
}
