pragma Singleton

import Quickshell
import QtQuick

Singleton {
	readonly property color bg: "#000"
	readonly property color fg: "#fff"
	readonly property color accent: "#489c7a"
	readonly property color border: "#333333"
	readonly property color warning: "#ddc7a1"
	readonly property color urgent: "#6c303b"

	readonly property string fontFamily: "Tamzen"
	readonly property int fontSize: 14
}
