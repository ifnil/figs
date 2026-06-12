pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQuick

Rectangle {
	id: root

	property color fontColor: "#fff"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	property string menuScript: Quickshell.shellDir + "/../waybar/scripts/bluetooth-menu.sh"

	readonly property var adapter: Bluetooth.defaultAdapter
	readonly property var devices: Bluetooth.devices.values ?? []
	readonly property int connectedCount: devices.filter(device => device.connected).length
	readonly property bool hasAdapter: adapter !== null
	readonly property string status: {
		if (!hasAdapter)
			return "unavailable";
		if (adapter.state === BluetoothAdapterState.Blocked)
			return "blocked";
		if (!adapter.enabled)
			return "off";
		if (connectedCount > 0)
			return "connected";
		return "on";
	}

	color: "transparent"
	implicitWidth: bluetoothText.implicitWidth + 6
	implicitHeight: bluetoothText.implicitHeight + 6

	Text {
		id: bluetoothText

		anchors.centerIn: parent
		color: root.fontColor
		text: " " + root.status

		font {
			family: root.fontFamily
			pixelSize: root.fontSize
		}
	}

	MouseArea {
		anchors.fill: parent
		onClicked: menuProcess.startDetached()
	}

	Process {
		id: menuProcess
		command: ["kitty", root.menuScript]
	}
}
