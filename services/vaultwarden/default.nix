{
  config,
  ...
}:

let
  cfg = config.homelab.vaultwarden;
  domain = "vault.rangho.moe";
  port = 58504;
in
{
  config = {
    age.secrets.vaultwardenSecrets.file = ../../secrets/vaultwarden-secrets.age;

    services.vaultwarden = {
      enable = true;
      config = {
        domain = "https://${domain}";
        signupsAllowed = false;

        rocketAddress = "127.0.0.1";
        rocketPort = port;

        ipHeader = "X-Forwarded-For";
      };
      environmentFile = config.age.secrets.vaultwardenSecrets.path;
    };

    networking.cloudflared.tunnels.vaultwarden = {
      destination = domain;
      service = "http://localhost:${toString port}";
    };
  };
}
