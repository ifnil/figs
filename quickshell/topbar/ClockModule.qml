pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
	id: root

	property color bgColor: "#000"
	property color fontColor: "#fff"
	property color accentColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14

	property date now: new Date()
	property bool hovered: false
	property bool calendarOpen: false
	readonly property int calendarYear: now.getFullYear()
	readonly property int calendarMonth: now.getMonth()
	readonly property int firstMonthDay: new Date(calendarYear, calendarMonth, 1).getDay()
	readonly property int daysInMonth: new Date(calendarYear, calendarMonth + 1, 0).getDate()
	readonly property string timeText: Qt.formatDateTime(now, "HH:mm")
	readonly property string dateText: Qt.formatDateTime(now, "ddd MMM d")
	readonly property string monthText: Qt.formatDateTime(new Date(calendarYear, calendarMonth, 1), "MMMM yyyy")

	implicitWidth: box.implicitWidth
	implicitHeight: box.implicitHeight
	Layout.alignment: Qt.AlignVCenter

	function calendarDay(cellIndex) {
		const day = cellIndex - firstMonthDay + 1;
		return day > 0 && day <= daysInMonth ? day : 0;
	}

	function isToday(day) {
		return day === now.getDate();
	}

	ModuleBox {
		id: box
		anchors.fill: parent

		Rectangle {
			id: timeContainer

			color: "transparent"
			implicitWidth: Math.max(timeMetrics.width, dateMetrics.width) + 6
			implicitHeight: clock.implicitHeight + 6

			TextMetrics {
				id: timeMetrics
				font: clock.font
				text: root.timeText
			}

			TextMetrics {
				id: dateMetrics
				font: clock.font
				text: root.dateText
			}

			Text {
				id: clock

				color: root.fontColor
				anchors.centerIn: parent
				text: root.hovered ? root.dateText : root.timeText

				font {
					family: root.fontFamily
					pixelSize: root.fontSize
				}

				Timer {
					interval: 1000
					running: true
					repeat: true
					onTriggered: root.now = new Date()
				}
			}

			MouseArea {
				anchors.fill: parent
				hoverEnabled: true
				onEntered: root.hovered = true
				onExited: root.hovered = false
				onClicked: root.calendarOpen = !root.calendarOpen
			}
		}
	}
}
