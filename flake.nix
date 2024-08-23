{
  inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
   hyprsplit = {
     url = "github:shezdy/hyprsplit";
     inputs.hyprland.follows = "hyprland";
   };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, hyprsplit}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nikola = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hyprland; };
          modules = [ 
            ./modules/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
	      home-manager.extraSpecialArgs = { inherit hyprsplit; };
              home-manager.users.nikola = {
                imports = [ ./home-manager ]; 
              };
            }
          ];
        };
      };
    };
}
