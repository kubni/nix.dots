{
  inputs.hyprland.url = "github:hyprwm/Hyprland";
  # ...

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };  # this is the important part
      modules = [
        ../../configuration.nix 
      ];
    };
  }
}
