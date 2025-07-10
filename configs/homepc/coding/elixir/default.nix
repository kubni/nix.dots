{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    elixir-ls
    beam.packages.erlang_27.elixir_1_16
  ];
}
