import Quickshell
import Quickshell.Widgets
import QtQuick

ClippingWrapperRectangle {
	default property alias content: inner.data

	property color bg: "#000"
	property int marginLeft: 6
	property int marginRight: 6
	property int marginTop: 2
	property int marginBottom: 3

	color: bg
	radius: 4

	leftMargin: marginLeft
	rightMargin: marginRight
	topMargin: marginTop
	bottomMargin: marginBottom

	// border.width: 1
	// border.color: "#0db9d7"
	// border.pixelAligned: true

	implicitWidth: inner.implicitWidth + 16

	Column {
		id: inner
		anchors.centerIn: parent
		spacing: 5
	}
}
