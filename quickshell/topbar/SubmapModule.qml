pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.I3
import QtQuick

// Shows the active hyprland submap or sway mode name; hidden when none.
ModuleBox {
	id: root

	property string submap: ""

	visible: submap !== ""

	BarText {
		padding: 3
		color: Theme.accent
		text: root.submap
	}

	Connections {
		target: Compositor.isSway ? null : Hyprland

		function onRawEvent(event) {
			if (event.name !== "submap")
				return;

			// data is the submap name, empty string on reset
			root.submap = event.data;
		}
	}

	I3IpcListener {
		subscriptions: Compositor.isSway ? ["mode"] : []

		onIpcEvent: event => {
			if (event.type !== "mode")
				return;

			// sway reports leaving a mode as entering "default"
			const mode = JSON.parse(event.data).change;
			root.submap = mode === "default" ? "" : mode;
		}
	}
}
