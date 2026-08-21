--- Plugins
package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@165",
    position = "1920x0",
    scale    = "1.25",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1.25",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal     = "footclient"
local dmenu        = "rofi -show drun -show-icons"
local rmenu        = "rofi -show run"
local fileManager  = terminal .. " -T files -e lf"
local email        = terminal .. " -T email -e neomutt"
local news         = terminal .. " -T news -e newsboat"
local notes        = "obsidian"
local browser      = "librewolf"
local passwords    = "keepassxc"
local lockscreen   = "hyprlock"
local communicator = "discord --ozone-platform=x11"

hl.on("hyprland.start", function()
    hl.exec_cmd("playerctld")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("dunst")
    hl.exec_cmd("nightlight")
    hl.exec_cmd("shortcuts")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("foot -s")
    hl.exec_cmd("hyprctl dispatch \"hl.dsp.focus({workspace=1})\"")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("TERMINAL", terminal)
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 8,

        border_size      = 4,

        col              = {
            active_border   = "#d65d0e",
            inactive_border = "#928374",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        allow_tearing    = true,

        layout           = "master",
    },

    decoration = {
        rounding = 9,
        rounding_power = 4,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 2,
            vibrancy = 0.2,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",    { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic",  { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",          { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear",    { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick",           { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global",             enabled = true, speed = 3,      bezier = "default" })
hl.animation({ leaf = "border",             enabled = true, speed = 5,      bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",            enabled = true, speed = 3,      bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",          enabled = true, speed = 2,      bezier = "quick" })
hl.animation({ leaf = "windowsOut",         enabled = true, speed = 2,      bezier = "quick" })
hl.animation({ leaf = "fadeIn",             enabled = true, speed = 1.2,    bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",            enabled = true, speed = 1.2,    bezier = "almostLinear" })
hl.animation({ leaf = "fade",               enabled = true, speed = 1,      bezier = "quick" })
hl.animation({ leaf = "layers",             enabled = true, speed = 1,      bezier = "quick" })
hl.animation({ leaf = "layersIn",           enabled = true, speed = 1.5,    bezier = "quick" })
hl.animation({ leaf = "layersOut",          enabled = true, speed = 1.5,    bezier = "linear",          style = "fade" })
hl.animation({ leaf = "fadeLayersIn",       enabled = true, speed = 1.5,    bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",      enabled = true, speed = 1.5,    bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",         enabled = true, speed = 1.5,    bezier = "almostLinear",    style = "fade" })
hl.animation({ leaf = "workspacesIn",       enabled = true, speed = 1.5,    bezier = "almostLinear",    style = "fade" })
hl.animation({ leaf = "workspacesOut",      enabled = true, speed = 1.5,    bezier = "almostLinear",    style = "fade" })
hl.animation({ leaf = "specialWorkspace",   enabled = true, speed = 1,      bezier = "quick",           style = "fade" })

hl.config({
    master = {
        new_status = "master",
        new_on_top = true,
        mfact = 0.55,
        allow_small_split = true,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = false,
        use_nearest_neighbor = false,
    }
})

hl.config({
    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo      = true,
        font_family                = "JetBrainsMonoNerdFont",
        vrr                        = 0,
        enable_swallow             = false,
        swallow_regex              = "^(foot|footclient|floatingterm|terminal|files)$",
        swallow_exception_regex    = ".*(wev|xev|gs|glxgears)",
        mouse_move_enables_dpms    = true,
        key_press_enables_dpms     = true,
        initial_workspace_tracking = 0,
        allow_session_lock_restore = true,
    },
})

smw.setup({
    workspace_count = 9,

    monitor_priority = {
        "DP-1",
        "HDMI-A-1",
        "eDP-1",
    },

    keep_focused = true,
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "pl",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "",
        kb_rules     = "",

        follow_mouse = 1,

        sensitivity  = 0,
        repeat_delay = 300,
        repeat_rate  = 60,

        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- System binds
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle"}))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(lockscreen))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))

-- Program binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(dmenu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(rmenu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(email))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(news))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(passwords))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(communicator))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("calibre"))

-- Scratchpad binds
hl.bind(mainMod ..  " + M", hl.dsp.exec_cmd("hyprscratch music"))
hl.bind(mainMod ..  " + S", hl.dsp.exec_cmd("hyprscratch terminal"))
hl.bind(mainMod ..  " + CONTROL + Q", hl.dsp.exec_cmd("hyprscratch qalc"))
hl.bind(mainMod ..  " + CONTROL + C", hl.dsp.exec_cmd("hyprscratch calc"))

-- Script binds
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd("powermenu"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -an"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("wallpaper open"))
hl.bind(mainMod .. " + CONTROL + W", hl.dsp.exec_cmd("wallpaper random"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screenshot"))
hl.bind("Print",                   hl.dsp.exec_cmd("grim -o $(hyprctl monitors -j | jq -r '.[] | select (.focused?) | .name') \"$HOME/dox/pix/screenshots/$(date '+%Y-%m-%d-%H-%M-%S').png\" && notify-send 'screenshot taken'"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("mpvq addclip"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("mpvq play"))
hl.bind(mainMod .. " + Grave", hl.dsp.exec_cmd("rofibookmarks select"))
hl.bind(mainMod .. " + SHIFT + Grave", hl.dsp.exec_cmd("rofibookmarks select_browser"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("rofibookmarks add"))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("rofiunicode"))

-- Layout binds
hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.05"))
hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.05"))

hl.bind(mainMod .. " + K", hl.dsp.window.cycle_next(), {repeating=true})
hl.bind(mainMod .. " + J", hl.dsp.window.cycle_next({next=false}, {repeating=true}))

hl.bind(mainMod .. " + SHIFT +  J", hl.dsp.layout("swapnext"))
hl.bind(mainMod .. " + SHIFT +  K", hl.dsp.layout("swapprev"))

hl.bind(mainMod .. " + SHIFT +  I", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT +  D", hl.dsp.layout("removemaster"))

hl.bind(mainMod .. " + Comma", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + Period", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT +  Comma", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mainMod .. " + SHIFT +  Period", hl.dsp.window.move({ monitor = "+1" }))

hl.bind(mainMod .. " + C", hl.dsp.window.center())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({action="toggle"}))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace="previous_per_monitor" }))

-- Pass
hl.bind("ALT + Grave", hl.dsp.pass({ window = "class:^(discord)$" }))
hl.bind("F9", hl.dsp.pass({ window = "class:^(discord)$" }))

hl.define_submap("passthru", function()
  hl.bind("SUPER + F11", hl.dsp.submap("reset"))
end)
hl.bind("SUPER + F11", hl.dsp.submap("passthru"))


for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    if n == "10" then n = "0" end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
    -- Switch to the Nth workspace on the currently focused monitor.
    hl.bind(mainMod .. " +" .. n, smw.workspace(n))
    -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
    hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace(n))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),             { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),        { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"),                            { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),                          { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),         { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),   { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),     { locked = true })

-- mpd control
hl.bind(mainMod .. " + ALT + p",        hl.dsp.exec_cmd("mpc toggle"),                                  { locked = true })
hl.bind(mainMod .. " + ALT + s",        hl.dsp.exec_cmd("mpc pause && mpc seek 0"),                     { locked = true })
hl.bind(mainMod .. " + ALT + n",        hl.dsp.exec_cmd("$HOME/dotfiles/.config/rmpc/rmpc-notifier"),   { locked = true })
hl.bind(mainMod .. " + ALT + Comma",    hl.dsp.exec_cmd("mpc prev"),                                    { locked = true })
hl.bind(mainMod .. " + ALT + Period",   hl.dsp.exec_cmd("mpc next"),                                    { locked = true })
hl.bind(mainMod .. " + ALT + Minus",    hl.dsp.exec_cmd("mpc volume -5"),                               { locked = true })
hl.bind(mainMod .. " + ALT + Equal",    hl.dsp.exec_cmd("mpc volume +5"),                               { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


-- Window rules

hl.window_rule({
    match = { title = "email" },
    workspace = "3",
})

hl.window_rule({
    match = { class = "calibre-gui" },
    workspace = "4",
})

hl.window_rule({
    match = { class = "orca-slicer" },
    workspace = "4 silent",
})

hl.window_rule({
    match = { title = "news" },
    workspace = "5",
})

hl.window_rule({
    match = { class = "md.obsidian.Obsidian" },
    workspace = "6",
})

hl.window_rule({
    match = { class = "org.freecad.FreeCAD" },
    workspace = "7",
})

hl.window_rule({
    match = { class = "org.keepassxc.KeePassXC" },
    workspace = "9",
})

hl.window_rule({
    match = { class = "mpvq" },
    monitor = "HDMI-A-1 silent",
})

hl.window_rule({
    match = { class = "steam" },
    workspace = "12 silent",
})

hl.window_rule({
    match = { class = "discord" },
    workspace = "13 silent",
})

hl.window_rule({
    match = { class = "floatingterm"},
    float = true
})

hl.window_rule({
    match = { class = "xdg-desktop-portal-gtk"},
    float = true,
    size = {"(monitor_w*0.6)", "(monitor_h*0.7)"},
})

hl.window_rule({
    match = { class = "footclient"},
    size = {"(monitor_w*0.6)", "(monitor_h*0.7)"},
})
