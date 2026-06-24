-- gentoo openrc has no dbus[user-session], so the dbus client lib won't
-- auto-default to $XDG_RUNTIME_DIR/bus; it tries X11 autolaunch, fails on
-- Wayland, and sets DBUS_SESSION_BUS_ADDRESS=disabled:. Apps launched from
-- the launcher/.desktop then can't reach dunst and draw their own toplevel
-- notification windows. so
-- export the bus explicitly for all session children.
hl.env("XDG_RUNTIME_DIR", os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000")
hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/bus")

hl.monitor({ output = "", mode = "1920x1200@60", position = "0x0", scale = 1 })

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
