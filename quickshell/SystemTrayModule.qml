import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Item {
    id: root

    property QtObject theme
    readonly property bool hasItems: SystemTray.items && SystemTray.items.values && SystemTray.items.values.length > 0
    property int iconSize: theme ? Math.round(theme.fontSize + 2) : 16

    implicitHeight: iconSize
    implicitWidth: trayRow.implicitWidth
    visible: hasItems

    RowLayout {
        id: trayRow
        anchors.fill: parent
        spacing: 6

        Repeater {
            model: SystemTray.items && SystemTray.items.values ? SystemTray.items.values : []

            delegate: Item {
                id: trayItem
                width: root.iconSize
                height: root.iconSize
                visible: modelData.icon !== ""
                Layout.alignment: Qt.AlignVCenter

                IconImage {
                    anchors.fill: parent
                    implicitSize: root.iconSize
                    source: modelData.icon ? Quickshell.iconPath(modelData.icon, modelData.icon) : ""
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    hoverEnabled: true

                    onClicked: function(mouse) {
                        if (mouse.button === Qt.MiddleButton) {
                            modelData.secondaryActivate()
                            return
                        }

                        if (mouse.button === Qt.RightButton || modelData.onlyMenu) {
                            if (modelData.hasMenu) {
                                var point = trayItem.mapToItem(null, mouse.x, mouse.y)
                                modelData.display(root.window, Math.round(point.x), Math.round(point.y))
                            } else {
                                modelData.secondaryActivate()
                            }
                            return
                        }

                        modelData.activate()
                    }

                    onWheel: function(wheel) {
                        var useHorizontal = Math.abs(wheel.angleDelta.x) > Math.abs(wheel.angleDelta.y)
                        var delta = useHorizontal ? wheel.angleDelta.x : wheel.angleDelta.y
                        modelData.scroll(delta, useHorizontal)
                    }
                }
            }
        }
    }
}
