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
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("wayle panel start")
   hl.exec_cmd("hyprpaper")
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
            active_border   = {colors = {"rgba(159,255,255,0.75)"}},
            inactive_border = "rgba(595959aa)"
        },
        resize_on_border    = false,
        allow_tearing       = false,
        layout              = "dwindle"
    },
    dwindle = {
        preserve_split      = true, -- You probably want this
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
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
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
hl.bind(mainMod   .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod   .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod   .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -show-icons"))

-- Shift focus 
hl.bind(mainMod   .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod   .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod   .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod   .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
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
