let
  vars = import ../variables;
  # Remote access keys.
  yirgacheffe = vars.sshKeys.yirgacheffe;
  remotes = yirgacheffe;
  # Host public keys.
  breakroom = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmCHFOo3YrihRpRzVzLGZBUYWwCkzGna0jxMaiALry15jl6D+hSYb7U7vltazM6wbKx9ErY/N079Up5M77v7mJiI6ETaeMMovK5esHkqJq/DgogmNr23Islj3v2P3soYaTuLrQVAye5U5mXdcAqScJWawThW+obKx5fDWtSSen5qvF7NyRnuqBr1mVGTN3bAc8dA+KLjS25QxmutTioOmPuvTae2/nHVyNMrd/6e2+cByOttzV3nwd7219ZUlVZ0UhbGvb9MgH764Z5Gz86Z61/Cr30nXnCWibZq2jYPSOLYK/VP6io61XqPaqqmaR46d64UwJnv7H9b7dnbu6gaikfb+88+tSckgtJZlrQnpWVjG5k+c5K2VueSXgENwejRGGChqCZCPFxI+xs8XEnDCR26m7ZRGrKdKvYZ2h8jfw6PZwKc4WnX++KibHjDccXM0HTcJsBZIfedFn8XeOFrAyduAb8k9Xt5sHUnbmOdQ9P3zS7fFodk1bY5sOmshpvYRX1axfBR9ucMCLI8peR//FnvsT2avVji0+SmB0c4VWILBoAJ62lfnfbyxux9cgTHVO0xKrWenDgk0Y1u5QUXJrnhV8aGi0tpnDwewjXK+lDAyV5ivSvj3eJxNh+MTG6N9+xw9z3U8qVUMBJeEiIQuyCSxIt49lJ1gmRFY5EVBw=="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEiUX3cYWtafZ3AiggX3aChJO9k+BaF83zy5SKAHf4Kf"
  ];
  clubhouse = [ ];
  millhouse = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCYUZZAOjvaMxlpr3SBEex2l69Pvw33W6nSsjMyBgKzlDX1QPvslDwXyJ3ETCVwZUPJYyhq10BjkXcNCXT4wHshgf9gifNzFqtCIPyJjQIrGikNQuK/8tCFQEnoDYOiB1kZl/DActOtzp6d9CsCyJZKuH3DQiN3mx59WkzbxAj92/tyX7OXEVNbniXiiCDuWySkUF0m/rve5cZfmCgUvyyAmnKTajU8YmJu/Qq8ok1/QRELJbPXReG7OSykNLz0HW9y2Q72SPxremfx+cceSdcRO31a2UZlBQAYiSr5SiWmfSS657TfR9OQB9Wqgu76abffPaAH04ArZUm+J7LaexW2ht8zjF4aucXvt8dKqMqfPtMixuGRGYF3YVJ9i54L0NDnJyAShPE7Y2c6RK175C54LdJ1RWlsVN+SQgHJABTFYkFRy6QqKUWnH28MaVxtEsNoMJOurqe+oZyM2zu8qZaFr329eKMV7M3obyfRWUCVIbPRDP13E48/nH/UXrEMTerT0TjhCRN3unNna1FMTWnlnkDla9SaxVwfs3LemCTuqRils9D/vGYND70g+noFmUeLvwmrY1bTwW0T24NG5fF4sGPrNqE5/cf7yf8FksLR3ZDbToBIREdUsd6I7eUrSb1QWZgNT1BPZtAkp3puWE4IqKxD3pElJ5hoPeV8jCCU3Q=="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOgPGGy6bH/9Ha9dLOtml7+PVC94rl//uaN9yzipSrc"
  ];
  roastery = [ ];
  hosts = breakroom ++ clubhouse ++ millhouse ++ roastery;
in
{
  # Credential files for Cloudflare Tunnels.
  "breakroom-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ breakroom;
  "clubhouse-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ clubhouse;
  "millhouse-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ millhouse;
  "roastery-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ roastery;

  "vaultwarden-secrets.age".publicKeys = remotes ++ hosts;
}
