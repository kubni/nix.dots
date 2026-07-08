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
      # url = "git+https://github.com/hyprwm/Hyprland";
      url = "git+https://github.com/hyprwm/Hyprland?rev=a11a718a45c6436abf3d6116618ebb6ae3735148";
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
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # claude-desktop.url = "github:aaddrick/claude-desktop-debian";
    claude-desktop.url = "github:aaddrick/claude-desktop-debian/5dd948e96d853ed37636bc0e2368fc2665cd1104";

    # jiratui.url = "github:whyisdifficult/jiratui";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      hyprland,
      hyprsplit,
      disko,
      firefox-addons,
      mango,
      stylix,
      nixos-hardware,
      claude-desktop,
      # jiratui,
    }:
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

      # Helper function that helps with deduplication of the flake.nix file.
      mkPcHost =
        {
          hostname,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit vars hyprland; };
          modules = [
            ./configs/${hostname}/configuration.nix
            # ./configs/${hostname}/disko.nix
            overlaysModule
            {
              nixpkgs.overlays = [
                claude-desktop.overlays.default
                (import ./overlays/claude-desktop-python.nix)
              ];
            }
            nvf.nixosModules.default
            stylix.nixosModules.stylix

            mango.nixosModules.mango

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit hyprland hyprsplit firefox-addons; };
              home-manager.backupFileExtension = "backup";
              home-manager.users.nikola = {
                imports = [
                  ./configs/${hostname}/home-manager
                  mango.hmModules.mango
                ];
              };
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        homepc = mkPcHost {
          hostname = "homepc";
          extraModules = [
            ./configs/homepc/disko.nix
            disko.nixosModules.disko
            nixos-hardware.nixosModules.gigabyte-b650
          ];
        };
        legion = mkPcHost {
          hostname = "legion";
          extraModules = [ ];
        };
        thinkcentre = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configs/thinkcentre/configuration.nix
            nvf.nixosModules.default
            disko.nixosModules.disko
            ./configs/thinkcentre/disko.nix
            overlaysModule
          ];
        };
      };

    };
}

# TODO:
# 1) Declarative ssh
