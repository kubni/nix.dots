{pkgs, ...}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
 #     articicestudio.nord
      ms-python.python 
    ];
  };
}
