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
      url = "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.52.0";
   };

   hyprsplit = {
     url = "github:shezdy/hyprsplit?ref=refs/tags/v0.52.0";
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
   
   mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
   };

  };

  outputs = { self, nixpkgs, home-manager, nvf, hyprland, hyprsplit, disko, firefox-addons, mango}:
    let
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
          modules = [
            ./configs/homepc/configuration.nix
            ./configs/homepc/disko.nix
            disko.nixosModules.disko
            nvf.nixosModules.default
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit hyprland hyprsplit firefox-addons;};
              home-manager.users.nikola = {
                imports = [ 
                  ./configs/homepc/home-manager 
                  # TODO: What does this do?
                  (
                    { ... }:
                    {
                      wayland.windowManager.mango = {
                        enable = true;
                        settings = ''
                          # see config.conf
                        '';
                        autostart_sh = ''
                          # see autostart.sh
                          # Note: here no need to add shebang
                        '';
                      };
                    }
                  )
                ] ++ [mango.hmModules.mango];
              };
            }
            
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
