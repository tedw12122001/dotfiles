{ pkgs, config, ... }:

let
  colors = config.lib.stylix.colors;
in

{
  programs.noctalia = {
    enable = true;
    settings = {
      lockscreen = {
        enabled = false;
      };

      services.audio = {
        enable_sounds = false;
      };

      bar.default = {
        start = [ "session" "control-center" "brightness" "bluetooth" "volume" ];
        center = [ "workspaces" ];
        end = [ "input_volume" "battery" "cpu" "network" "battery" "clock" "notifications" "tray" ];
        
        widget_spacing = 10;
        margin_ends = 0;
        color = "#${colors.base05}";
        background_opacity = 0.0;
        shadow = false;
        reserve_space = false;
      };

      widget.workspaces = {
        focused_color = "#ffffff";
        occupied_color = "#ffffff";
        show_labels = false;
      };

      widget.clock = {
        format = "%H:%M - %d/%m/%y ";
        timezone = "Europe/Berlin";
      };

      widget.cpu = {
        show_value = false;
      };

      widget.network = {
        show_label = false;
      };

      widget.volume = {
        show_label = false;
      };

      widget.input_volume = {
        show_label = false;
      };

      osd.kinds = {
        media = false;
        volume = false;
      };
    };
  };
}

