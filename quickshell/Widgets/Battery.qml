import Quickshell;
import Quickshell.Io;
import QtQuick;
import QtQuick.Layouts;

Rectangle {
  implicitWidth: 60;
  radius: 5;

  Layout.minimumHeight: parent.height;
  color: theme.green;

  Text {
    id: battery;

    font {
      family: theme.fontFamily;
      pixelSize: 14;
    }

    anchors {
      centerIn: parent;
    }

    Process {
      id: batteryProc;
      command: ["cat", "/sys/class/power_supply/BAT0/capacity"];
      running: true;

      stdout: StdioCollector {
        onStreamFinished: battery.text = this.text;
      }
    }

    Timer {
      interval: 1000;
      running: true;
      repeat: true;
      onTriggered: batteryProc.running = true;
    }
  }
}
