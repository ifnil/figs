import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

// Rounded box every bar module lives in. Content is laid out in a Row;
// clicks, scrolls and hover on it are exposed as signals.
WrapperRectangle {
	id: root

	default property alias content: inner.data
	readonly property alias hovered: mouseArea.containsMouse

	signal clicked(var event)
	signal wheel(var event)

	color: Theme.bg
	radius: 4
	Layout.alignment: Qt.AlignVCenter

	leftMargin: 6
	rightMargin: 6
	topMargin: 2
	bottomMargin: 3

	// The wrapper only manages a single visual child, so the MouseArea is that
	// child and holds the content. Interactive content (tray icons, workspaces)
	// sits above it and gets its own clicks first.
	MouseArea {
		id: mouseArea

		implicitWidth: inner.implicitWidth
		implicitHeight: inner.implicitHeight
		hoverEnabled: true
		onClicked: event => root.clicked(event)
		onWheel: event => {
			event.accepted = false;
			root.wheel(event);
		}

		Row {
			id: inner
			spacing: 5
		}
	}
}
