{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    efibootmgr
    git
    gptfdisk
    parted
    vim
  ];

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHgkQFjQ6JaP2QEgtUcDMPgTiq9caOO3/VGfpOO6KLF3"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdHfaBptdCqg4IGlig/pvZCOD1gBGFsY/+f8r43IXGu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKJH943Uup3903/UPIWACBPOJXjkmQo1ROY4zyzFdf5"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtbzeoLkDjJFTWVM0mAf6yjxYEzWdxEFKCKc/1uw3EI"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaKM7BaA1JNQGnJMfRMVylUt1ilvboTPPKgQkx89muw"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.openssh.enable = true;
}
