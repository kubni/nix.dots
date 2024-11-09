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
      
      url = "git+https://github.com/hyprwm/Hyprland";
   };

   hyprsplit = {
     # url = "github:shezdy/hyprsplit?ref=refs/tags/v0.41.2";
     url = "github:shezdy/hyprsplit";
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
            {
              disko.devices = {
                disk = {
                  wd-ssd = {
                    # When using disko-install, we will overwrite this value from the commandline
                    device = "/dev/disk/by-id/ata-WDC_WDS500G2B0A-00SM50_21105U805083";
                    type = "disk";
                    content = {
                      type = "gpt";
                      partitions = {
                        ESP = {
                          type = "EF00";
                          size = "550M";
                          content = {
                            type = "filesystem";
                            format = "vfat";
                            mountpoint = "/boot";
                            mountOptions = [ "umask=0077" ];
                          };
                        };
                        zfs = {
                          size = "100%";
                          content = {
                            type = "zfs";
                            pool = "zroot";
                          };
                        };
                      };
                    };
                  };
                  evo-ssd = {
                  type = "disk";
                  device = "/dev/disk/by-id/ata-Samsung_SSD_840_EVO_120GB_S1D5NSCF572384K";
                    content = {
                      type = "gpt";
                      partitions = {
                        zfs = {
                          size = "100%";
                          content = {
                            type = "zfs";
                            pool = "zroot";
                          };
                        };
                      };
                    };
                  };
                };
                zpool = {
                  zroot = {
                      type = "zpool";
                      mode = "mirror";
                      options.cachefile = "none";
                      rootFsOptions = {
                        compression = "zstd";
                        "com.sun:auto-snapshot" = "false";
                      };
                      mountpoint = "/";
                      postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";
                      datasets = {
                        root = {
                          type = "zfs_fs";
                          mountpoint = "/root";
                          options."com.sun:auto-snapshot" = "true";
                        };
                        nix = {
                          type = "zfs_fs";
                          mountpoint = "/nix";
                        };
                        home = {
                          type = "zfs_fs";
                          mountpoint = "/home";
                          options."com.sun:auto-snapshot" = "true";
                        };
                      };
                    };
                  };
                };
              }
           ];
         };
      };
    };
}
