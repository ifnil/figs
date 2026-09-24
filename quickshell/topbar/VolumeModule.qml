pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

ModuleBox {
	id: root

	readonly property var volIcons: [" ", " ", " "]
	readonly property PwNode sink: Pipewire.defaultAudioSink
	readonly property var sinks: Pipewire.nodes.values.filter(node => node.isSink && !node.isStream && node.audio)
	readonly property real volume: sink?.audio.volume ?? 0.0
	readonly property int volpct: Math.round(volume * 100)
	readonly property string volicon: volpct > 60 ? volIcons[2] : volpct > 25 ? volIcons[1] : volIcons[0]

	function setVolume(value) {
		if (!sink?.audio)
			return;

		const nextVolume = Math.max(0, Math.min(1, value));
		sink.audio.volume = nextVolume;

		if (nextVolume > 0 && sink.audio.muted)
			sink.audio.muted = false;
	}

	function changeVolume(delta) {
		setVolume(volume + delta);
	}

	function nodeName(node) {
		return node.nickname || node.description || node.name;
	}

	onClicked: popup.open = !popup.open
	onWheel: event => {
		changeVolume(event.angleDelta.y > 0 ? 0.05 : -0.05);
		event.accepted = true;
	}

	PwObjectTracker {
		objects: [root.sink]
	}

	BarText {
		width: 18
		topPadding: 3
		bottomPadding: 3
		horizontalAlignment: Text.AlignHCenter
		text: root.volicon
	}

	BarText {
		topPadding: 3
		bottomPadding: 3
		text: root.volpct + "%"
	}

	BarPopup {
		id: popup

		target: root
		contentWidth: 220

		BarText {
			anchors.horizontalCenter: parent.horizontalCenter
			text: root.volicon + " " + root.volpct + "%"
		}

		Item {
			id: slider

			function updateVolumeFromPosition(x) {
				root.setVolume(x / width);
			}

			width: parent.width
			height: 18

			Rectangle {
				anchors.verticalCenter: parent.verticalCenter
				width: parent.width
				height: 6
				radius: 3
				color: Theme.border

				Rectangle {
					width: parent.width * Math.max(0, Math.min(1, root.volume))
					height: parent.height
					radius: parent.radius
					color: Theme.accent
				}
			}

			Rectangle {
				width: 12
				height: 12
				radius: 6
				color: Theme.fg
				x: Math.max(0, Math.min(slider.width - width, slider.width * root.volume - width / 2))
				anchors.verticalCenter: parent.verticalCenter
			}

			MouseArea {
				anchors.fill: parent
				onPressed: event => slider.updateVolumeFromPosition(event.x)
				onPositionChanged: event => {
					if (pressed)
						slider.updateVolumeFromPosition(event.x);
				}
			}
		}

		// Output picker; only shown when there is more than one sink.
		Column {
			width: parent.width
			spacing: 2
			visible: root.sinks.length > 1

			Rectangle {
				width: parent.width
				height: 1
				color: Theme.border
			}

			Item {
				width: 1
				height: 4
			}

			Repeater {
				model: root.sinks

				Rectangle {
					id: output

					required property PwNode modelData
					readonly property bool active: modelData === root.sink

					width: parent.width
					height: label.implicitHeight + 6
					radius: 3
					color: active ? Theme.accent : outputMouse.containsMouse ? Theme.border : "transparent"

					BarText {
						id: label

						anchors {
							left: parent.left
							right: parent.right
							verticalCenter: parent.verticalCenter
							leftMargin: 6
							rightMargin: 6
						}

						elide: Text.ElideRight
						color: output.active ? Theme.bg : Theme.fg
						text: root.nodeName(output.modelData)
					}

					MouseArea {
						id: outputMouse

						anchors.fill: parent
						hoverEnabled: true
						onClicked: Pipewire.preferredDefaultAudioSink = output.modelData
					}
				}
			}
		}
	}
}
