{
  description = "RangHo's homelab infrastructure as code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermenance = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "";
      inputs.home-manager.follows = "";
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
      mkSystem =
        configuration:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ configuration ];
          specialArgs = { inherit inputs outputs; };
        };
    in
    {
      nixosConfigurations = {
        coffeebean = mkISO ./machines/coffeebean/configuration.nix;
        cafe-lounge = mkSystem ./machines/cafe-lounge/configuration.nix;
      };
    };
}
