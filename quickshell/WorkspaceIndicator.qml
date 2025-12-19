import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    id: workspaceIndicator

    property int workspaceIndex: 0
    property QtObject theme

    Layout.preferredWidth: 20
    Layout.fillHeight: true
    color: "transparent"

    property var workspace: Hyprland.workspaces.values.find(ws => ws.id === workspaceIndex + 1) ?? null
    property bool isActive: Hyprland.focusedWorkspace?.id === (workspaceIndex + 1)
    property bool hasWindows: workspace !== null

    Text {
        text: workspaceIndex + 1
        color: workspaceIndicator.isActive ? theme.colCyan : (workspaceIndicator.hasWindows ? theme.colCyan : theme.colMuted)
        font.pixelSize: theme.fontSize
        font.family: theme.fontFamily
        font.bold: true
        anchors.centerIn: parent
    }

    Rectangle {
        width: 20
        height: 3
        color: workspaceIndicator.isActive ? theme.colPurple : "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + (workspaceIndex + 1))
    }
}
