{pkgs, ...}:
{
  imports = [
    ./go
    ./js
  ];

  environment.systemPackages = with pkgs; [
    pyright
  ];
}
