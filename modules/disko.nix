{ config, lib, pkgs, disko, ... }:

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
