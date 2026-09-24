pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

ModuleBox {
	id: root

	property date now: new Date()
	readonly property int calendarYear: now.getFullYear()
	readonly property int calendarMonth: now.getMonth()
	readonly property int firstMonthDay: new Date(calendarYear, calendarMonth, 1).getDay()
	readonly property int daysInMonth: new Date(calendarYear, calendarMonth + 1, 0).getDate()
	readonly property string timeText: Qt.formatDateTime(now, "HH:mm")
	readonly property string dateText: Qt.formatDateTime(now, "ddd MMM d")
	readonly property string monthText: Qt.formatDateTime(new Date(calendarYear, calendarMonth, 1), "MMMM yyyy")

	function calendarDay(cellIndex) {
		const day = cellIndex - firstMonthDay + 1;
		return day > 0 && day <= daysInMonth ? day : 0;
	}

	onClicked: calendar.open = !calendar.open

	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: root.now = new Date()
	}

	TextMetrics {
		id: dateMetrics
		font: clock.font
		text: root.dateText
	}

	Item {
		implicitWidth: Math.max(clock.implicitWidth, dateMetrics.width) + 6
		implicitHeight: clock.implicitHeight + 6

		BarText {
			id: clock

			anchors.centerIn: parent
			text: root.hovered ? root.dateText : root.timeText
		}
	}

	BarPopup {
		id: calendar

		target: root
		contentWidth: 198

		BarText {
			anchors.horizontalCenter: parent.horizontalCenter
			text: root.monthText
		}

		Grid {
			anchors.horizontalCenter: parent.horizontalCenter
			columns: 7
			columnSpacing: 4
			rowSpacing: 4

			Repeater {
				model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

				BarText {
					required property string modelData

					width: 24
					height: 18
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					color: Theme.accent
					font.pixelSize: Theme.fontSize - 2
					text: modelData
				}
			}

			Repeater {
				model: 42

				Rectangle {
					id: cell

					required property int index
					readonly property int day: root.calendarDay(index)
					readonly property bool today: day === root.now.getDate()

					width: 24
					height: 20
					radius: 3
					color: today ? Theme.accent : "transparent"

					BarText {
						anchors.centerIn: parent
						visible: cell.day > 0
						color: cell.today ? Theme.bg : Theme.fg
						font.pixelSize: Theme.fontSize - 1
						text: cell.day
					}
				}
			}
		}
	}
}
