{ ... }:

{
    services.udisks2.enable = true;   # Allow usb stick

    services.xserver.xkb.layout  = "gb";
    console.keyMap = "uk";

    hardware.bluetooth = {
	enable      = true;
	powerOnBoot = true;
    };

    services.printing.enable = true;
}

