import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: volRoot;

	// Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			volRoot.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: volRoot.shouldShowOsd = false
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: volRoot.shouldShowOsd

		PanelWindow {
			anchors.top: true
			anchors.right: true
			margins.top: screen.height / 5

			implicitWidth: 400
			implicitHeight: 10
			mask: Region {}

			color: "transparent"

			Rectangle {
        anchors {
          right: parent.right;
          left: parent.left;
          top: parent.top;
        }

				radius: height / 2
				color: "#80000000"

				RowLayout {workspaces
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

					Rectangle {
            implicitWidth: 100;
						implicitHeight: 10
						radius: 20
						color: "#50ffffff"

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}

							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}

