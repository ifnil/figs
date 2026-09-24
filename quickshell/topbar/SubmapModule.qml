pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick

// Shows the active hyprland submap name; hidden when none.
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
		target: Hyprland

		function onRawEvent(event) {
			if (event.name !== "submap")
				return;

			// data is the submap name, empty string on reset
			root.submap = event.data;
		}
	}
}
