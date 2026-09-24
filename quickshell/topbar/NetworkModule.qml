pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell.Networking
import QtQuick

ModuleBox {
	id: root

	property string wiredAddress: ""

	readonly property var devices: Networking.devices.values ?? []
	readonly property var wiredDevice: devices.find(device => device.type === DeviceType.Wired && device.connected)
	readonly property bool wifiConnected: devices.some(device => device.type === DeviceType.Wifi && device.networks.values.some(network => network.connected))
	readonly property string status: {
		if (wiredDevice)
			return wiredAddress.length > 0 ? wiredAddress + " 󰊗" : "󰊗";
		if (wifiConnected)
			return "";
		return "󰤯";
	}

	function refreshWiredAddress() {
		if (!wiredDevice) {
			wiredAddress = "";
			return;
		}

		addressProcess.exec(["ip", "-j", "addr", "show", "dev", wiredDevice.name]);
	}

	function updateWiredAddress(text) {
		const links = JSON.parse(text);
		const address = (links[0]?.addr_info ?? []).find(info => info.family === "inet");
		wiredAddress = address ? address.local + "/" + address.prefixlen : "";
	}

	onWiredDeviceChanged: refreshWiredAddress()
	Component.onCompleted: refreshWiredAddress()
	onClicked: menuProcess.startDetached()

	BarText {
		padding: 3
		text: root.status
	}

	Process {
		id: addressProcess
		stdout: StdioCollector {
			waitForEnd: true
			onStreamFinished: root.updateWiredAddress(text)
		}
	}

	Process {
		id: menuProcess
		command: ["kitty", "nmtui"]
	}
}
