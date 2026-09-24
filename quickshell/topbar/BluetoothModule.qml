pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQuick

ModuleBox {
	id: root

	property string menuScript: Quickshell.shellDir + "/../waybar/scripts/bluetooth-menu.sh"

	readonly property var adapter: Bluetooth.defaultAdapter
	readonly property int connectedCount: (Bluetooth.devices.values ?? []).filter(device => device.connected).length
	readonly property string status: {
		if (!adapter)
			return "unavailable";
		if (adapter.state === BluetoothAdapterState.Blocked)
			return "blocked";
		if (!adapter.enabled)
			return "off";
		if (connectedCount > 0)
			return "connected";
		return "on";
	}

	onClicked: menuProcess.startDetached()

	BarText {
		padding: 3
		text: " " + root.status
	}

	Process {
		id: menuProcess
		command: ["kitty", root.menuScript]
	}
}
