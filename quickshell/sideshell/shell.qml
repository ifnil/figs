//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: root

	property color colBg: "#000"
	property color colFg: "#fff"
	property color colGreen: "#489c7a"

	property string fontFamily: "Tamzen"
	property color fontColor: colFg
	property int fontSize: 14

	property var batIcons: ["", "", "", "", ""]
	property var volIcons: [" ", " ", " "]

	implicitWidth: 25
	color: "transparent"

	anchors {
		top: true
		bottom: true
		left: true
	}

	ColumnLayout {
		Layout.alignment: Qt.AlignHCenter

		anchors.fill: parent

		Module {
			id: workspaces

			Repeater {
				model: Hyprland.workspaces

				Rectangle {
					required property var modelData

					property bool isActive: Hyprland.focusedWorkspace?.id == modelData.id
					property bool isUrgent: modelData.urgent ?? false

					Layout.alignment: Qt.AlignVCenter

					implicitWidth: workspaces.width
					implicitHeight: label.implicitHeight + 6

					color: isUrgent ? "#6c303b" : "transparent"

					Text {
						id: label
						anchors.centerIn: parent

						text: parent.modelData.id
						color: parent.isActive ? root.colGreen : "#ffffff"
						opacity: parent.isActive ? 1.0 : 0.3

						// text: parent.isActive ? "" : ""
						// color: root.colGreen

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
	}
}
