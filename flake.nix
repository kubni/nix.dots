{
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      nixos-hardware = {
        url = "github:NixOS/nixos-hardware/master";
      };

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nvf = {
        url = "github:notashelf/nvf";  
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland = {
        url = "git+https://github.com/hyprwm/Hyprland";
      };

      hyprsplit = {
        url = "github:shezdy/hyprsplit";
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

      stylix = {
        url = "github:nix-community/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # claude-desktop.url = "github:aaddrick/claude-desktop-debian";
      claude-desktop.url = "github:aaddrick/claude-desktop-debian/5dd948e96d853ed37636bc0e2368fc2665cd1104";
  };

  outputs = { self, nixpkgs, home-manager, nvf, hyprland, hyprsplit, disko, firefox-addons, mango, stylix, nixos-hardware, claude-desktop}:
    let
      lib = nixpkgs.lib;
      
      vars = {
        location = "$HOME/nix.dots";
        terminal = "wezterm";
	      editor = "nvim";
      };
      overlaysModule = {
        nixpkgs.overlays = [
           (import ./overlays/openldap.nix)
        ];
      };

    in {
      nixosConfigurations = {
        homepc = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit vars hyprland; };
          modules = [
            ./configs/homepc/configuration.nix
            ./configs/homepc/disko.nix
            overlaysModule
            {
              nixpkgs.overlays = [
                claude-desktop.overlays.default 
                (import ./overlays/claude-desktop-python.nix)
              ];
            }
            nixos-hardware.nixosModules.gigabyte-b650
            disko.nixosModules.disko
            nvf.nixosModules.default
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit hyprland hyprsplit firefox-addons;};
              home-manager.backupFileExtension = "backup"; 
              home-manager.users.nikola = {
                imports = [ 
                  ./configs/homepc/home-manager 
                  # TODO: What does this do?
                  (
                    { ... }:
                    {
                      wayland.windowManager.mango = {
                        enable = true;
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
#            specialArgs = { inherit agenix; };
            modules = [
              ./configs/thinkcentre/configuration.nix
#              agenix.nixosModules.default
              nvf.nixosModules.default
              disko.nixosModules.disko
              ./configs/thinkcentre/disko.nix
              overlaysModule
            ];
        };
      };
    };
}
