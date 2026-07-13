let
  user-legion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUQ+2rzvhuAm69XftteVgnnwcaNR7eBO8qE9CwN2IL8";
  user-homepc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIModAy6YFoGx4zQPe7h08BOHXGdRrfgu7pxiDnOMFvO+";
  legion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOhmortMQg25LEATNjpGJ7Gqst7EzIXUhRYON3Pwrw5E root@legion"; 
  homepc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBximnj8rGBB5t0ZdGoskxbWXYS1fAKnjKE9DN6wCD5+ root@nixos";
  all = [
    user-legion
    user-homepc
    legion
    homepc
  ];
in
{
  "gmail-aerc.age".publicKeys = all;
}
