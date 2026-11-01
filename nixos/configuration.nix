{ pkgs, ... }:

{
  imports =
    [
	./hardware-configuration.nix
	./system
    ];

# Flakes.
nix.settings.experimental-features = [ "nix-command" "flakes" ];

nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
]; 

# User.
users.users.ted = {
    isNormalUser = true;
    description  = "ted";
    extraGroups  = [ "networkmanager" "wheel" "audio" "libvirtd" ];
};

# Networking.
networking.hostName = "nixos"; 
networking.networkmanager.enable = true;

# Time Zone.
time.timeZone = "Europe/London";

# Select internationalisation properties.
i18n.defaultLocale = "en_GB.UTF-8";

# Allow Screen Sharing.     
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

# Font.
fonts.packages = with pkgs; [
  jetbrains-mono
    google-fonts
];

system.stateVersion = "26.05"; 

}
