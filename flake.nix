{
  description = "A very basic flake";

  # inputs section is the attribute set of all the dependencies of the flake
  # Things from the inputs section are used to build things in the outputs section
  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
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
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nikola = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
 


# The below code is for using the home-manager separately
# If we want to use it that way, we don't need to specify it in `modules` up there
#      hmConfig = {
#         nikola = home-manager.lib.homeManagerConfiguration {
#         inherit system pkgs;
#          username = "nikola";
#          homeDirectory = "/home/nikola";
#          stateVersion = "23.05";
#          configuration = {
#            imports = [
#              ./home.nix
#            ];
#          };
#         };
#      };

    };
}
