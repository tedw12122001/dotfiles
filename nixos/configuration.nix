{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

# Flakes.
nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
# Packages. 
environment.systemPackages = with pkgs; [
audacious   # MP3 Player
devenv
discord
fzf
git
gotop
grim   # Screenshots
guitarix
hyprpolkitagent
kdePackages.gwenview   # Image viewer
kitty
libnotify   # Create test notifications.
miktex
mpd   # Music daemon for rmpc.
nautilus
neural-amp-modeler-lv2
noctalia-shell
pavucontrol   # Audio device control
qbittorrent
reaper
rmpc
spotify
stremio-linux-shell
superfile
unzip
vscode
wget
whitenoise
zotero
];
  
# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.systemd-boot.configurationLimit = 8;   # Number of generations at boot.
boot.loader.efi.canTouchEfiVariables = true;

# Networking.
networking.hostName = "nixos"; 
networking.networkmanager.enable = true;

# Some nonsense setting I need for vpn.
services.resolved.enable = true;
networking.resolvconf.enable = false;
networking.networkmanager.dns = "systemd-resolved"; 

# Time Zone.
time.timeZone = "Europe/London";

# Select internationalisation properties.
i18n.defaultLocale = "en_GB.UTF-8";

# Enable Hyprland.
programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
};

# Display Manager.
services.displayManager.gdm.enable = true;
  
# Allow Screen Sharing.     
xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

# Keyboard.
services.xserver.xkb.layout  = "gb";
console.keyMap = "uk";
  
# Enable Bluetooth.
hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
};

# Enable power profiles. 
services.power-profiles-daemon.enable = true;

# Allows noctalia to detect battery level.
services.upower.enable = true;

# Printing.
services.printing.enable = true;

# Enable sound with pipewire.
security.rtkit.enable = true;
services.pipewire = { 
    enable             = true;
    alsa.enable        = true;
    alsa.support32Bit  = true; 
    pulse.enable       = true;
    jack.enable        = true;
    wireplumber.enable = true;
    extraConfig.jack."92-force-quantum" = {
        "jack.properties" = {
            "node.lock-quantum"  = true;
            "node.force-quantum" = 64;
        };
    };
};

security.pam.loginLimits = [{ domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }];
environment.variables = let   # Allow DAW plugins
    makePluginPath = format:
        (pkgs.lib.makeSearchPath format [
            "$HOME/.nix-profile/lib"
            "/run/current-system/sw/lib"
            "/etc/profiles/per-user/$USER/lib"
      ]) + ":$HOME/.${format}";
    in {
        LV2_PATH  = makePluginPath "lv2";
        VST3_PATH = makePluginPath "vst3";
        CLAP_PATH = makePluginPath "clap";
    };

# Set default command shell
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;  
  
# User.
users.users.ted = {
    isNormalUser = true;
    description  = "ted";
    extraGroups  = [ "networkmanager" "wheel" "audio" ];
};

# Firefox.
programs.firefox.enable = true;

# Allow Unfree Packages
nixpkgs.config.allowUnfree = true;

# Allow flatpacks.
services.flatpak.enable = true;
# The following is then required: "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update"
  
# Global colour scheme.
stylix = {
    enable = true;
    image = ./Wallpaper3.jpg;
    base16Scheme = {        
        # base00 = "#141a20";
        # base01 = "#1c242c"; 
        # base02 = "#4a5763";
        # base03 = "#75838e";
        # base04 = "#8a97a0";  
        # base05 = "#c8d0d2"; 
        # base06 = "#dde3e3"; 
        # base07 = "#eef1ef";  
        # base08 = "#d72638"; 
        # base09 = "#eb8413"; 
        # base0A = "#f19d1a"; 
        # base0B = "#88b92d"; 
        # base0C = "#1ba595"; 
        # base0D = "#1e8bac"; 
        # base0E = "#be4264"; 
        # base0F = "#c85e0d"; 
            base00 = "#1c1c1c";
            base01 = "#262626";
            base02 = "#333333";
            base03 = "#666666";
            base04 = "#999999";
            base05 = "#d4d4d4";
            base06 = "#e8e8e8";
            base07 = "#f5f5f5";
            base08 = "#ff5f56";
            base09 = "#ff8c1a";
            base0A = "#ffb347";
            base0B = "#9acd32";
            base0C = "#5fd9a0";
            base0D = "#b565d8";
            base0E = "#8a2be2";
            base0F = "#ff6b35";
    };
};

system.stateVersion = "26.05"; 

}
