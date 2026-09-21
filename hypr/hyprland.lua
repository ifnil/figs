require("animation")
require("layouts")
require("binds")

-- hy3 comes from `hyprpm reload` in the start hook, so the first pass through
-- this file never sees it; a successful load triggers a config reload, and
-- it shows up on that pass. if it never does (failed build, stale headers),
-- fall back to broke.lua's group-based imitation.
local has_hy3 = (function()
	for _, plugin in ipairs(hl.get_loaded_plugins()) do
		if plugin.name == "hy3" then
			return true
		end
	end
	return false
end)()

local colors = {
	-- background = "rgba(489c7acf)",
	-- background = "rgba(eeed7bcf)",
	-- background = "rgba(00ffb3fc)",
	background = "rgba(4f2833ff)",
}

local term = "kitty"
local mod = "SUPER"
local alt_mod = "ALT"
local rofi = "rofi -show combi -combi-modi 'drun,run,ssh,window,emoji' -terminal '" .. term .. "' -show-icons -lines 10"

hl.env("PATH", "/home/june/.local/bin:" .. (os.getenv("PATH") or ""))

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "28")

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("quickshell --no-duplicate -c topbar &")
	hl.exec_cmd("dunst &")
	hl.exec_cmd("bongocat --config ~/.config/bongocat/bongocat.conf --watch-config")
end)

local gtk_theme = "Arc-Dark"
local icon_theme = "Qogir-Manjaro-Dark"

hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "' .. gtk_theme .. '"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface icon-theme "' .. icon_theme .. '"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

hl.config({
	general = {
		layout = has_hy3 and "hy3" or "dwindle",
		border_size = 2,
		gaps_in = 4,
		gaps_out = { top = 4, right = 15, bottom = 15, left = 15 },
		col = {
			active_border = colors.background,
		},
		resize_on_border = true,
	},

	master = {
		allow_small_split = true,
		slave_count_for_center_master = 0,
	},

	decoration = {
		rounding = 0,
		shadow = {
			enabled = true,
			range = 13,
		},
	},

	input = {
		repeat_delay = 350,
		kb_options = "caps:escape_shifted_capslock",
		kb_layout = "us,ru",
		kb_variant = ",phonetic_winkeys",
		touchpad = {
			natural_scroll = true,
		},
	},
})

if has_hy3 then
	hl.config({
		plugin = {
			hy3 = {
				autotile = {
					enable = true,
				},
			},
		},
	})
else
	-- after binds.lua: broke.lua replaces some of its binds
	require("broke")
end

-- GTK/Xfce apps (thunar) persist "was maximized" across restarts and re-request
-- it on map. hy3 honours that as fullscreen mode 1, so the window covers the
-- workspace above the tiles and won't join the layout until it's moved.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "float-dunst",
	match = { class = "^(dunst)$" },
	float = true,
})

hl.window_rule({
	name = "float-golf",
	match = { title = "(golf)$" },
	float = true,
})

hl.device({
	name = "tpps/2-elan-trackpoint",
	sensitivity = -0.5,
})

local function modmap(bind)
	return mod .. " + " .. bind
end

hl.bind(modmap("SHIFT + E"), hl.dsp.submap("(e)xit (l)ock s(u)spend (s)hutdown (r)eboot"))
hl.bind(alt_mod .. "+ SHIFT + 4", hl.dsp.submap("screenshot")) -- was `ALT&Shift_L, 4`

hl.bind(alt_mod .. "+ e", hl.dsp.exec_cmd("rofimoji -a copy"))

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
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

-- the keyboard backlight LED is named per-vendor (tpacpi:: on ThinkPads,
-- smc:: on Apple), so bind whichever one this box actually exposes.
local kbd_backlight = (function()
	for _, name in ipairs({ "tpacpi::kbd_backlight", "smc::kbd_backlight" }) do
		local f = io.open("/sys/class/leds/" .. name .. "/brightness", "r")
		if f then
			f:close()
			return name
		end
	end
end)()

if kbd_backlight then
	hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl --device='" .. kbd_backlight .. "' set +5%"))
	hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl --device='" .. kbd_backlight .. "' set 5%-"))
end

-- Workspaces: switch (mod + N) and move-silent (mod + SHIFT + N)
for i = 1, 10 do
	local key = i % 10
	hl.bind(modmap(key), hl.dsp.focus({ workspace = i }))
	hl.bind(modmap("SHIFT + " .. key), hl.dsp.window.move({ workspace = i, follow = false }))
end

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
