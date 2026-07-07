pragma ComponentBehavior: Bound

import Quickshell.I3
import Quickshell.Io
import QtQuick

ModuleBox {
	id: root

	property color accentColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	property string submap: ""

	readonly property bool active: submap !== "" && submap !== "default"

	Text {
		text: root.submap
		color: root.accentColor

		font {
			family: root.fontFamily
			pixelSize: root.fontSize
		}
	}

	I3IpcListener {
		subscriptions: ["mode"]
		onIpcEvent: event => {
			// first event may be the subscribe ack ({"success": true}) — no change field
			const name = JSON.parse(event.data).change;

			if (name === undefined)
				return;

			root.submap = name === "default" ? "" : name;
		}
	}

	// pick up a mode that was already active when the bar started
	Process {
		id: initialState
		running: true
		command: ["swaymsg", "-t", "get_binding_state", "-r"]
		stdout: StdioCollector {
			waitForEnd: true
			onStreamFinished: {
				const name = JSON.parse(text).name;
				root.submap = name === "default" ? "" : name;
			}
		}
	}
}
