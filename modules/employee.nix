{
  lib,
  config,
  ...
}:

with lib;
let
  sshAuthorizedKeys = config.homelab.sshAuthorizedKeys;
in
{
  options.homelab.sshAuthorizedKeys = mkOption {
    type = types.listOf types.str;
  };

  config.users.users.barista = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = sshAuthorizedKeys;
  };
}
