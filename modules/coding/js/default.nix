{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.typescript-language-server
    nodePackages.prettier
    typescript
    nodejs
    emmet-ls
  ];
}
