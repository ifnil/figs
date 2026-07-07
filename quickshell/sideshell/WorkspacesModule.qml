import Quickshell
import QtQuick

// Picks the compositor-specific workspace list at runtime so the same
// config works under both hyprland and sway.
Module {
	id: root

	property color activeColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	readonly property bool isSway: !!Quickshell.env("SWAYSOCK")

	Loader {
		source: root.isSway ? "SwayWorkspaces.qml" : "HyprWorkspaces.qml"
		onLoaded: {
			item.activeColor = Qt.binding(() => root.activeColor);
			item.fontFamily = Qt.binding(() => root.fontFamily);
			item.fontSize = Qt.binding(() => root.fontSize);
		}
	}
}
