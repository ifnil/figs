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
