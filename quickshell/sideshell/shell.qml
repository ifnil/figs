//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			id: root

			required property ShellScreen modelData

			property color colBg: "#000"
			property color colFg: "#fff"
			property color colGreen: "#489c7a"

			property string fontFamily: "Tamzen"
			property color fontColor: colFg
			property int fontSize: 14

			screen: modelData
			implicitWidth: 25
			color: "transparent"

			anchors {
				top: true
				bottom: true
				left: true
			}

			ColumnLayout {
				Layout.alignment: Qt.AlignVCenter
				anchors.fill: parent

				WorkspacesModule {
					activeColor: root.colGreen
					fontFamily: root.fontFamily
					fontSize: root.fontSize
				}
			}
		}
	}
}
