hl.monitor({ output = "", mode = "3840x2160@120", position = "0x0", scale = 2 })

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)
