{ config, pkgs, ... }:

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
  
  home.packages = [];

  home.file = {};

  xdg.configFile = {
    ".zshrc".source = symlink "${dotfiles}/.zshrc";
    "hypr".source   = symlink "${dotfiles}/hypr";
    "rofi".source   = symlink "${dotfiles}/rofi";
    "waybar".source = symlink "${dotfiles}/waybar";
    "kitty".source  = symlink "${dotfiles}/kitty";
    "nchat".source  = symlink "${dotfiles}/nchat";
    "wayle".source  = symlink "${dotfiles}/wayle";
  };

  home.sessionVariables = {};

  home.pointerCursor = {
    enable     = true;
    gtk.enable = true;
    package    = pkgs.bibata-cursors;
    name       = "Bibata-Modern-ICE";
    size       = 16;
  };
}
