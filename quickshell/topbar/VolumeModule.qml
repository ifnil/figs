pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Item {
	id: root

	property color bgColor: "#000"
	property color fontColor: "#fff"
	property color accentColor: "#489c7a"
	property string fontFamily: "Tamzen"
	property int fontSize: 14
	readonly property var volIcons: [" ", " ", " "]
	readonly property PwNode sink: Pipewire.defaultAudioSink
	property bool sliderOpen: false
	property real volume: sink?.audio.volume ?? 0.0

	property var volpct: Math.round(volume * 100)
	property var volicon: volpct > 60 ? root.volIcons[2] : (volpct > 25) ? root.volIcons[1] : root.volIcons[0]

	implicitWidth: box.implicitWidth
	implicitHeight: box.implicitHeight
	Layout.alignment: Qt.AlignVCenter

	function setVolume(value) {
		if (!sink?.audio)
			return;

		const nextVolume = Math.max(0, Math.min(1, value));
		sink.audio.volume = nextVolume;

		if (nextVolume > 0 && sink.audio.muted)
			sink.audio.muted = false;
	}

	function changeVolume(delta) {
		setVolume((sink?.audio.volume ?? 0.0) + delta);
	}

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	ModuleBox {
		id: box
		anchors.fill: parent

		Rectangle {
			id: volumeBox

			color: "transparent"
			implicitWidth: volumeLabel.implicitWidth + volumeIcon.implicitWidth
			implicitHeight: volumeLabel.implicitHeight + 6

			Row {
				anchors.centerIn: parent

				Text {
					id: volumeIcon

					width: 18
					horizontalAlignment: Text.AlignHCenter
					color: root.fontColor
					text: root.volicon + " "

					font {
						family: root.fontFamily
						pixelSize: root.fontSize
					}
				}

				Text {
					id: volumeLabel

					horizontalAlignment: Text.AlignRight
					color: root.fontColor
					text: root.volpct + "%"

					font {
						family: root.fontFamily
						pixelSize: root.fontSize
					}
				}
			}

			MouseArea {
				anchors.fill: parent
				onClicked: root.sliderOpen = !root.sliderOpen
				onWheel: event => {
					root.changeVolume(event.angleDelta.y > 0 ? 0.05 : -0.05);
					event.accepted = true;
				}
			}
		}
	}
}
