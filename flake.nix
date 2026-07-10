{
  description = "RangHo's homelab infrastructure as code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

      collectTunnelRoutes = configuration: configuration.config.networking.cloudflared.tunnels;

      nixosHosts = {
        breakroom = ./machines/breakroom/configuration.nix;
        clubhouse = ./machines/clubhouse/configuration.nix;
        millhouse = ./machines/millhouse/configuration.nix;
        roastery = ./machines/roastery/configuration.nix;
      };

    in
    {
      nixosConfigurations = {
        coffeebean = mkISO ./machines/coffeebean/configuration.nix;
      }
      // nixpkgs.lib.mapAttrs (_: configuration: mkServer configuration) nixosHosts;

      tunnelRoutes = nixpkgs.lib.mapAttrs (
        hostName: _: collectTunnelRoutes self.nixosConfigurations.${hostName}
      ) nixosHosts;
    };
}
