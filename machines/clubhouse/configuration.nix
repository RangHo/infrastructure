{
  vars,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/employee.nix
    ../../modules/impermanence.nix
    ../../modules/partition.nix
  ];

  networking.hostName = "clubhouse";
  partitioning.diskName = "/dev/disk/by-id/nvme-AirDisk_256GB_SSD_PM8030R000797P1109";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
