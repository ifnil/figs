local submaps = require("submaps")

local term = "kitty"
local mod = "SUPER"
local alt_mod = "ALT"
local rofi = "rofi -show combi -combi-modi 'drun,run,ssh,window,emoji' -terminal '" .. term .. "' -show-icons -lines 10"

hl.define_submap("(e)xit (l)ock s(u)spend (s)hutdown (r)eboot", submaps.machine_ctl)
hl.define_submap("resize", submaps.resize)
hl.define_submap("screenshot", submaps.screenshot)

local binds = {
	["SUPER"] = {
		["R"] = { evt = hl.dsp.submap("resize") },
		["SHIFT + E"] = { evt = hl.dsp.submap("(e)xit (l)ock s(u)spend (s)hutdown (r)eboot") },

		["Return"] = { evt = hl.dsp.exec_cmd(term) },
		["D"] = { evt = hl.dsp.exec_cmd(rofi) },

		["XF86AudioRaiseVolume"] = { evt = hl.dsp.focus({ workspace = "+1" }) },
		["XF86AudioLowerVolume"] = { evt = hl.dsp.focus({ workspace = "-1" }) },

		["SHIFT + Q"] = { evt = hl.dsp.window.close() },
		["SHIFT + C"] = { evt = hl.dsp.exec_cmd("hyprctl reload") },
		["SHIFT + XF86AudioRaiseVolume"] = { evt = hl.dsp.layout("swapnext"), arg = { bypass = true } },
		["SHIFT + XF86AudioLowerVolume"] = { evt = hl.dsp.layout("swapnext prev"), arg = { bypass = true } },

		-- Window focus (movefocus in a direction)
		["Left"] = { evt = hl.dsp.focus({ direction = "l" }) },
		["Down"] = { evt = hl.dsp.focus({ direction = "d" }) },
		["Up"] = { evt = hl.dsp.focus({ direction = "u" }) },
		["Right"] = { evt = hl.dsp.focus({ direction = "r" }) },
		["H"] = { evt = hl.dsp.focus({ direction = "l" }) },
		["J"] = { evt = hl.dsp.focus({ direction = "d" }) },
		["K"] = { evt = hl.dsp.focus({ direction = "u" }) },
		["L"] = { evt = hl.dsp.focus({ direction = "r" }) },

		-- Move tiled windows (movewindow in a direction)
		["SHIFT + Left"] = { evt = hl.dsp.window.move({ direction = "l" }) },
		["SHIFT + Down"] = { evt = hl.dsp.window.move({ direction = "d" }) },
		["SHIFT + Up"] = { evt = hl.dsp.window.move({ direction = "u" }) },
		["SHIFT + Right"] = { evt = hl.dsp.window.move({ direction = "r" }) },
		["SHIFT + H"] = { evt = hl.dsp.window.move({ direction = "l" }) },
		["SHIFT + J"] = { evt = hl.dsp.window.move({ direction = "d" }) },
		["SHIFT + K"] = { evt = hl.dsp.window.move({ direction = "u" }) },
		["SHIFT + L"] = { evt = hl.dsp.window.move({ direction = "r" }) },

		-- Move current workspace to another monitor
		["ALT + Left"] = { evt = hl.dsp.workspace.move({ monitor = "-1" }) },
		["ALT + Down"] = { evt = hl.dsp.workspace.move({ monitor = "-1" }) },
		["ALT + Right"] = { evt = hl.dsp.workspace.move({ monitor = "+1" }) },
		["ALT + Up"] = { evt = hl.dsp.workspace.move({ monitor = "+1" }) },

		["SHIFT + space"] = { evt = hl.dsp.window.float({ action = "toggle" }) },
		["W"] = { evt = hl.dsp.group.toggle() },
		["F"] = { evt = hl.dsp.window.fullscreen() },
		["E"] = { evt = hl.dsp.layout("togglesplit") },

		["SHIFT + mouse:273"] = { evt = hl.dsp.window.resize(), arg = { mouse = true } },
		["SHIFT + mouse:272"] = { evt = hl.dsp.window.drag(), arg = { mouse = true } },
		["mouse:273"] = { evt = hl.dsp.window.resize(), arg = { mouse = true } },
		["mouse:272"] = { evt = hl.dsp.window.drag(), arg = { mouse = true } },

		["backslash"] = { evt = hl.dsp.exec_cmd("hyprctl switchxkblayout current next") },
	},

	["ALT"] = {},
}

for key, val in pairs(binds["SUPER"]) do
	hl.bind("SUPER + " .. key, val.evt, val.arg)
end
