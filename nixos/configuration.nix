{ config, pkgs, ... }:

let
  oldPkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/27c5b97f944ababecc55efa9895e928c9df5cc47.tar.gz";
    sha256 = "14hbncgd3zrgcmvn8pn5hrh4w7gw3k6404hnwbjvs5qrl3y6rhlw";
  }) {
    system = pkgs.system;
  };
in

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
bitwarden-desktop
discord
fuzzel
fzf
git
gnome-boxes
gotop
gparted
grim   # Screenshots
guitarix
hyprpolkitagent
impala
kdePackages.gwenview   # Image viewer
kitty
libreoffice
localsend
mpd   # Music daemon for rmpc.
mpv
noctalia
nautilus
neovim
neural-amp-modeler-lv2
nil   # Nix language assistant
pavucontrol   # Audio device control
qbittorrent
qutebrowser
ranger
reaper
rmpc
spotify
stremio-linux-shell
termpdfpy
texliveFull
thunderbird
tmux
translate-shell   # cli translation
unzip
vlc
vscode
waybar
wget
whitenoise
yt-dlp
zathura   # pdf viewer 
#zotero
];

nixpkgs.overlays = [
  (final: prev: {
      qutebrowser = oldPkgs.qutebrowser;
  })
];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.systemd-boot.configurationLimit = 8;   # Number of generations at boot.
boot.loader.efi.canTouchEfiVariables = true;

# Networking.
networking.hostName = "nixos"; 
networking.networkmanager.enable = true;

# Time Zone.
time.timeZone = "Europe/London";

# Select internationalisation properties.
i18n.defaultLocale = "en_GB.UTF-8";

# Power Management.
services.thermald.enable = true;
services.power-profiles-daemon.enable = false;
services.tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
};

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

# Allow usb stick.
services.udisks2.enable = true;

# Allow phone in file explorer.
services.gvfs.enable = true;

# Keyboard.
services.xserver.xkb.layout  = "gb";
console.keyMap = "uk";
  
# Keyboard remapping tool
services.keyd = {
  enable = true;
  keyboards = {
    default = {
      ids = [ "0001:0001:093d12dc" ];
      settings = {
        main = {
          capslock = "layer(esc)";
          esc = "layer(capslock)";
        };
      };
    };
  };
};

# Font.
services.kmscon = {
  enable = true;
  config = {
    font-name = "JetBrains Mono";
  };
};
fonts.packages = with pkgs; [
  jetbrains-mono
];

# Enable Bluetooth.
hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
};

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
    extraGroups  = [ "networkmanager" "wheel" "audio" "libvirtd" ];
};

# Firefox.
programs.firefox.enable = true;

# Allow Unfree Packages
nixpkgs.config.allowUnfree = true;

# Allow flatpacks.
services.flatpak.enable = true;
# The following is then required: "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update"

# Virtual Machine stuff.
virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
  };
};

# Global colour scheme.
stylix = {
    enable = true;
    targets.kmscon.enable = false;
### Eldritch Theme ###            
    image = ./Wallpaper4.jpg;
    base16Scheme = {        
            base00 = "#212337";
            base01 = "#323449";
            base02 = "#3b4261";
            base03 = "#7081d0";
            base04 = "#a1abe0";
            base05 = "#ebfafa";
            base06 = "#f0f2f4";
            base07 = "#ffffff";
            base08 = "#f265b5";
            base09 = "#a48cf2";
            base0A = "#39ddfd";
            base0B = "#37f499";
            base0C = "#04d1f9";
            base0D = "#f1fc79";
            base0E = "#f7c67f";
            base0F = "#f16c75";
      };
};

system.stateVersion = "26.05"; 

}
