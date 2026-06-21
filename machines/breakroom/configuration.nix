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

  networking.hostName = "breakroom";
  partitioning.diskName = "/dev/disk/by-id/nvme-GV-256_2280_GD50514111323";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
