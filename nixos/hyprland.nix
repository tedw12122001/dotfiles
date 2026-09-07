# ~/dotfiles/nixos/hyprland.nix
{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    # Set the config type to lua
    configType = "lua";
    
    # Settings converted to Nix attrset
    settings = {
      # ---- MONITORS ----
      monitor = [
        {
          output = "";
          mode = "3072x1920@165";
          position = "0x0";
          scale = 2;
        }
      ];
      
      # ---- MY PROGRAMS ----
      # Define variables for use in keybindings
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$menu" = "hyprlauncher";
      "$browser" = "firefox";
      
      # ---- LOOK AND FEEL ----
      general = {
        gaps_in = 5;
        gaps_out = {
          top = 40;
          right = 20;
          bottom = 20;
          left = 20;
        };
        border_size = 3;
        col = {
          active_border = [
            "rgba(159,255,255,0.75)"
          ];
          inactive_border = "rgba(595959aa)";
        };
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      
      dwindle = {
        preserve_split = true;
      };
      
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "0xee1a1a1a";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      animations = {
        enabled = true;
      };
      
      # ---- MISC ----
      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = false;
      };
      
      # ---- KEYBOARD AND MOUSE ----
      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };
      
      # ---- GESTURES ----
      gestures = {
        workspace_swipe = true;
      };
      
      # ---- ENVIRONMENT VARIABLES ----
      env = [
        {
          name = "XCURSOR_THEME";
          value = "Bibata-Modern-Ice";
        }
        {
          name = "XCURSOR_SIZE";
          value = "30";
        }
      ];
      
      # ---- KEYBINDINGS ----
      bind = [
        # General
        "$mod, W, killactive"
        "$mod SHIFT, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
        "$mod, F, fullscreen"
        "$mod, O, togglesplit"
        "$mod, V, togglefloating"
        
        # Apps
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, SPACE, exec, rofi -show drun -show-icons"
        ", Print, exec, grim"  # Screenshot
        
        # Shift focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        # Workspaces (1-10)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move windows to workspaces (1-10)
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Volume and brightness
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
      
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      
      # ---- WINDOW RULES ----
      windowrule = [
        "suppressevent maximize, .*"  # Ignore maximize requests
        "nofocus, ^$, 0x0"           # Fix dragging issues with XWayland
      ];
    };
  };
}