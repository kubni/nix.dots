{
  inputs = {
   # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
   nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
   nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
   nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

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
      url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.49.0";
   };

   hyprsplit = {
     url = "github:shezdy/hyprsplit?ref=refs/tags/v0.49.0";
     inputs.hyprland.follows = "hyprland";
   };

   disko = {
     url = "github:nix-community/disko/latest";
     inputs.nixpkgs.follows = "nixpkgs";
   };

   firefox-addons = {
     url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
     inputs.nixpkgs.follows = "nixpkgs";
   };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, nvf, hyprland, hyprsplit, disko, firefox-addons}:
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

      pkgs-stable = import nixpkgs-stable {
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
           specialArgs = { inherit vars pkgs-unstable pkgs-stable hyprland; };
           modules = [
             ./modules/configuration.nix
             nvf.nixosModules.default
             home-manager.nixosModules.home-manager {
               home-manager.useGlobalPkgs = true;
               home-manager.useUserPackages = true;
	             home-manager.extraSpecialArgs = { inherit hyprland hyprsplit firefox-addons;};
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
