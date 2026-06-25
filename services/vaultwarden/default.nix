{
  config,
  ...
}:

let
  cfg = config.homelab.vaultwarden;
in
{
  config = {
    age.secrets.vaultwardenSecrets.file = ../../secrets/vaultwarden-secrets.age;

    services.vaultwarden = {
      enable = true;
      domain = "vault.rangho.moe";
      config = {
        SIGNUPS_ALLOWED = false;
      };
      environmentFile = config.age.secrets.vaultwardenSecrets.path;
    };

    networking.cloudflared.tunnels.vaultwarden = {
      destination = "vault.rangho.moe";
      service = "http://localhost:8000";
    };
  };
}
