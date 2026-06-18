pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

ModuleBox {
	id: root

	property color fontColor: "#fff"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	readonly property var batIcons: ["", "", "", "", ""]

	property var bat: UPower.displayDevice
	property int pct: Math.round(bat.percentage * 100)
	property bool charging: bat.state === UPowerDeviceState.Charging
	property bool critical: pct <= 15
	property bool warning: pct <= 35

	Layout.alignment: Qt.AlignVCenter
	visible: UPower.displayDevice.isLaptopBattery

	Rectangle {
		color: (root.critical || root.warning) ? "#ddc7a1" : "transparent"
		implicitWidth: batteryText.implicitWidth + 6
		implicitHeight: batteryText.implicitHeight + 6

		Text {
			id: batteryText

			anchors.centerIn: parent
			color: (root.critical || root.warning) ? "#ddc7a1" : root.fontColor
			text: root.batIcons[Math.min(4, Math.floor(root.pct / 20))] + "  " + root.pct + "%"

			font {
				family: root.fontFamily
				pixelSize: root.fontSize
			}
		}
	}
}
