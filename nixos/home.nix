{ pkgs, lib, config, ... }:

{

home = {
    username      = "ted";
    homeDirectory = "/home/ted";
    stateVersion  = "26.05";
    };

programs.home-manager.enable = true;


imports = [
  ./modules
];

home.pointerCursor = {
    enable     = true;
    gtk.enable = true;
    package    = pkgs.bibata-cursors;
    name       = "Bibata-Modern-ICE";
    size       = 16;
};

programs.ranger.enable = true;

programs.fuzzel.enable = true;

programs.fzf = {
    enable               = true;
    enableZshIntegration = true;
    };

}
