//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			required property ShellScreen modelData

			screen: modelData
			implicitHeight: 36
			color: "transparent"

			anchors {
				top: true
				left: true
				right: true
			}

			RowLayout {
				anchors.fill: parent
				anchors.margins: 6

				WorkspacesModule {}
				SubmapModule {}

				Item {
					Layout.fillWidth: true
				}

				SystemTrayModule {}
				NetworkModule {}
				LanguageModule {}
				BluetoothModule {}
				VolumeModule {}
				BatteryModule {}
				ClockModule {}
			}
		}
	}
}
