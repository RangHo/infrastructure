{
  config,
  vars,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/cloudflared.nix
    ../../modules/employee.nix
    ../../modules/impermanence.nix
    ../../modules/partition.nix
  ];

  age.secrets.cloudflaredCredentialsFile.file = ../../secrets/clubhouse-cloudflared-credential-file.age;

  networking = {
    hostName = "clubhouse";
    cloudflared = {
      uuid = "66f8cfd2-659c-4646-8e26-6612253baeba";
      credentialsFile = config.age.secrets.cloudflaredCredentialsFile.path;
    };
  };
  partitioning.diskName = "/dev/disk/by-id/nvme-AirDisk_256GB_SSD_PM8030R000797P1109";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
