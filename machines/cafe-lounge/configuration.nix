{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  networking.hostName = "cafe-lounge";

  # First version of NixOS installed on this machine. Don't change this after the initial install!
  system.stateVersion = "26.05";

}
