--
-- Hy3 Layout at Home
--

-- Focus on previous window in group or window outside of group
local function focus_left()
	local w = hl.get_active_window()
	if w and w.group and w.group.current_index ~= 1 then
		return hl.dsp.group.prev()
	end
	return hl.dsp.focus({ direction = "l" })
end

-- Focus on next window in group or window outside of group
local function focus_right()
	local w = hl.get_active_window()
	if w and w.group and w.group.current_index ~= w.group.size then
		return hl.dsp.group.next()
	end
	return hl.dsp.focus({ direction = "r" })
end

-- Focus on next window in group or window outside of group
local function move_left()
	local w = hl.get_active_window()
	if w and w.group and w.group.current_index ~= 1 then
		return hl.dsp.group.move_window({ forward = false })
	end
	return hl.dsp.window.move({ direction = "l", group_aware = true })
end

-- Move window to the right within group until it reaches the end
local function move_right()
	local w = hl.get_active_window()
	if w and w.group and w.group.current_index ~= w.group.size then
		return hl.dsp.group.move_window()
	end

	-- ensure window entering group is the left-most position in group
	hl.dispatch(hl.dsp.window.move({ direction = "r", group_aware = true }))
	w = hl.get_active_window()
	while w and w.group and w.group.current_index ~= 1 do
		hl.dispatch(hl.dsp.group.move_window({ forward = false }))
	end
end

-- Handle output of lua commands and dispatch actions
local function run(func)
	local result = func()
	if result ~= nil then
		hl.dispatch(result)
	end
end

hy4 = {
	focus_left = function()
		run(focus_left)
	end,
	focus_right = function()
		run(focus_right)
	end,
	move_left = function()
		run(move_left)
	end,
	move_right = function()
		run(move_right)
	end,
}

local mainMod = "SUPER"
local shiftMod = "SUPER + SHIFT"

-- binds.lua maps these to plain focus/move, and hyprland runs every bind
-- that matches a key, so drop those before replacing them
hl.unbind(mainMod .. " + LEFT")
hl.unbind(mainMod .. " + RIGHT")
hl.unbind(shiftMod .. " + LEFT")
hl.unbind(shiftMod .. " + RIGHT")

hl.bind(mainMod .. " + LEFT", hy4.focus_left)
hl.bind(mainMod .. " + RIGHT", hy4.focus_right)
hl.bind(shiftMod .. " + LEFT", hy4.move_left)
hl.bind(shiftMod .. " + RIGHT", hy4.move_right)
