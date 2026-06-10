pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

Row {
	id: root

	property int iconSize: 16
	spacing: 6

	Repeater {
		model: SystemTray.items

		Item {
			id: entry
			required property SystemTrayItem modelData

			width: root.iconSize
			height: root.iconSize
			anchors.verticalCenter: parent?.verticalCenter

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
						if (!entry.modelData.onlyMenu)
							entry.modelData.activate();
					} else if (event.button === Qt.MiddleButton) {
						entry.modelData.secondaryActivate();
					} else if (event.button === Qt.RightButton) {
						if (entry.modelData.hasMenu)
							menuAnchor.open();
					}
				}

				onWheel: event => entry.modelData.scroll(event.angleDelta.y, false)
			}

			QsMenuAnchor {
				id: menuAnchor
				menu: entry.modelData.menu
				anchor.window: QsWindow.window
				anchor.rect.x: entry.x
				anchor.rect.y: entry.y + entry.height
			}
		}
	}
}
