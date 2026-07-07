import Quickshell
import QtQuick
import QtQuick.Layouts

// Shows the active submap (hyprland) / mode (sway) name; hidden when none.
Loader {
	id: root

	property color accentColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	readonly property bool isSway: !!Quickshell.env("SWAYSOCK")

	Layout.alignment: Qt.AlignVCenter
	visible: item?.active ?? false

	source: isSway ? "SwaySubmap.qml" : "HyprSubmap.qml"
	onLoaded: {
		item.accentColor = Qt.binding(() => root.accentColor);
		item.fontFamily = Qt.binding(() => root.fontFamily);
		item.fontSize = Qt.binding(() => root.fontSize);
	}
}
