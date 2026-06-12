pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell.Networking
import QtQuick

Rectangle {
	id: root

	property color fontColor: "#fff"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	property string wiredAddress: ""

	readonly property var devices: Networking.devices.values ?? []
	readonly property var wiredDevice: devices.find(device => device.type === DeviceType.Wired && device.connected)
	readonly property var wifiDevice: devices.find(device => device.type === DeviceType.Wifi && device.networks.values.some(network => network.connected))
	readonly property bool wiredConnected: wiredDevice !== undefined
	readonly property bool wifiConnected: wifiDevice !== undefined
	readonly property string status: {
		if (wiredConnected)
			return wiredAddress.length > 0 ? wiredAddress + " 󰊗" : "󰊗";
		if (wifiConnected)
			return "";
		return "󰤯";
	}

	function refreshWiredAddress() {
		if (!wiredConnected) {
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

	color: "transparent"
	implicitWidth: networkText.implicitWidth + 6
	implicitHeight: networkText.implicitHeight + 6

	onWiredConnectedChanged: refreshWiredAddress()
	onWiredDeviceChanged: refreshWiredAddress()
	Component.onCompleted: refreshWiredAddress()

	Text {
		id: networkText

		anchors.centerIn: parent
		color: root.fontColor
		text: root.status

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
