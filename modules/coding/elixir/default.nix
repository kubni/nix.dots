{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    elixir
    elixir-ls
    erlang
  ];
}
