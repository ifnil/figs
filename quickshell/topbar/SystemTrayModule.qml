pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

ModuleBox {
	id: root

	property int iconSize: 14

	Layout.alignment: Qt.AlignVCenter
	visible: SystemTray.items.values.length > 0

	Rectangle {
		color: "transparent"
		implicitWidth: tray.implicitWidth
		implicitHeight: tray.implicitHeight + 6

		Tray {
			id: tray
			anchors.centerIn: parent
			iconSize: root.iconSize
		}
	}
}
