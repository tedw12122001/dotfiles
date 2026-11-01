{ ... }:

{
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 8;   # Number of generations at boot.
    boot.loader.efi.canTouchEfiVariables = true;

    services.displayManager.gdm.enable = true;
}
