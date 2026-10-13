pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.I3
import Quickshell.Io
import QtQuick

ModuleBox {
	id: root

	property string layout: "en"

	function shortLayout(value) {
		const lower = value.toLowerCase();

		if (lower.includes("english") || lower === "us")
			return "en";
		if (lower.includes("russian") || lower === "ru")
			return "ru";

		return lower.slice(0, 2);
	}

	function updateFromDevices(text) {
		const devices = JSON.parse(text);
		const keyboard = devices.keyboards.find(device => device.main) ?? devices.keyboards[0];

		if (!keyboard)
			return;

		const layouts = keyboard.layout.split(",");
		layout = shortLayout(layouts[keyboard.active_layout_index] ?? keyboard.active_keymap);
	}

	// sway has no main keyboard; `input type:keyboard` keeps them all in sync.
	function updateFromInputs(text) {
		const keyboard = JSON.parse(text).find(input => input.type === "keyboard");

		if (keyboard)
			layout = shortLayout(keyboard.xkb_active_layout_name);
	}

	onClicked: switchProcess.startDetached()
	Component.onCompleted: refreshProcess.running = true

	BarText {
		padding: 3
		text: "󰌌  " + root.layout
	}

	Connections {
		target: Compositor.isSway ? null : Hyprland

		function onRawEvent(event) {
			if (event.name !== "activelayout")
				return;

			const data = event.parse(2);
			root.layout = root.shortLayout(data[1] ?? data[0]);
		}
	}

	I3IpcListener {
		subscriptions: Compositor.isSway ? ["input"] : []

		onIpcEvent: event => {
			if (event.type !== "input")
				return;

			// xkb_keymap fires on config reload, which also resets the layout
			const data = JSON.parse(event.data);
			if (data.input.type === "keyboard" && data.change.startsWith("xkb_"))
				root.layout = root.shortLayout(data.input.xkb_active_layout_name);
		}
	}

	Process {
		id: refreshProcess
		command: Compositor.isSway ? ["swaymsg", "-r", "-t", "get_inputs"] : ["hyprctl", "devices", "-j"]
		stdout: StdioCollector {
			waitForEnd: true
			onStreamFinished: Compositor.isSway ? root.updateFromInputs(text) : root.updateFromDevices(text)
		}
	}

	Process {
		id: switchProcess
		command: Compositor.isSway ? ["swaymsg", "input", "type:keyboard", "xkb_switch_layout", "next"] : ["hyprctl", "switchxkblayout", "all", "next"]
	}
}
