{
  inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   nixpkgs-unstable = {
     url = "github:/NixOS/nixpkgs/nixpkgs-unstable";
   };
   home-manager = {
      #url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   hyprland ={
	url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.41.2&submodules=1";
   };
   hyprsplit = {
     url = "github:shezdy/hyprsplit?ref=refs/tags/v0.41.2";
     inputs.hyprland.follows = "hyprland";
   };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, hyprsplit}: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nikola = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-unstable hyprland; };  
          modules = [ 
            ./modules/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
	      home-manager.extraSpecialArgs = { inherit pkgs-unstable hyprland hyprsplit; };
              home-manager.users.nikola = {
                imports = [ ./home-manager ]; 
              };
            }
          ];
        };
      };
    };
}
