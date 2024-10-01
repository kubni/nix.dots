{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    python312
    (python3.withPackages (python-pkgs: [
      python-pkgs.transformers
      python-pkgs.langchain
      python-pkgs.langchain-openai
      python-pkgs.pyflakes
      python-pkgs.pip
    ]))

    pyright
    black
  ];
}
