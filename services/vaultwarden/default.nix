{
  config,
  ...
}:

let
  cfg = config.homelab.vaultwarden;
in
{
  config = {
    services.vaultwarden = {
      enable = true;
    };
    networking.cloudflared.tunnels.vaultwarden = {
      destination = "vault.rangho.moe";
      service = "http://localhost:8080";
    };
  };
}
