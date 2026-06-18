pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ModuleBox {
	id: root

	property color activeColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	Layout.alignment: Qt.AlignVCenter

	Repeater {
		model: Hyprland.workspaces

		Rectangle {
			required property var modelData

			property bool isActive: Hyprland.focusedWorkspace?.id == modelData.id
			property bool isUrgent: modelData.urgent ?? false

			implicitWidth: label.implicitWidth + 6
			implicitHeight: label.implicitHeight + 6

			color: isUrgent ? "#6c303b" : "transparent"

			Text {
				id: label
				anchors.centerIn: parent

				text: parent.modelData.id
				color: parent.isActive ? root.activeColor : "#ffffff"
				opacity: parent.isActive ? 1.0 : 0.3

				// text: parent.isActive ? "" : ""
				// color: root.activeColor

				font {
					family: root.fontFamily
					pixelSize: root.fontSize
				}
			}

			MouseArea {
				anchors.fill: parent
				onClicked: parent.modelData.activate()
			}
		}
	}
}
