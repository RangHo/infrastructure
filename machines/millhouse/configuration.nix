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
    ../../services/vaultwarden
  ];

  age.secrets.cloudflaredCredentialsFile.file = ../../secrets/millhouse-cloudflared-credential-file.age;

  networking = {
    hostName = "millhouse";
    cloudflared = {
      uuid = "d1b41db0-3b9c-4de7-bd7b-5feca9722f27";
      credentialsFile = config.age.secrets.cloudflaredCredentialsFile.path;
    };
  };
  partitioning.diskName = "/dev/disk/by-id/ata-N900-512_AA000000000000000002";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
