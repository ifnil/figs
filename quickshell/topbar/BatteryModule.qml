pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick

ModuleBox {
	id: root

	readonly property var batIcons: ["", "", "", "", ""]
	readonly property var bat: UPower.displayDevice
	readonly property int pct: Math.round(bat.percentage * 100)
	readonly property bool low: pct <= 35

	visible: bat.isLaptopBattery

	Rectangle {
		color: root.low ? Theme.warning : "transparent"
		implicitWidth: batteryText.implicitWidth + 6
		implicitHeight: batteryText.implicitHeight + 6

		BarText {
			id: batteryText

			anchors.centerIn: parent
			color: root.low ? Theme.bg : Theme.fg
			text: root.batIcons[Math.min(4, Math.floor(root.pct / 20))] + "  " + root.pct + "%"
		}
	}
}
