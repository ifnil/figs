pragma ComponentBehavior: Bound

import Quickshell.I3
import QtQuick

Row {
	id: root

	property color activeColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	spacing: 5

	Repeater {
		model: I3.workspaces

		Rectangle {
			required property var modelData

			property bool isActive: modelData.focused
			property bool isUrgent: modelData.urgent ?? false
			property var activeIcons: ["󰲠", "󰲢", "󰲤", "󰲦", "󰲨", "󰲪", "󰲬", "󰲮", "󰲰", "󰲳"]

			implicitWidth: label.implicitWidth + 6
			implicitHeight: isActive ? label.implicitHeight + 4 : label.implicitHeight + 6

			color: isUrgent ? "#6c303b" : "transparent"

			Text {
				id: label
				anchors.centerIn: parent

				text: parent.isActive ? parent.activeIcons[parent.modelData.number - 1] : parent.modelData.number
				color: parent.isActive ? root.activeColor : "#ffffff"
				opacity: parent.isActive ? 1.0 : 0.3

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
