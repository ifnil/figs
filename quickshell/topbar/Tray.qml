pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Row {
	id: root

	property int iconSize: 16

	spacing: 10
	Layout.alignment: Qt.AlignVCenter

	Repeater {
		model: SystemTray.items

		Item {
			id: entry
			required property SystemTrayItem modelData

			width: root.iconSize
			height: root.iconSize

			function openMenu() {
				if (modelData.hasMenu)
					menuAnchor.open();
			}

			IconImage {
				anchors.fill: parent
				source: entry.modelData.icon
				backer.fillMode: Image.PreserveAspectFit
			}

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

				onClicked: event => {
					if (event.button === Qt.LeftButton) {
						if (entry.modelData.onlyMenu)
							entry.openMenu();
						else
							entry.modelData.activate();
					} else if (event.button === Qt.MiddleButton) {
						entry.modelData.secondaryActivate();
					} else if (event.button === Qt.RightButton) {
						entry.openMenu();
					}
				}

				onWheel: event => entry.modelData.scroll(event.angleDelta.y, false)
			}

			QsMenuAnchor {
				id: menuAnchor
				menu: entry.modelData.menu
				anchor.item: entry
				anchor.rect.y: entry.height
			}
		}
	}
}
