{lib, ...}:

{
  disko.devices = {
    disk = {
      wd-sn770 = {
        # When using disko-install, we will overwrite this value from the commandline
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN770_2TB_24496D800089";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
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
            "root/var" = {
              type = "zfs_fs";
              mountpoint = "/var";
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
