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
	   url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.43.0&submodules=1";
   };

   # hyprsplit = {
   #   url = "github:shezdy/hyprsplit?ref=refs/tags/v0.43.0";
   #   inputs.hyprland.follows = "hyprland";
   # };

   nvf = {
     url = "github:notashelf/nvf";  
     inputs.nixpkgs.follows = "nixpkgs";
   };
  };

  # outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, nvf}: # TODO: hyprsplit
  outputs = inputs:
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

      pcSetup = import ./hosts/pc;
      legionSetup = import ./hosts/legion;

    in {
      nixosConfigurations = {
        # nikola = lib.nixosSystem {
        #   inherit system;
        #   specialArgs = { inherit pkgs-unstable vars hyprland; };
        #   modules = [
        #     ./modules/configuration.nix
        #     nvf.nixosModules.default
        #     home-manager.nixosModules.home-manager {
        #       home-manager.useGlobalPkgs = true;
        #       home-manager.useUserPackages = true;
	      #       home-manager.extraSpecialArgs = { inherit pkgs-unstable hyprland;}; # TODO: Hyprsplit
        #       home-manager.users.nikola = {
        #         imports = [ ./home-manager ];
        #       };
        #     }
        #   ];
        # };

        pc = pcSetup inputs;



      };
    };
}
