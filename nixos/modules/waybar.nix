{ pkgs, config, ... }:

let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 10; # Equivalent to widget_spacing = 10

        # Left Section: start = [ "session" "control-center" "brightness" "bluetooth" "volume" ]
        modules-left = [
          "custom/session"
          "backlight"
          "bluetooth"
          "wireplumber"
        ];

        # Center Section: center = [ "workspaces" ]
        modules-center = [
          "hyprland/workspaces" # Or "niri/workspaces", "sway/workspaces" depending on your WM
        ];

        # Right Section: end = [ "input_volume" "battery" "cpu" "network" "clock" "tray" ]
        modules-right = [
          "wireplumber#input"
          "battery"
          "cpu"
          "network"
          "clock"
          "tray"
        ];

        # --- Module Configurations ---

        "custom/session" = {
          format = "⏻";
          on-click = "wlogout || wofi-power-menu || loginctl terminate-user $USER";
          tooltip = false;
        };

        "backlight" = {
          format = "{icon}";
          format-icons = [ "" "" "" ];
          tooltip-format = "Brightness: {percent}%";
        };

        "bluetooth" = {
          format = "";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        # Output Volume (show_label = false)
        "wireplumber" = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = [ "" "" "" ];
          tooltip-format = "Volume: {volume}%";
        };

        # Input Volume / Microphone (show_label = false)
        "wireplumber#input" = {
          node-type = "Audio/Source";
          format = "󰍬";
          format-muted = "󰍭";
          tooltip-format = "Mic: {volume}%";
        };

        # Workspaces (show_labels = false)
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "battery" = {
          format = "{icon}";
          format-charging = "󰂄";
          format-plugged = "";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{capacity}% ({time})";
        };

        # CPU (show_value = false)
        "cpu" = {
          format = "";
          tooltip-format = "CPU Load: {usage}%";
        };

        # Network (show_label = false)
        "network" = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
        };

        # Clock (format = "%H:%M - %d/%m/%y ", timezone = "Europe/Berlin")
        "clock" = {
          format = "{:%H:%M - %d/%m/%y }";
          timezone = "Europe/Berlin";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "tray" = {
          spacing = 8;
        };
      };
    };

    # Custom styling matching transparent background, colors, and workspaces styling
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent; /* background_opacity = 0.0 */
        color: #${colors.base05};      # Text/Icon color matching Stylix base05
      }

      #workspaces button {
        padding: 0 5px;
        color: #${colors.base05};
        background: transparent;
      }

      /* focused_color = "#ffffff" & occupied_color = "#ffffff" */
      #workspaces button.focused,
      #workspaces button.active {
        color: #ffffff;
      }

      #workspaces button.visible {
        color: #ffffff;
      }

      /* Padding for individual bar modules */
      #custom-session,
      #backlight,
      #bluetooth,
      #wireplumber,
      #battery,
      #cpu,
      #network,
      #clock,
      #tray {
        padding: 0 6px;
        color: #${colors.base05};
      }

      #clock {
        font-weight: bold;
      }
    '';
  };
}
