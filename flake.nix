{
  description = "RangHo's homelab infrastructure as code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      hello = "world";
    in
    {
      nixosConfigurations = {
        coffeebean = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ./machines/coffeebean/configuration.nix
          ];
        };
      };
    };
}
