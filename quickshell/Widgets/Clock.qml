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
    id: clock;

    font {
      family: theme.fontFamily;
      pixelSize: 14;
    }

    anchors {
      centerIn: parent;
    }

    Process {
      id: clockProc;
      command: ["date", "+%H:%M"];
      running: true;

      stdout: StdioCollector {
        onStreamFinished: clock.text = this.text;
      }
    }

    Timer {
      interval: 1000;
      running: true;
      repeat: true;
      onTriggered: clockProc.running = true;
    }
  }
}
