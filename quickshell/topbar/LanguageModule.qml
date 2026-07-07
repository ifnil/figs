import Quickshell
import QtQuick

// Picks the compositor-specific layout indicator at runtime so the same
// config works under both hyprland and sway.
Loader {
	id: root

	property color fontColor: "#fff"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	readonly property bool isSway: !!Quickshell.env("SWAYSOCK")

	source: isSway ? "SwayLanguage.qml" : "HyprLanguage.qml"
	onLoaded: {
		item.fontColor = Qt.binding(() => root.fontColor);
		item.fontFamily = Qt.binding(() => root.fontFamily);
		item.fontSize = Qt.binding(() => root.fontSize);
	}
}
