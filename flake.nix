{
  inputs = {
   # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
   nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
   nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

   home-manager = {
      url = "github:nix-community/home-manager";

      # url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   nvf = {
     url = "github:notashelf/nvf";  
     inputs.nixpkgs.follows = "nixpkgs";
   };
   hyprland = {
      # url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.41.2&submodules=1";
      # url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      
      # url = "git+https://github.com/hyprwm/Hyprland";
      url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.45.0";
   };

   hyprsplit = {
     url = "github:shezdy/hyprsplit?ref=refs/tags/v0.45.0";
     # url = "github:shezdy/hyprsplit";
     inputs.hyprland.follows = "hyprland";
   };

   disko = {
     url = "github:nix-community/disko/latest";
     inputs.nixpkgs.follows = "nixpkgs";
   };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nvf, hyprland, hyprsplit, disko}:
    let
      system = "x86_64-linux";
      
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = true;
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
           specialArgs = { inherit vars pkgs-unstable hyprland; };
           modules = [
             ./modules/configuration.nix
             nvf.nixosModules.default
             home-manager.nixosModules.home-manager {
               home-manager.useGlobalPkgs = true;
               home-manager.useUserPackages = true;
	             home-manager.extraSpecialArgs = { inherit hyprland hyprsplit ;};
               home-manager.users.nikola = {
                 imports = [ ./home-manager ];
               };
             }
             disko.nixosModules.disko
             ./modules/disko.nix
           ];
         };
      };
    };
}
