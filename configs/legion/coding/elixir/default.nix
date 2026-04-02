{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    elixir-ls
    beam.packages.erlang_27.elixir_1_16
  ];
}
