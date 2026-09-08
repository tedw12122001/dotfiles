{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  hyprlandLua = builtins.readFile ./hyprland.lua;
in
{
  home = {
    username = "ted";
    homeDirectory = "/home/ted";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  home.sessionVariables = {};

  ##############
  ### Cursor ###
  ##############
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-ICE";
    size = 16;
  };

  ###########
  ### ZSH ###
  ###########
  programs.zsh = {
    enable = true;
    shellAliases = {
      nixrb = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos";
      nixconf = "code ~/dotfiles/nixos/configuration.nix";
      hmconf = "code ~/dotfiles/nixos/home.nix";
      hyprconf = "code ~/dotfiles/hypr/hyprland.lua";
      onbattery = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@60\", position = \"0x0\", scale = 2 })' && powerprofilesctl set power-saver";
      oncharge = "hyprctl eval 'hl.monitor({ output = \"eDP-1\", mode = \"3072x1920@165\", position = \"0x0\", scale = 2 })' && powerprofilesctl set balanced";
    };
  };

  #############
  ### Kitty ###
  #############
  programs.kitty = {
    enable = true;
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
        center = [ "workspaces" ];
        end = [ "cpu" "network" "battery" "clock" "notifications" "tray" ];
        start = [ "session" "control-center" "brightness" "bluetooth" "volume" ];
        widget_spacing = 10;
        shadow = false;
        reserve_space = false;
      };
      lockscreen_widgets = {
        widget_order = [ "lockscreen-login-box@eDP-1" ];
        enabled = false;
        schema_version = 2;

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget."lockscreen-login-box@eDP-1" = {
          output = "eDP-1";
          type = "login_box";
          box_height = 196.0;
          box_width = 810.0;
          cx = 768.0;
          cy = 778.0;
          placement_height = 960.0;
          placement_width = 1536.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_variant";
            layout = "regular";
            center_password_text = false;
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
            background_opacity = 0.88;
            background_radius = 12.0;
            input_opacity = 1.0;
            input_radius = 6.0;
          };
        };
      };

      widget = {
        clock.format = "%H:%M - %d/%m/%y ";
        cpu.stat = "cpu_temp";
        network.show_label = false;
        volume.show_label = false;
      };
    };
  };

  ################
  ### Hyprland ###
  ################
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraConfig = ''
      ------------------
      ---- MONITORS ----
      ------------------
      hl.monitor({
          output   = "",
          mode     = "3072x1920@165",
          position = "0x0",
          scale    = 2,
      })

      ---------------------
      ---- MY PROGRAMS ----
      ---------------------
      local terminal    = "kitty"
      local fileManager = "nautilus"
      local menu        = "hyprlauncher"
      local browser     = "firefox"

      -------------------
      ---- AUTOSTART ----
      -------------------
      hl.on("hyprland.start", function ()
        hl.exec_cmd(terminal)
        hl.exec_cmd("noctalia")
        hl.exec_cmd("blanket")
      end)

      -----------------------
      ---- LOOK AND FEEL ----
      -----------------------
      hl.config({
          general = {
              gaps_in             = 5,
              gaps_out            = { top = 40, right = 20, bottom = 20, left = 20 },
              border_size         = 3,
              col = {
                  active_border   = {colors = {"#1e8bac"}},
                  inactive_border = "rgba(595959aa)"
              },
              resize_on_border    = true,
              allow_tearing       = false,
              layout              = "dwindle"
          },
          dwindle = {
              preserve_split      = true,
          },
          decoration = {
              rounding            = 10,
              rounding_power      = 2,
              active_opacity      = 1.0,
              inactive_opacity    = 1.0,
              shadow = {
                  enabled         = true,
                  range           = 4,
                  render_power    = 3,
                  color           = 0xee1a1a1a,
              },
              blur = {
                  enabled         = true,
                  size            = 3,
                  passes          = 1,
                  vibrancy        = 0.1696,
              },
          },
          animations = {
              enabled = true,
          },
      })

      --------------------
      ---- Animations ----
      --------------------
      hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
      hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
      hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
      hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
      hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
      hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

      hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
      hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
      hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
      hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
      hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
      hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
      hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
      hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
      hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
      hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
      hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
      hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
      hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
      hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
      hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

      ----------------
      ----  MISC  ----
      ----------------
      hl.config({
          misc = {
              force_default_wallpaper = 1,
              disable_hyprland_logo   = false,
          },
      })

      ----------------------------
      ---- KEYBOARD AND MOUSE ----
      ----------------------------
      hl.config({
          input = {
              kb_layout          = "gb",
              follow_mouse       = 1,
              sensitivity        = 0,
              touchpad = {
                  natural_scroll = true,
              },
          },
      })

      hl.gesture({
          fingers   = 3,
          direction = "horizontal",
          action    = "workspace"
      })

      hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
      hl.env("XCURSOR_SIZE", "30")

      ---------------------
      ---- KEYBINDINGS ----
      ---------------------
      local mainMod   = "SUPER"
      local secondMod = "SHIFT + SUPER"

      -- General
      hl.bind(mainMod   .. " + W", hl.dsp.window.close())
      hl.bind(secondMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
      hl.bind(mainMod   .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
      hl.bind(mainMod   .. " + O", hl.dsp.layout("togglesplit"))
      hl.bind(mainMod   .. " + V", hl.dsp.window.float({ action = "toggle" }))

      -- Apps
      hl.bind(mainMod   .. " + T", hl.dsp.exec_cmd(terminal))
      hl.bind(mainMod   .. " + E", hl.dsp.exec_cmd("nautilus"))
      hl.bind(mainMod   .. " + B", hl.dsp.exec_cmd(browser))
      hl.bind(mainMod   .. " + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
      hl.bind(mainMod   .. " + P", hl.dsp.exec_cmd("grim"))

      -- Shift focus
      hl.bind(mainMod   .. " + left",  hl.dsp.focus({ direction = "left" }))
      hl.bind(mainMod   .. " + right", hl.dsp.focus({ direction = "right" }))
      hl.bind(mainMod   .. " + up",    hl.dsp.focus({ direction = "up" }))
      hl.bind(mainMod   .. " + down",  hl.dsp.focus({ direction = "down" }))

      -- Workspaces
      for i = 1, 10 do
          local key = i % 10
          hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
          hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
      end

      -- Volume and brightness
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
      hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

      --------------------------------
      ---- WINDOWS AND WORKSPACES ----
      --------------------------------
      -- Ignore maximize requests
      local suppressMaximizeRule =
      hl.window_rule({
          name           = "suppress-maximize-events",
          match          = { class = ".*" },
          suppress_event = "maximize"
      })

      -- Fix dragging issues with XWayland
      hl.window_rule({
          name  = "fix-xwayland-drags",
          match = {
              class      = "^$",
              title      = "^$",
              xwayland   = true,
              float      = true,
              fullscreen = false,
              pin        = false
          },
          no_focus = true
      })
    '';
  };
}