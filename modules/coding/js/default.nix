{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.typescript-language-server
    typescript
    nodejs
    emmet-ls
  ];
}
