//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
	id: root

	property color colBg: "#000"
	property color colFg: "#fff"
	property color colGreen: "#489c7a"

	property string fontFamily: "Tamzen"
	property color fontColor: colFg
	property int fontSize: 14

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

		WorkspacesModule {
			activeColor: root.colGreen
			fontFamily: root.fontFamily
			fontSize: root.fontSize
		}

		Item {
			Layout.fillWidth: true
		}

		SystemTrayModule {
			iconSize: root.fontSize
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

		VolumeModule {
			id: volumeModule

			bgColor: root.colBg
			fontColor: root.fontColor
			fontFamily: root.fontFamily
			fontSize: root.fontSize
			accentColor: root.colGreen
		}

		BatteryModule {
			fontColor: root.fontColor
			fontFamily: root.fontFamily
			fontSize: root.fontSize
		}

		ClockModule {
			id: clockModule

			bgColor: root.colBg
			fontColor: root.fontColor
			fontFamily: root.fontFamily
			fontSize: root.fontSize
			accentColor: root.colGreen
		}
	}

	PopupWindow {
		id: volumePopup

		visible: volumeModule.sliderOpen
		color: "transparent"
		implicitWidth: volumeCard.implicitWidth
		implicitHeight: volumeCard.implicitHeight
		grabFocus: true
		onClosed: volumeModule.sliderOpen = false

		anchor.window: root
		anchor.item: volumeModule
		anchor.rect.y: volumeModule.height + 6

		Rectangle {
			id: volumeCard

			color: root.colBg
			border.color: "#333333"
			border.width: 1
			radius: 4
			implicitWidth: 220
			implicitHeight: volumeContent.implicitHeight + 20

			Column {
				id: volumeContent

				anchors {
					left: parent.left
					right: parent.right
					top: parent.top
					margins: 10
				}

				spacing: 10

				Row {
					anchors.horizontalCenter: parent.horizontalCenter
					spacing: 8

					Text {
						color: root.fontColor
						text: volumeModule.volicon

						font {
							family: root.fontFamily
							pixelSize: root.fontSize
						}
					}

					Text {
						color: root.fontColor
						text: volumeModule.volpct + "%"

						font {
							family: root.fontFamily
							pixelSize: root.fontSize
						}
					}
				}

				Rectangle {
					id: volumeSlider

					anchors.horizontalCenter: parent.horizontalCenter
					width: 180
					height: 18
					color: "transparent"

					function updateVolumeFromPosition(x) {
						volumeModule.setVolume(x / width);
					}

					Rectangle {
						id: sliderTrack

						anchors.verticalCenter: parent.verticalCenter
						width: parent.width
						height: 6
						radius: 3
						color: "#333333"

						Rectangle {
							width: parent.width * Math.max(0, Math.min(1, volumeModule.volume))
							height: parent.height
							radius: parent.radius
							color: root.colGreen
						}
					}

					Rectangle {
						width: 12
						height: 12
						radius: 6
						color: root.fontColor
						x: Math.max(0, Math.min(volumeSlider.width - width, volumeSlider.width * volumeModule.volume - width / 2))
						anchors.verticalCenter: parent.verticalCenter
					}

					MouseArea {
						anchors.fill: parent
						onPressed: event => volumeSlider.updateVolumeFromPosition(event.x)
						onPositionChanged: event => {
							if (pressed)
								volumeSlider.updateVolumeFromPosition(event.x);
						}
					}
				}
			}
		}
	}

	PopupWindow {
		id: calendarPopup

		visible: clockModule.calendarOpen
		color: "transparent"
		implicitWidth: calendarCard.implicitWidth
		implicitHeight: calendarCard.implicitHeight
		grabFocus: true
		onClosed: clockModule.calendarOpen = false

		anchor.window: root
		anchor.item: clockModule
		anchor.rect.y: clockModule.height + 6

		Rectangle {
			id: calendarCard

			color: root.colBg
			border.color: "#333333"
			border.width: 1
			radius: 4
			implicitWidth: 218
			implicitHeight: calendarContent.implicitHeight + 20

			Column {
				id: calendarContent

				anchors {
					left: parent.left
					right: parent.right
					top: parent.top
					margins: 10
				}

				spacing: 8

				Text {
					anchors.horizontalCenter: parent.horizontalCenter
					color: root.fontColor
					text: clockModule.monthText

					font {
						family: root.fontFamily
						pixelSize: root.fontSize
					}
				}

				Grid {
					anchors.horizontalCenter: parent.horizontalCenter
					columns: 7
					columnSpacing: 4
					rowSpacing: 4

					Repeater {
						model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

						Text {
							required property string modelData

							width: 24
							height: 18
							horizontalAlignment: Text.AlignHCenter
							verticalAlignment: Text.AlignVCenter
							color: root.colGreen
							text: modelData

							font {
								family: root.fontFamily
								pixelSize: root.fontSize - 2
							}
						}
					}

					Repeater {
						model: 42

						Rectangle {
							required property int index

							readonly property int day: clockModule.calendarDay(index)

							width: 24
							height: 20
							radius: 3
							color: day > 0 && clockModule.isToday(day) ? root.colGreen : "transparent"

							Text {
								anchors.centerIn: parent
								color: parent.color === "transparent" ? root.fontColor : root.colBg
								opacity: parent.day > 0 ? 1.0 : 0.0
								text: parent.day

								font {
									family: root.fontFamily
									pixelSize: root.fontSize - 1
								}
							}
						}
					}
				}
			}
		}
	}
}
