import Quickshell
import Quickshell.Widgets
import QtQuick

WrapperRectangle {
	property color bg: "#000"
	default property alias content: inner.data

	color: bg
	radius: 4

	leftMargin: 6
	rightMargin: 6
	topMargin: 2
	bottomMargin: 3

	// implicitWidth: inner.implicitWidth + 16
	// implicitHeight: inner.implicitHeight + 4

	Row {
		id: inner
		anchors.centerIn: parent
		spacing: 5
	}
}
