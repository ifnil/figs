import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland

ShellRoot {
    id: root

    Theme {
        id: uiTheme
    }
    SystemStats {
        id: systemStats
    }
    HyprStatus {
        id: hyprStatus
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: "transparent"

            margins {
                top: 0
                bottom: 0
                left: 0
                right: 0
            }

            PanelContent {
                anchors.fill: parent
                theme: uiTheme
                stats: systemStats
                hypr: hyprStatus
            }
        }
    }
}
