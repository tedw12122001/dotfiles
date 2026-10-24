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
        spacing = 10;

        modules-left = [
          "custom/session"
          "backlight"
          "bluetooth"
          "wireplumber"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "battery"
          "cpu"
          "network"
          "clock"
          "tray"
        ];

        "custom/session" = {
          format = "⏻";
          on-click = "wlogout || loginctl terminate-user $USER";
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

        "wireplumber" = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = [ "" "" "" ];
          tooltip-format = "Volume: {volume}%";
        };

        "wireplumber#input" = {
          node-type = "Audio/Source";
          format = "󰍬";
          format-muted = "󰍭";
          tooltip-format = "Mic: {volume}%";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-charging = "󰂄";
          format-plugged = "";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{capacity}% ({time})";
        };

        "cpu" = {
          format = "";
          tooltip-format = "CPU Load: {usage}%";
        };

        "network" = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
        };

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

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 16px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent;
        color: #${colors.base05};
      }

      #workspaces button {
        padding: 0 5px;
        color: #${colors.base05};
        background: transparent;
      }

      #workspaces button.focused,
      #workspaces button.active,
      #workspaces button.visible {
        color: #ffffff;
      }

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
