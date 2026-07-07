pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Rectangle {
	id: root

	property color fontColor: "#fff"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
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
		root.layout = shortLayout(layouts[keyboard.active_layout_index] ?? keyboard.active_keymap);
	}

	color: "transparent"
	implicitWidth: languageText.implicitWidth + 6
	implicitHeight: languageText.implicitHeight + 6

	Component.onCompleted: refreshProcess.running = true

	Text {
		id: languageText

		anchors.centerIn: parent
		color: root.fontColor
		text: "󰌌  " + root.layout

		font {
			family: root.fontFamily
			pixelSize: root.fontSize
		}
	}

	MouseArea {
		anchors.fill: parent
		onClicked: switchProcess.startDetached()
	}

	Connections {
		function onRawEvent(event) {
			if (event.name !== "activelayout")
				return;

			const data = event.parse(2);
			root.layout = root.shortLayout(data[1] ?? data[0]);
		}

		target: Hyprland
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
