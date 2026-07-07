pragma ComponentBehavior: Bound

import Quickshell.I3
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

	function updateFromInputs(text) {
		const inputs = JSON.parse(text);
		const keyboard = inputs.find(input => input.type === "keyboard" && input.xkb_active_layout_name);

		if (!keyboard)
			return;

		root.layout = shortLayout(keyboard.xkb_active_layout_name);
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
		onClicked: I3.dispatch("input type:keyboard xkb_switch_layout next")
	}

	I3IpcListener {
		subscriptions: ["input"]
		onIpcEvent: event => {
			const data = JSON.parse(event.data);

			if (data.change !== "xkb_layout")
				return;

			const name = data.input?.xkb_active_layout_name;
			if (name)
				root.layout = root.shortLayout(name);
		}
	}

	Process {
		id: refreshProcess
		command: ["swaymsg", "-t", "get_inputs", "-r"]
		stdout: StdioCollector {
			waitForEnd: true
			onStreamFinished: root.updateFromInputs(text)
		}
	}
}
