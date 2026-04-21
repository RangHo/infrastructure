{
  description = "RangHo's homelab infrastructure as code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      srvos,
      impermanence,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      mkServer =
        configuration:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            srvos.nixosModules.server
            srvos.nixosModules.mixins-mdns
            srvos.nixosModules.mixins-systemd-boot
            srvos.nixosModules.mixins-terminfo
            configuration
          ];
          specialArgs = { inherit inputs outputs; };
        };
      mkISO =
        configuration:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            configuration
          ];
          specialArgs = { inherit inputs outputs; };
        };
    in
    {
      nixosConfigurations = {
        coffeebean = mkISO ./machines/coffeebean/configuration.nix;
        cafe-lounge = mkServer ./machines/cafe-lounge/configuration.nix;
      };
    };
}
