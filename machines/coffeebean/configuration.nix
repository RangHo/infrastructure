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
        openssh.authorizedKeys.keys = [];
    };

    security.sudo.wheelNeedsPassword = false;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.openssh.enable = true;
}
