{
  # based on
  # https://github.com/nix-community/disko/blob/master/example/btrfs-subvolumes.nix
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "4G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "fat32";  # "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = [ "-L" "esp" ];
              };
            };
            swap = {
              size = "192G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
                extraArgs = [ "-L" "swap" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-L" "nixos" "-f" ]; # Override existing partition
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = [ "subvol=root" ];
                  };
                  "home" = {
                    mountOptions = [ "subvol=home" "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  # Parent is not mounted so the mountpoint must be set
                  "nix" = {
                    mountOptions = [
                      "subvol=nix"
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                };
              };
            };


          };
        };
      };
    };
  };
}
