import Quickshell
import QtQuick

// Card-style popup dropped below a bar module. Toggle with `open`.
PopupWindow {
	id: root

	required property Item target
	property bool open: false
	property int contentWidth: 200
	default property alias content: body.data

	visible: open
	color: "transparent"
	grabFocus: true
	implicitWidth: card.implicitWidth
	implicitHeight: card.implicitHeight
	onClosed: open = false

	anchor.item: target
	anchor.rect.y: target.height + 6

	Rectangle {
		id: card

		color: Theme.bg
		border.color: Theme.border
		border.width: 1
		radius: 4
		implicitWidth: body.width + 20
		implicitHeight: body.implicitHeight + 20

		Column {
			id: body

			x: 10
			y: 10
			width: root.contentWidth
			spacing: 10
		}
	}
}
