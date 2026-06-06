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
      ...
    }@inputs:
    let
      inherit (self) outputs;
      vars = import ./variables;
      mkServer =
        configuration:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./modules/server.nix
            configuration
          ];
          specialArgs = { inherit inputs outputs vars; };
        };
      mkISO =
        configuration:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            configuration
          ];
          specialArgs = { inherit inputs outputs vars; };
        };
    in
    {
      nixosConfigurations = {
        coffeebean = mkISO ./machines/coffeebean/configuration.nix;
        cafe-lounge = mkServer ./machines/cafe-lounge/configuration.nix;
        millhouse = mkServer ./machines/millhouse/configuration.nix;
      };
    };
}
