-- artix. the session bus, pipewire and wireplumber are openrc *user* services
-- (/etc/user/init.d/*, from dbus-openrc / pipewire-openrc / wireplumber-openrc).
-- started from the hyprland.start hook below via `rc-service --user`, since
-- nothing else on this box brings up a user session.
--
-- the client lib still won't auto-default to $XDG_RUNTIME_DIR/bus: it tries
-- X11 autolaunch, fails on Wayland, and sets DBUS_SESSION_BUS_ADDRESS=disabled:.
-- Apps launched from the launcher/.desktop then can't reach dunst and draw
-- their own toplevel notification windows. so export the bus explicitly for
-- all session children -- this points at the socket the user service creates.
hl.env("XDG_RUNTIME_DIR", os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000")
hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/bus")

-- laptop
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })

-- portable monitor
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "-1920x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "-1920x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "preferred", position = "-1920x0", scale = 1 })

-- external
-- hl.monitor({ output = "DP-1", mode = "preferred", position = "-2560x0", scale = 1 })

hl.workspace_rule({
	workspace = "1",
	monitor = "eDP-1",
})

hl.config({
	misc = {
		force_default_wallpaper = 0,
		-- disable_hyprland_qtutils_check = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd(
		"rc-service --user dbus start; "
			.. "dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP; "
			.. "rc-service --user pipewire start; "
			.. "rc-service --user wireplumber start"
	)
	hl.exec_cmd("~/.config/hypr/scripts/xdg-portal-hyprland")
end)
