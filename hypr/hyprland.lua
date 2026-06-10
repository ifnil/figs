require("animation")
require("layouts")

local colors = {
	background = "rgba(489c7acf)",
}

local term = "kitty"
local mod = "SUPER"
local alt_mod = "ALT"
local rofi = "rofi -show combi -combi-modi 'drun,run,ssh,window,emoji' -terminal '" .. term .. "' -show-icons -lines 10"

hl.env("PATH", "/home/june/.local/bin:" .. (os.getenv("PATH") or ""))
-- Gentoo OpenRC has no dbus[user-session], so the dbus client lib won't
-- auto-default to $XDG_RUNTIME_DIR/bus; it tries X11 autolaunch, fails on
-- Wayland, and sets DBUS_SESSION_BUS_ADDRESS=disabled:. Apps launched from
-- the launcher/.desktop then can't reach dunst and draw their own toplevel
-- notification windows. Export the bus explicitly for all session children.
hl.env("XDG_RUNTIME_DIR", os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000")
hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/bus")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "28")

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("quickshell --no-duplicate &")
	hl.exec_cmd("dunst &")
	hl.exec_cmd("bongocat --config ~/.config/bongocat/bongocat.conf --watch-config")
end)

hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

hl.config({
	general = {
		layout = "spiral",
		border_size = 3,
		gaps_in = 5,
		gaps_out = { top = 5, right = 15, bottom = 15, left = 15 },
		col = {
			active_border = colors.background,
		},
		resize_on_border = true,
	},

	master = {
		allow_small_split = true,
		slave_count_for_center_master = 0,
	},

	dwindle = {
		preserve_split = true,
	},

	decoration = {
		rounding = 0,
		shadow = {
			enabled = true,
			range = 13,
		},
	},

	input = {
		kb_options = "caps:escape_shifted_capslock",
		kb_layout = "us,ru",
		kb_variant = ",phonetic_winkeys",
		touchpad = {
			natural_scroll = true,
		},
	},
})

-- Safety net: if dunst ever comes up on the X11 backend it renders as a
-- tiled toplevel. Float it. No-op for the normal wayland layer-shell dunst.
hl.window_rule({
	name = "float-dunst",
	match = { class = "^(dunst)$" },
	float = true,
})

hl.device({
	name = "tpps/2-elan-trackpoint",
	sensitivity = -0.5,
})

local submaps = require("submaps")
hl.define_submap("(e)xit (l)ock s(u)spend (s)hutdown (r)eboot", submaps.machine_ctl)
hl.define_submap("resize", submaps.resize)
hl.define_submap("screenshot", submaps.screenshot)

local function modmap(bind)
	return mod .. " + " .. bind
end

hl.bind(modmap("R"), hl.dsp.submap("resize"))
hl.bind(modmap("SHIFT + E"), hl.dsp.submap("(e)xit (l)ock s(u)spend (s)hutdown (r)eboot"))
hl.bind(alt_mod .. "+ SHIFT + 4", hl.dsp.submap("screenshot")) -- was `ALT&Shift_L, 4`

hl.bind(modmap("SHIFT + mouse:273"), hl.dsp.window.resize(), { mouse = true }) -- Resize, Mod+Shift+RMB
hl.bind(modmap("SHIFT + mouse:272"), hl.dsp.window.drag(), { mouse = true }) -- Move,   Mod+Shift+LMB
hl.bind(modmap("mouse:273"), hl.dsp.window.resize(), { mouse = true }) -- Resize, Mod+RMB
hl.bind(modmap("mouse:272"), hl.dsp.window.drag(), { mouse = true }) -- Move,   Mod+LMB

hl.bind(modmap("Return"), hl.dsp.exec_cmd(term))
hl.bind(modmap("SHIFT + Q"), hl.dsp.window.close())
hl.bind(modmap("D"), hl.dsp.exec_cmd(rofi))
hl.bind(modmap("SHIFT + C"), hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(alt_mod .. "+ e", hl.dsp.exec_cmd("rofimoji"))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer sset Master 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer sset Master 2%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer sset Master toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl --device='smc::kbd_backlight' set +5%"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl --device='smc::kbd_backlight' set 5%-"))

hl.bind(modmap("XF86AudioRaiseVolume"), hl.dsp.focus({ workspace = "+1" }))
hl.bind(modmap("XF86AudioLowerVolume"), hl.dsp.focus({ workspace = "-1" }))
hl.bind(modmap("SHIFT + XF86AudioRaiseVolume"), hl.dsp.layout("swapnext"), { bypass = true })
hl.bind(modmap("SHIFT + XF86AudioLowerVolume"), hl.dsp.layout("swapnext prev"), { bypass = true })

-- Window focus (movefocus in a direction)
hl.bind(modmap("Left"), hl.dsp.focus({ direction = "l" }))
hl.bind(modmap("Down"), hl.dsp.focus({ direction = "d" }))
hl.bind(modmap("Up"), hl.dsp.focus({ direction = "u" }))
hl.bind(modmap("Right"), hl.dsp.focus({ direction = "r" }))
hl.bind(modmap("H"), hl.dsp.focus({ direction = "l" }))
hl.bind(modmap("J"), hl.dsp.focus({ direction = "d" }))
hl.bind(modmap("K"), hl.dsp.focus({ direction = "u" }))
hl.bind(modmap("L"), hl.dsp.focus({ direction = "r" }))

-- Move tiled windows (movewindow in a direction)
hl.bind(modmap("SHIFT + Left"), hl.dsp.window.move({ direction = "l" }))
hl.bind(modmap("SHIFT + Down"), hl.dsp.window.move({ direction = "d" }))
hl.bind(modmap("SHIFT + Up"), hl.dsp.window.move({ direction = "u" }))
hl.bind(modmap("SHIFT + Right"), hl.dsp.window.move({ direction = "r" }))
hl.bind(modmap("SHIFT + H"), hl.dsp.window.move({ direction = "l" }))
hl.bind(modmap("SHIFT + J"), hl.dsp.window.move({ direction = "d" }))
hl.bind(modmap("SHIFT + K"), hl.dsp.window.move({ direction = "u" }))
hl.bind(modmap("SHIFT + L"), hl.dsp.window.move({ direction = "r" }))

-- Move current workspace to another monitor
hl.bind(modmap("ALT + Left"), hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(modmap("ALT + Down"), hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(modmap("ALT + Right"), hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(modmap("ALT + Up"), hl.dsp.workspace.move({ monitor = "+1" }))

-- Workspaces: switch (mod + N) and move-silent (mod + SHIFT + N)
for i = 1, 10 do
	local key = i % 10
	hl.bind(modmap(key), hl.dsp.focus({ workspace = i }))
	hl.bind(modmap("SHIFT + " .. key), hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(modmap("SHIFT + space"), hl.dsp.window.float({ action = "toggle" })) -- Toggle floating
hl.bind(modmap("W"), hl.dsp.group.toggle()) -- Group/ungroup (tabbed container)
hl.bind(modmap("F"), hl.dsp.window.fullscreen()) -- Toggle fullscreen
-- hl.bind(mod .. " + E",      hl.dsp.layout("togglesplit"))           -- Toggle split orientation (dwindle)

local hostname = (function()
	local h = os.getenv("HOSTNAME")
	if h and h ~= "" then
		return h
	end
	local f = io.popen("uname -n")
	if not f then
		return ""
	end
	local n = f:read("*l") or ""
	f:close()
	return (n:gsub("%s+$", ""))
end)()

if hostname == "tiramisu" then
	require("hosts.tiramisu")
elseif hostname == "gelato" then
	require("hosts.gelato")
elseif hostname == "melon" then
	require("hosts.melon")
end
