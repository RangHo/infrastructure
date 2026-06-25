let
  vars = import ../variables;
  # Remote access keys.
  yirgacheffe = vars.sshKeys.yirgacheffe;
  # Host public keys.
  breakroom = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVvmCHFOo3YrihRpRzVzLGZBUYWwCkzGna0jxMaiALry15jl6D+hSYb7U7vltazM6wbKx9ErY/N079Up5M77v7mJiI6ETaeMMovK5esHkqJq/DgogmNr23Islj3v2P3soYaTuLrQVAye5U5mXdcAqScJWawThW+obKx5fDWtSSen5qvF7NyRnuqBr1mVGTN3bAc8dA+KLjS25QxmutTioOmPuvTae2/nHVyNMrd/6e2+cByOttzV3nwd7219ZUlVZ0UhbGvb9MgH764Z5Gz86Z61/Cr30nXnCWibZq2jYPSOLYK/VP6io61XqPaqqmaR46d64UwJnv7H9b7dnbu6gaikfb+88+tSckgtJZlrQnpWVjG5k+c5K2VueSXgENwejRGGChqCZCPFxI+xs8XEnDCR26m7ZRGrKdKvYZ2h8jfw6PZwKc4WnX++KibHjDccXM0HTcJsBZIfedFn8XeOFrAyduAb8k9Xt5sHUnbmOdQ9P3zS7fFodk1bY5sOmshpvYRX1axfBR9ucMCLI8peR//FnvsT2avVji0+SmB0c4VWILBoAJ62lfnfbyxux9cgTHVO0xKrWenDgk0Y1u5QUXJrnhV8aGi0tpnDwewjXK+lDAyV5ivSvj3eJxNh+MTG6N9+xw9z3U8qVUMBJeEiIQuyCSxIt49lJ1gmRFY5EVBw=="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEiUX3cYWtafZ3AiggX3aChJO9k+BaF83zy5SKAHf4Kf"
  ];
  clubhouse = [ ];
  millhouse = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCe+JuUFLljcU0OGH68j4v4AFKbkWHFbzsghydmI8SCzBfk9BOcFeCJRMke2Sz2a7G2p1BEaELIGBRQ9o1Ei0SjEi8BHI8m7OVGooljT41m8rNoGrS6HjpOmYTifGkvfQ7LvgbJzbVhugHN5ySM0NNLEsEVDcVgV7rMTqT4T0z/JeXjLphG0wxUS/+WFhgAbDMfQ8l+I99rizUFLK3yD1hvZfqrYEJJjMWCnzID6X5jO7snvHLE/HJ+wpTIKkfGSNQL/x6rTthXWKTCvSQ0dgOzdJpxKYsPLRnkvUi8Rc5Ub5nQYQ7l0k/OwoXyiIjrvZlzD1nxGIXWmhYU8Qh0IasBgXSyzveuuca7G7un4IfDru6YkL6nnsuYk5MV3efoxkIYuXjix4GdyZJ9MuMvAedk16UBAGUDbnljVFhuCGmeOJKHqnHbVKYF82+feOmNbvnzAGgEZvA52pOuRjR62uxVLvEYdx4qMWf7tOQQDxtXdMskno8evUop5B5+XB4QdLtiFKxSPHe6JMmCwqyqAqfnwdOde3s19ejY5RtOFhWAnuC8lBtamPEj/5+eRKOxEB17ppanXAkUXEmedXUmNQjAHkccCHWupxdUQtHeCHB2BQMNzr+OTSlyRAndPLGZ6VMYsH/W2Y9704rctUsu+GMl7tzTi8/09upqdNnEz2m3fw=="
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUP0YtdnHtdfbBRRnJfmtjFna4Wtc9mYl6McyZCIceP"
  ];
  roastery = [ ];
in
{
  # Credential files for Cloudflare Tunnels.
  "breakroom-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ breakroom;
  "clubhouse-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ clubhouse;
  "millhouse-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ millhouse;
  "roastery-cloudflared-credential-file.age".publicKeys = yirgacheffe ++ roastery;
}
