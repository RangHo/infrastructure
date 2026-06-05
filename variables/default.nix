let
  sshKeys = import ./ssh-keys.nix;
in
{
  inherit sshKeys;
}
