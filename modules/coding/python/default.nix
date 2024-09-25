{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    (python3.withPackages (python-pkgs: [
      python-pkgs.transformers
      python-pkgs.langchain
      python-pkgs.langchain-openai

      python-pkgs.pyflakes
    ]))

    pyright
    black
  ];
}
