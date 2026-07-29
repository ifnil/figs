-- gentoo openrc has no dbus[user-session], so the dbus client lib won't
-- auto-default to $XDG_RUNTIME_DIR/bus; it tries X11 autolaunch, fails on
-- Wayland, and sets DBUS_SESSION_BUS_ADDRESS=disabled:. Apps launched from
-- the launcher/.desktop then can't reach dunst and draw their own toplevel
-- notification windows. so
-- export the bus explicitly for all session children.
hl.env("XDG_RUNTIME_DIR", os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000")
hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/bus")

-- laptop
hl.monitor({ output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1 })

-- portable monitor
hl.monitor({ output = "HDMI-A-1", mode = "1920x1200@60", position = "-1920x0", scale = 1 })

-- external
hl.monitor({ output = "DP-1", mode = "preferred", position = "-2560x0", scale = 1 })
-- no `default = true`: that reserves ws1 for DP-1 even when DP-1 is absent,
-- so a laptop-only boot lands on ws2.
hl.workspace_rule({
	workspace = "1",
	monitor = "DP-1",
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		-- disable_hyprland_qtutils_check = true,
	},
})
hl.on("hyprland.start", function()
	hl.exec_cmd("gentoo-pipewire-launcher")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("~/.config/hypr/scripts/xdg-portal-hyprland")
end)
