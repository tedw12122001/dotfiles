{ config, lib, ... }:

let

    lua = lib.generators.mkLuaInline;
    bind = key: action: { _args = [ key (lua action) ]; };
    exec = command: ''hl.dsp.exec_cmd("${command}")'';
    onEvent = event: handler: { _args = [ event (lua handler) ]; };
    envVar = name: value: { _args = [ name value ]; };
    bezier = name: points: { _args = [ name { type = "bezier"; inherit points; } ]; };
    autostart = ''
	function()
	    hl.exec_cmd("kitty")
	    hl.exec_cmd("noctalia")
	end
    '';

in

{
stylix.targets.hyprland.enable = false;
wayland.windowManager.hyprland = {
    enable = true;
    settings = {

	config = {
	    general = {
		gaps_in = 5;
		gaps_out = 40;
		border_size = 2;	
		resize_on_border = true;
		allow_tearing = true;
		layout = "dwindle";	
		col = {
		    active_border = "#${config.lib.stylix.colors.base05}";
		    inactive_border = "#${config.lib.stylix.colors.base02}";
		};
	    };
	    dwindle = {
		force_split = 2;
	    };
	    decoration = {
		rounding = 5;
		active_opacity = 1.0;
		inactive_opacity = 1.0;
		fullscreen_opacity = 1.0;
	    };	
	    misc = {
		force_default_wallpaper = 0;
		disable_hyprland_logo = true;
	    };
	    input = {
	      kb_layout          = "gb";
	      kb_options = "caps:swapescape";
	      follow_mouse       = 0;
	      sensitivity        = 0;
	      touchpad.natural_scroll = true;
	    };
	};
	
	monitor = [
	    { output = ""; mode = "3072x1920@165"; position = "0x0"; scale = 2; }
	];

	on = [ (onEvent "hyprland.start" autostart) ];
	
	curve = [
	    (bezier "linear" [ [ 0 0 ] [ 1 1 ] ])
	    (bezier "snappyReturn" [ [ 0.4 0.9 ] [ 0.6 1.0 ] ])
	    (bezier "bounce" [ [ 0.4 0.9 ] [ 0.6 1.0 ] ])
	    (bezier "md3_decel" [ [ 0.05 0.7 ] [ 0.1 1 ] ])
	    (bezier "softAcDecel" [ [ 0.26 0.26 ] [ 0.15 1 ] ])
	];

	animation = [
	    { leaf = "windowsMove"; enabled = true; speed = 4; bezier = "bounce"; style = "slide"; }
	    { leaf = "border"; enabled = true; speed = 5; bezier = "linear"; }
	    { leaf = "fade"; enabled = true; speed = 3; bezier = "md3_decel"; }
	    { leaf = "workspaces"; enabled = true; speed = 2.5; bezier = "softAcDecel"; style = "fade"; }
	];

	env = [
	    (envVar"XCURSOR_THEME" "Bibata-Modern-Ice")
	    (envVar "XCURSOR_SIZE" "30")
	];

	bind = [
	    (bind "SUPER + T" (exec "kitty"))
	    (bind "SUPER + W" "hl.dsp.window.close()")
	    (bind "SUPER + H" (exec "kitty nvim ~/dotfiles/nixos/home.nix"))
	    (bind "SUPER + C" (exec "kitty nvim ~/dotfiles/nixos/configuration.nix"))	
	    (bind "SUPER + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
	    (bind "SUPER + V" ''hl.dsp.window.float({ action = "toggle" })'')
	    (bind "SHIFT + SUPER + M" (exec "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
	    (bind "SUPER + O" ''hl.dsp.layout("togglesplit")'')
	    (bind "SUPER + E" (exec "kitty -e env VISUAL=nvim ranger"))
	    (bind "SUPER + B" (exec "brave-origin"))
	    (bind "SUPER + SPACE" (exec "noctalia msg panel-toggle launcher"))
	    (bind "SUPER + Q" (exec "noctalia msg mic-mute"))   
	    (bind "SUPER + TAB" "function() hl.dispatch(hl.dsp.window.cycle_next()) end")

	    # Workspaces
	    (bind "SUPER + 1" ''hl.dsp.focus({ workspace = "1" })'')
	    (bind "SUPER + SHIFT + 1" ''hl.dsp.window.move({ workspace = "1" })'')
	    (bind "SUPER + 2" ''hl.dsp.focus({ workspace = "2" })'')
	    (bind "SUPER + SHIFT + 2" ''hl.dsp.window.move({ workspace = "2" })'')
	    (bind "SUPER + 3" ''hl.dsp.focus({ workspace = "3" })'')
	    (bind "SUPER + SHIFT + 3" ''hl.dsp.window.move({ workspace = "3" })'')
	    (bind "SUPER + 4" ''hl.dsp.focus({ workspace = "4" })'')
	    (bind "SUPER + SHIFT + 4" ''hl.dsp.window.move({ workspace = "4" })'')
	    (bind "SUPER + 5" ''hl.dsp.focus({ workspace = "5" })'')
	    (bind "SUPER + SHIFT + 5" ''hl.dsp.window.move({ workspace = "5" })'')
	    (bind "SUPER + 6" ''hl.dsp.focus({ workspace = "6" })'')
	    (bind "SUPER + SHIFT + 6" ''hl.dsp.window.move({ workspace = "6" })'')

	    ];

	window_rule = [
	    { name = "suppress-maximize"; match.class = ".*"; suppress_event = "maximize"; }
	    { name = "mpv-float"; match.class = "mpv"; float = true; size = "800 500"; center = true; }
	];
    };
}; 
}
