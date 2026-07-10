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

  age.secrets.cloudflaredCredentialsFile.file = ../../secrets/roastery-cloudflared-credential-file.age;

  networking = {
    hostName = "roastery";
    cloudflared = {
      uuid = "f494fa60-52b4-4142-9154-91c7262258a6";
      credentialsFile = config.age.secrets.cloudflaredCredentialsFile.path;
    };
  };
  partitioning.diskName = "/dev/disk/by-id/ata-N900-256_AA000000000000000918";

  homelab = {
    sshAuthorizedKeys = vars.sshKeys.yirgacheffe;
  };

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";
}
