{
  pkgs,
  vars,
  ...
}:

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
    openssh.authorizedKeys.keys = vars.sshKeys.github;
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.openssh.enable = true;
}
