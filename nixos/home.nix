
{ pkgs, config,  ... }: 

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  symlink  = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home = {
    username      = "ted";
    homeDirectory = "/home/ted";
    stateVersion  = "26.05";
  };

  programs.home-manager.enable = true;
  
  xdg.configFile = {
    "hypr".source   = symlink "${dotfiles}/hypr";
    "rofi".source   = symlink "${dotfiles}/rofi";
    # "kitty".source  = symlink "${dotfiles}/kitty";
    "wayle".source  = symlink "${dotfiles}/wayle";
  };

  home.sessionVariables = {};

  ##############
  ### Cursor ###
  ##############
  home.pointerCursor = {
    enable     = true;
    gtk.enable = true;
    package    = pkgs.bibata-cursors;
    name       = "Bibata-Modern-ICE";
    size       = 16;
  };
  
  ###########
  ### ZSH ###
  ###########
  programs.zsh = {
  	enable = true;
    shellAliases = {
      nixrb     = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
      hmrb      = "home-manager switch --flake ~/dotfiles/nixos";
      nixconf   = "code ~/dotfiles/nixos/configuration.nix" ;
      hmconf    = "code ~/dotfiles/nixos/home.nix";
      hyprconf  = "code ~/dotfiles/hypr/hyprland.lua";
      onbattery = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@60\", position = \"0x0\", scale = 2 })' && powerprofilesctl set power-saver";
      oncharge  = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@165\", position = \"0x0\", scale = 2 })' && powerprofilesctl set balanced";
    };
  };

  #############
  ### Kitty ###
  #############
  # programs.kitty = {
  #   enable = true;
  #   settings = {
  #     foreground = "#${config.colorScheme.palette.base05}";
  #     background = "#${config.colorScheme.palette.base00}";
  #   };
  # };
  

}

