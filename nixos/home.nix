
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
  programs.kitty = {
    enable    = true;
    # themeFile = "tokyo_night_night";
  };

  ################
  ### Noctalia ###
  ################
  programs.noctalia = {
    enable = true;
    settings = {
      config_version = 13;
      bar.default = {
        center         = [ "workspaces" ];
        end            = [ "cpu" "network" "battery" "clock" "notifications" "tray" ];
        start          = [ "session" "control-center" "brightness" "bluetooth" "volume" ];
        widget_spacing = 10;
        shadow         = false;
        reserve_space  = false;
      };
      lockscreen_widgets = {
        widget_order   = [ "lockscreen-login-box@eDP-1" ];
        enabled        = false;
        schema_version = 2;
        
        grid = {
          cell_size      = 16;
          major_interval = 4;
          visible        = true;
        };

        widget."lockscreen-login-box@eDP-1" = {
          output           = "eDP-1";
          type             = "login_box";
          box_height       = 196.0;
          box_width        = 810.0;
          cx               = 768.0;
          cy               = 778.0;
          placement_height = 960.0;
          placement_width  = 1536.0;
          rotation         = 0.0;
          settings = {
            background_color     = "surface_variant";
            layout               = "regular";
            center_password_text = false;
            show_caps_lock       = true;
            show_keyboard_layout = true;
            show_login_button    = true;
            show_media           = true;
            show_session_buttons = true;
            show_unlock_hint     = true;
            show_weather         = true;
            background_opacity   = 0.88;
            background_radius    = 12.0;
            input_opacity        = 1.0;
            input_radius         = 6.0;
          };
        };
      };

      wallpaper = {
        directory    = "/home/ted/dotfiles/nixos";
        default.path = "/home/ted/dotfiles/nixos/Wallpaper.png";
        last.path    = "/home/ted/dotfiles/nixos/Wallpaper.png";
      };

      widget = {
        clock.format       = "%H:%M - %d/%m/%y ";
        cpu.stat           = "cpu_temp";
        network.show_label = false;
        volume.show_label  = false;
      };
    };
  };

  ############
  ### Yazi ###
  ############
  programs.yazi = {
    enable    = true;
    settings = {
      mgr = {
        show_hidden    = true;
        show_symlink   = true;
      };
      preview = {
        image_delay    = 100;  
        image_filter   = "nearest"; 
        image_quality  = 85;   
        ueberzug_scale = 0.5;    
      };
      opener.edit = [{
        run   = "micro %s";
        block = true;        
      }];
    };
  };

}

