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

  age.secrets.cloudflaredCredentialsFile.file = ../../secrets/breakroom-cloudflared-credential-file.age;

  networking = {
    hostName = "breakroom";
    cloudflared = {
      uuid = "31496a40-ea0d-4efc-8d28-d59397710888";
      credentialsFile = config.age.secrets.cloudflaredCredentialsFile.path;
    };
  };
  partitioning.diskName = "/dev/disk/by-id/nvme-GV-256_2280_GD50514111323";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
