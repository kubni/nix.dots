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

   nvf = {
     url = "github:notashelf/nvf";  
     inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, hyprsplit, nvf}: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      vars = {
        location = "$HOME/nix.dots";
	terminal = "kitty";
	editor = "nvim";
      };
    in {
      nixosConfigurations = {
        nikola = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-unstable vars hyprland; };  
          modules = [
            ./modules/configuration.nix
            nvf.nixosModules.default
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
