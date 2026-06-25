{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.srvos.nixosModules.server
    inputs.srvos.nixosModules.mixins-mdns
    inputs.srvos.nixosModules.mixins-systemd-boot
    inputs.srvos.nixosModules.mixins-terminfo
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:RangHo/infrastructure";
    flags = [ "--print-build-logs" ];
    dates = "daily";
    randomizedDelaySec = "30min";
    allowReboot = true;
  };
}
