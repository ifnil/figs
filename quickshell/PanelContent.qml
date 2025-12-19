import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: panel

    property QtObject theme
    property QtObject stats
    property QtObject hypr

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Item {
                width: 8
            }
            Item {
                width: 8
            }

            Repeater {
                model: 9
                WorkspaceIndicator {
                    theme: panel.theme
                    workspaceIndex: index
                }
            }

            BarSeparator {
                separatorColor: theme.colMuted
                leftPad: 8
                rightPad: 8
            }

            Text {
                text: hypr.currentLayout
                color: theme.colFg
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
            }

            BarSeparator {
                separatorColor: theme.colMuted
                leftPad: 2
                rightPad: 8
            }

            Text {
                text: hypr.activeWindow
                color: theme.colPurple
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.fillWidth: true
                Layout.leftMargin: 8
                elide: Text.ElideRight
                maximumLineCount: 1
            }

            Text {
                text: stats.kernelVersion
                color: theme.colRed
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            Text {
                text: "BAT: " + stats.batteryPercent + "%"
                color: theme.colCyan
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            Text {
                text: "CPU: " + stats.cpuUsage + "%"
                color: theme.colYellow
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            Text {
                text: "Mem: " + stats.memUsage + "%"
                color: theme.colCyan
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            Text {
                text: "Disk: " + stats.diskUsage + "%"
                color: theme.colBlue
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            Text {
                text: "Vol: " + stats.volumeLevel + "%"
                color: theme.colPurple
                font.pixelSize: theme.fontSize
                font.family: theme.fontFamily
                font.bold: true
                Layout.rightMargin: 8
            }

            BarSeparator {
                separatorColor: theme.colMuted
                rightPad: 8
            }

            ClockLabel {
                theme: panel.theme
            }

            Item {
                width: 8
            }
        }
    }
}
