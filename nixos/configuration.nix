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
  blanket   # White noise generator
  discord
  git
  gotop
  grim   # Screenshots
  hyprpolkitagent
  kdePackages.gwenview   # Image viewer
  kitty
  libnotify   # Create test notifications.
  micro
  miktex
  nautilus
  neural-amp-modeler-lv2
  noctalia-shell
  qbittorrent
  reaper
  spotify
  stremio-linux-shell
  unzip
  vscode
  wget
  yazi
  zotero
  ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
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
  # services.desktopManager.gnome.enable = true;
  
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

  # Allows wayle to detect battery level.
  services.upower.enable = true;

  # Printing.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for yabridge/wine VST bridging
    jack.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire."92-low-latency" = {
   	 "context.properties" = {
	     "default.clock.rate" = 48000;       # Fixed rate avoids resampling latency
	     "default.clock.quantum" = 128;      # ~5ms latency at 48kHz
	     "default.clock.min-quantum" = 32;   # Allows top-tier interfaces to achieve ~1.5ms
	     "default.clock.max-quantum" = 512;
	   };
  	};
 };
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }];
  
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
    base16Scheme = {
      base00 = "1d2021";
      base01 = "383c3e"; 
      base02 = "53585b";
      base03 = "6f7579"; 
      base04 = "cdcdcd";
      base05 = "d5d5d5"; 
      base06 = "dddddd"; 
      base07 = "e5e5e5";
      base08 = "d72638";
      base09 = "eb8413";
      base0A = "f19d1a";
      base0B = "88b92d";
      base0C = "1ba595";
      base0D = "1e8bac";
      base0E = "be4264";
      base0F = "c85e0d";
    };
  };

  system.stateVersion = "26.05"; 

}
