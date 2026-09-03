{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
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
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    };

  # Set default command shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;  

  # User.
  users.users.ted = {
    isNormalUser = true;
    description  = "ted";
    extraGroups  = [ "networkmanager" "wheel" ];
  };

  # Firefox.
  programs.firefox.enable = true;

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Allow flatpacks.
  services.flatpak.enable = true;
  # The following is then required: "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update"

  # Packages. 
  environment.systemPackages = with pkgs; [
  audacious   # MP3 Player
  blanket   # White noise generator
  discord
  git
  gotop
  hyprpaper
  hyprpolkitagent
  kitty
  libnotify   # Create test notifications.
  miktex
  nautilus
  qbittorrent
  rofi
  spotify
  stremio-linux-shell
  unzip
  vscode
  wayle
  wget
  zotero
  ];

  fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono
  ];
  
  system.stateVersion = "26.05"; 

}
