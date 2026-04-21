{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-GV-256_2280_GD50514111323";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              priority = 1;
              name = "EFI System Partition";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/btrfs";
                subvolumes = {
                  "/@" = {
                    mountpoint = "/";
                  };
                  "/@var" = {
                    mountpoint = "/var";
                    mountOptions = [
                      "compress=zstd"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                    ];
                  };
                  "/@keep" = {
                    mountpoint = "/keep";
                    mountOptions = [
                      "compress=zstd"
                    ];
                  };
                  "/@swap" = {
                    mountpoint = "/swap";
                    swap = {
                      swapfile.size = "1G";
                      swapfile2.size = "1G";
                      swapfile2.path = "rel-path";
                    };
                  };
                };
              };
              swap = {
                swapfile.size = "1G";
                swapfile1.size = "1G";
              };
            };
          };
        };
      };
    };
  };
}
