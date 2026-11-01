{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
	audacious   # MP3 Player
	bitwarden-desktop
	brave-origin
	cosmic-ext-calculator
	discord
	fzf
	git
	gotop
	gparted
	guitarix
	hyprpolkitagent
	kdePackages.gwenview   # Image viewer
	kitty
	libreoffice
	localsend
	mpd   # Music daemon for rmpc.
	mpv
	noctalia
	nautilus
	neural-amp-modeler-lv2
	pavucontrol   # Audio device control
	qbittorrent
	ranger
	reaper
	rmpc
	spotify
	stremio-linux-shell
	texliveFull
	tmux
	translate-shell   # cli translation
	vlc
	wget
	whitenoise
	yt-dlp
	zathura   # pdf viewer 
	zotero
    ];

    programs.hyprland = {
	enable          = true;
	xwayland.enable = true;
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    nixpkgs.config.allowUnfree = true;

services.flatpak.enable = true;
# The following is then required: "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update"

}
