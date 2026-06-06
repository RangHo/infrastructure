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

  networking.hostName = "millhouse";
  partitioning.diskName = "/dev/disk/by-id/ata-N900-512_AA000000000000000002";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
