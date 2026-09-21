hl.monitor({ output = "", mode = "3840x2160@120", position = "0x0", scale = 2 })

hl.on("hyprland.start", function()
	-- systemd host: also push the session env into the user manager, so
	-- user units (portals, polkit agent) see WAYLAND_DISPLAY.
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
