pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

ModuleBox {
	id: root

	property int iconSize: Theme.fontSize

	visible: SystemTray.items.values.length > 0

	Repeater {
		model: SystemTray.items

		Item {
			id: entry

			required property SystemTrayItem modelData

			width: root.iconSize
			height: root.iconSize + 6

			IconImage {
				anchors.centerIn: parent
				implicitSize: root.iconSize
				backer.fillMode: Image.PreserveAspectFit
				source: entry.modelData.icon
			}

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

				onClicked: event => {
					if (event.button === Qt.MiddleButton)
						entry.modelData.secondaryActivate();
					else if (event.button === Qt.RightButton || entry.modelData.onlyMenu)
						menuAnchor.open();
					else
						entry.modelData.activate();
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
