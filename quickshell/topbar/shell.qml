//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray

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

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	anchors {
		top: true
		left: true
		right: true
	}

	implicitHeight: 36
	color: "transparent"

	RowLayout {
		Layout.alignment: Qt.AlignVCenter
		anchors.fill: parent
		anchors.margins: 6

		ModuleBox {
			id: workspaces

			Repeater {
				model: Hyprland.workspaces

				Rectangle {
					required property var modelData

					property bool isActive: Hyprland.focusedWorkspace?.id == modelData.id
					property bool isUrgent: modelData.urgent ?? false

					Layout.alignment: Qt.AlignVCenter

					implicitWidth: label.implicitWidth + 6
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

		Item {
			Layout.fillWidth: true
		}

		ModuleBox {
			visible: SystemTray.items.values.length > 0
			Rectangle {
				id: systemTrayBox

				color: "transparent"
				implicitWidth: tray.implicitWidth
				implicitHeight: tray.implicitHeight + 6

				Layout.alignment: Qt.AlignVCenter

				Tray {
					id: tray
					anchors.centerIn: parent
					iconSize: root.fontSize
				}
			}
		}

		ModuleBox {
			NetworkModule {
				fontColor: root.fontColor
				fontFamily: root.fontFamily
				fontSize: root.fontSize
			}
		}

		ModuleBox {
			LanguageModule {
				fontColor: root.fontColor
				fontFamily: root.fontFamily
				fontSize: root.fontSize
			}
		}

		ModuleBox {
			BluetoothModule {
				fontColor: root.fontColor
				fontFamily: root.fontFamily
				fontSize: root.fontSize
			}
		}

		ModuleBox {
			Rectangle {
				id: volumeBox
				readonly property PwNode sink: Pipewire.defaultAudioSink
				property real volume: sink?.audio.volume ?? 0.0

				property var volpct: Math.round(volume * 100)
				property var volicon: volpct > 60 ? root.volIcons[2] : (volpct > 25) ? root.volIcons[1] : root.volIcons[0]

				color: "transparent"
				implicitWidth: volumeLabel.implicitWidth + volumeIcon.implicitWidth
				implicitHeight: volumeLabel.implicitHeight + 6

				Row {
					anchors.centerIn: parent
					Text {
						id: volumeIcon
						width: 18
						horizontalAlignment: Text.AlignHCenter
						color: root.colFg

						text: volumeBox.volicon + " "

						font {
							family: root.fontFamily
							pixelSize: root.fontSize
						}
					}

					Text {
						id: volumeLabel
						horizontalAlignment: Text.AlignRight
						color: root.colFg

						text: volumeBox.volpct + "%"

						font {
							family: root.fontFamily
							pixelSize: root.fontSize
						}
					}
				}
			}
		}

		ModuleBox {
			id: batteryBox

			property var bat: UPower.displayDevice
			property int pct: Math.round(bat.percentage * 100)
			property bool charging: bat.state === UPowerDeviceState.Charging
			property bool critical: pct <= 15
			property bool warning: pct <= 35

			visible: UPower.displayDevice.isLaptopBattery

			Rectangle {
				color: (parent.critical || parent.warning) ? "#ddc7a1" : "transparent"
				implicitWidth: batteryText.implicitWidth + 6
				implicitHeight: batteryText.implicitHeight + 6

				Text {
					id: batteryText

					anchors.centerIn: parent
					color: (batteryBox.critical || batteryBox.warning) ? "#ddc7a1" : root.fontColor
					text: root.batIcons[Math.min(4, Math.floor(batteryBox.pct / 20))] + "  " + batteryBox.pct + "%"

					font {
						family: root.fontFamily
						pixelSize: root.fontSize
					}
				}
			}
		}

		ModuleBox {
			id: timeBox

			Rectangle {
				color: "transparent"
				implicitWidth: clock.implicitWidth + 6
				implicitHeight: clock.implicitHeight + 6

				Text {
					id: clock
					color: root.fontColor
					anchors.centerIn: parent

					text: Qt.formatDateTime(new Date(), "HH:mm")

					font {
						family: root.fontFamily
						pixelSize: root.fontSize
					}

					Timer {
						interval: 1000
						running: true
						repeat: true
						onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm")
					}
				}
			}
		}
	}
}
