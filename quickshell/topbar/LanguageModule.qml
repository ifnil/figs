pragma ComponentBehavior: Bound

import Quickshell.Hyprland
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

	onClicked: switchProcess.startDetached()
	Component.onCompleted: refreshProcess.running = true

	BarText {
		padding: 3
		text: "󰌌  " + root.layout
	}

	Connections {
		target: Hyprland

		function onRawEvent(event) {
			if (event.name !== "activelayout")
				return;

			const data = event.parse(2);
			root.layout = root.shortLayout(data[1] ?? data[0]);
		}
	}

	Process {
		id: refreshProcess
		command: ["hyprctl", "devices", "-j"]
		stdout: StdioCollector {
			waitForEnd: true
			onStreamFinished: root.updateFromDevices(text)
		}
	}

	Process {
		id: switchProcess
		command: ["hyprctl", "switchxkblayout", "all", "next"]
	}
}
