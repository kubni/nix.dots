{
  inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

   home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   nvf = {
     url = "github:notashelf/nvf";  
     inputs.nixpkgs.follows = "nixpkgs";
   };
   hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.51.1";
   };

   hyprsplit = {
     url = "github:shezdy/hyprsplit?ref=refs/tags/v0.51.1";
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

  outputs = { self, nixpkgs, home-manager, nvf, hyprland, hyprsplit, disko, firefox-addons}:
    let
      pkgs = import nixpkgs {
        system="x86_64-linux";
        config.allowUnfree = true;
        config.cudaSupport = true;
      };

      lib = nixpkgs.lib;
      
      vars = {
        location = "$HOME/nix.dots";
        terminal = "wezterm";
	editor = "nvim";
      };

    in {
      nixosConfigurations = {
         homepc = lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = { inherit vars hyprland; };
	    # specialArgs = { inherit vars pkgs-unstable pkgs-stable; };
	    modules = [
		./configs/homepc/configuration.nix
		nvf.nixosModules.default
            	home-manager.nixosModules.home-manager {
		    home-manager.useGlobalPkgs = true;
		    home-manager.useUserPackages = true;
		    home-manager.extraSpecialArgs = { inherit hyprland hyprsplit firefox-addons;};
		    home-manager.users.nikola = {
			imports = [ ./configs/homepc/home-manager ];
		    };
		}
		disko.nixosModules.disko
		./configs/homepc/disko.nix
	    ];
	 };
	 piserver = lib.nixosSystem {
	    system = "aarch64-linux";
	    modules = [
		./configs/piserver/configuration.nix
		nvf.nixosModules.default
	    ];
	 };
	 thinkcentre = lib.nixosSystem {
	    system = "x86_64-linux";
	    modules = [
		./configs/thinkcentre/configuration.nix
		nvf.nixosModules.default
		disko.nixosModules.disko
		./configs/thinkcentre/disko.nix
	    ];
	 };
      };
    };
}
