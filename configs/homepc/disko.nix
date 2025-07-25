{lib, ...}:

{
  disko.devices = {
    disk = {
      wd-ssd = {
        # When using disko-install, we will overwrite this value from the commandline
        device = "/dev/disk/by-id/changeme";
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
      device = "/dev/disk/by-id/changeme2";
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
          rootFsOptions = {
            compression = "zstd";
            acltype = "posixacl";
            xattr = "sa";
            "com.sun:auto-snapshot" = "true";
          };
          options.ashift = "12";
          datasets = {
            "root" = {
              type = "zfs_fs";
              mountpoint = "/";
              options = {
                encryption = "aes-256-gcm";
                keyformat = "passphrase";
                keylocation = "prompt";
              };
            };
            "root/nix" = {
              type = "zfs_fs";
              mountpoint = "/nix";
            };
            "root/home" = {
              type = "zfs_fs";
              mountpoint = "/home";
            };
          };
        };
      };
    };
}
