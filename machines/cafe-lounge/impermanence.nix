{
  lib,
  pkgs,
  ...
}:

{
  boot.initrd.systemd = {
    services.impermanence-btrfs-rolling-root = {
      description = "Archiving existing BTRFS root subvolume and creating a fresh one";
      serviceConfig = {
        Type = "oneshot";
      };

      unitConfig.DefaultDependencies = false;
      requires = [ "initrd-root-device.target" ]; # wait for the root device to appear
      requiredBy = [ "initrd.target" ]; # run before the initrd is finished and the system continues booting
      before = [ "sysroot.mount" ]; # run before the root filesystem is mounted
      after = [
        "initrd-root-device.target" # wait for the root device to appear
        "local-fs-pre.target" # run after all local filesystems are mounted, which includes the resume device for hibernation
      ];

      script = ''
        mkdir /btrfs_tmp
        mount /dev/disk/by-partlabel/disk-main-root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/backups
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/backups/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/backups/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };
    extraBin = {
      "btrfs" = "${pkgs.btrfs-progs}/bin/btrfs";
      "date" = "${pkgs.coreutils}/bin/date";
      "find" = "${pkgs.findutils}/bin/find";
      "mkdir" = "${pkgs.coreutils}/bin/mkdir";
      "mv" = "${pkgs.coreutils}/bin/mv";
      "stat" = "${pkgs.coreutils}/bin/stat";
    };
  };
  environment.persistence."/keep" = {
    hideMounts = true;
    directories = [
      "/etc"
      "/srv"
      "/root"
      "/home"
    ];
  };
}
