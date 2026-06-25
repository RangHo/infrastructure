{
  outputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.networking.cloudflared;
in
with lib;
{
  options.networking.cloudflared = {
    uuid = mkOption {
      description = "UUID of the Cloudflare Tunnel";
      type = types.strMatching "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}";
    };
    credentialsFile = mkOption {
      description = "Credentials file of the Cloudlfare Tunnel";
      type = types.path;
    };
    tunnels = mkOption {
      description = "Set of tunnels to create using Terraform";
      type =
        with types;
        attrsOf (submodule {
          options = {
            destination = mkOption {
              description = "Target URL to create tunnel for";
              type = str;
            };
            service = mkOption {
              description = "Local address to contact for the tunnel";
              type = str;
            };
          };
        });
    };
  };
  config = {
    services.cloudflared = {
      enable = true;
      tunnels.${cfg.uuid} = {
        credentialsFile = cfg.credentialsFile;
        default = "http_status:404";
      };
    };
  };
}
