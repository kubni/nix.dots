{
  inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   nixpkgs-unstable = {
     url = "github:/NixOS/nixpkgs/nixpkgs-unstable";
   };
   home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
   split-monitor-workspaces = {
     #url = "github:shezdy/hyprsplit";
     url = "github:Duckonaut/split-monitor-workspaces";
     inputs.hyprland.follows = "hyprland";
   };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, split-monitor-workspaces}: #TODO: put the plugin here
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
          specialArgs = { inherit nixpkgs-unstable hyprland split-monitor-workspaces; };  # TODO: Add the plugin here, maybe it will fix the failed to load the following plugin error?
          modules = [ 
            ./modules/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
	      home-manager.extraSpecialArgs = { inherit hyprland split-monitor-workspaces; }; #TODO: Inherit the plugin
              home-manager.users.nikola = {
                imports = [ ./home-manager ]; 
              };
            }
          ];
        };
      };
    };
}
