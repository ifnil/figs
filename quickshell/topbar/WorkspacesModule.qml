pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.I3
import QtQuick

ModuleBox {
	Repeater {
		model: Compositor.isSway ? I3.workspaces : Hyprland.workspaces

		Rectangle {
			id: workspace

			// HyprlandWorkspace or I3Workspace; both have urgent and activate().
			required property var modelData
			readonly property bool active: Compositor.isSway ? modelData.focused : Hyprland.focusedWorkspace?.id === modelData.id

			implicitWidth: label.implicitWidth + 6
			implicitHeight: label.implicitHeight + 6
			color: modelData.urgent ? Theme.urgent : "transparent"

			BarText {
				id: label

				anchors.centerIn: parent
				color: workspace.active ? Theme.accent : Theme.fg
				opacity: workspace.active ? 1.0 : 0.3
				text: Compositor.isSway ? workspace.modelData.name : workspace.modelData.id
			}

			MouseArea {
				anchors.fill: parent
				onClicked: workspace.modelData.activate()
			}
		}
	}
}
