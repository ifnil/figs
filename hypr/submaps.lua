return {
	resize = function()
		hl.bind("h", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
		hl.bind("l", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
		hl.bind("k", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
		hl.bind("j", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
		-- exit only on escape/enter; catchall here would reset after every h/l/k/j press
		hl.bind("Escape", hl.dsp.submap("reset"))
		hl.bind("Return", hl.dsp.submap("reset"))
	end,

	screenshot = function()
		hl.bind("p", hl.dsp.exec_cmd("hyprshot -m region -o ~/pictures/screenshots"), { repeating = true })
		hl.bind("p", hl.dsp.submap("reset")) -- reset after capture (was `exec, reset`)
		hl.bind("catchall", hl.dsp.submap("reset"))
	end,

	machine_ctl = function()
		hl.bind("e", hl.dsp.exit(), { repeating = true })
		hl.bind("l", hl.dsp.exec_cmd("hyprlock"), { repeating = true })
		hl.bind("u", hl.dsp.exec_cmd("loginctl suspend"), { repeating = true })
		hl.bind("s", hl.dsp.exec_cmd("loginctl poweroff"), { repeating = true })
		hl.bind("r", hl.dsp.exec_cmd("loginctl reboot"), { repeating = true })

		-- Reset submap after the action (original wrote `exec, reset`; fixed to submap reset).
		hl.bind("e", hl.dsp.submap("reset"))
		hl.bind("l", hl.dsp.submap("reset"))
		hl.bind("s", hl.dsp.submap("reset"))
		hl.bind("u", hl.dsp.submap("reset"))
		hl.bind("r", hl.dsp.submap("reset"))
		hl.bind("catchall", hl.dsp.submap("reset"))
	end,
}
