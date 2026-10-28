-- MONITORS
hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@144",
    position = "1920x0",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@75",
    position = "0x0",
    scale    = "1",
})

-- PROGRAM SHORTCUTS
local terminal    = "alacritty"
local fileManager = "alacritty --class yazi-float -e yazi"
local menu        = "wofi --show drun"
local play        = "alacritty --class yt-search -e ytfzf -m"

-- AUTOSTART
hl.on("hyprland.start", function ()
    hl.exec_cmd("eww daemon & sleep 1 && eww open bar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
end)

-- ENVIRONMENT VARIABLES (NVIDIA / WAYLAND)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("GTK_THEME", "Adwaita-dark")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 6,
        border_size = 2,

        -- Everforest Dark Hard: Verde musgo para foco, carbón sutil para inactivo
         col = {
            active_border   = "rgba(00000000)",
            inactive_border = "rgba(00000000)",
		-- just in case
	    -- active_border   = "rgba(a7c080ff)",
            -- inactive_border = "rgba(3a454aff)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 2,
            color        = 0x661e2326, -- Sombra suave Everforest
        },

        blur = {
            enabled  = true,
            size     = 4,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
    cursor = {
        no_hardware_cursors = true, 
    },
})

-- ANIMACIONES RÁPIDAS Y DIRECTAS (Sin latencia de rebote)
hl.curve("fast", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })

hl.animation({ leaf = "global",     enabled = true, speed = 4, bezier = "fast" })
hl.animation({ leaf = "windows",    enabled = true, speed = 3, bezier = "fast" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "fast", style = "popin 85%" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2, bezier = "fast" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "fast", style = "slide" })

-- LAYOUT CONFIG
hl.config({
    dwindle = {
        preserve_split = true,
        smart_split    = false,
    },
    misc = {
        disable_splash_rendering = true,
        force_default_wallpaper  = 1,
        disable_hyprland_logo    = true,
    },
    input = {
        kb_layout    = "es",
        follow_mouse = 1,
        sensitivity  = 0,
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Core Binds
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(play)) 

-- Salida / Cierre de sesión seguro
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))

-- Screenshots (Grim + Slurp)
hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("Print",         hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

-- NAVEGACIÓN MODAL TIPO VIM / HELIX (Foco)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- INTERCAMBIO DE VENTANAS (Mover ventana en el layout)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Flechas como respaldo
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- WORKSPACES (1 - 6)
for i = 1, 6 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad (Magic Workspace)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Ratón (Drag & Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Teclas multimedia / Brillo
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- REGLAS DE VENTANAS --------
--------------------------------
-- Suprimir eventos de maximizado
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Corrección para arrastre en XWayland
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Ventana flotante centrada para Yazi (cuando se lanza con SUPER + E)
hl.window_rule({
    name   = "yazi-floating",
    match  = { class = "yazi-float" },
    float  = true,
    size   = "1200 700",
    center = true,
})

hl.window_rule({
    name   = "yt-search",
    match  = { class = "yt-search" },
    float  = true,
    size   = "900 500",
    center = true,
})
