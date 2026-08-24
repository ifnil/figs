pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

// Shows the active hyprland submap name; hidden when none.
ModuleBox {
	id: root

	property color accentColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	property string submap: ""

	Layout.alignment: Qt.AlignVCenter
	visible: submap !== ""

	Text {
		text: root.submap
		color: root.accentColor

		font {
			family: root.fontFamily
			pixelSize: root.fontSize
		}
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
