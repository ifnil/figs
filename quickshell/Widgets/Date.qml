import Quickshell;
import Quickshell.Io;
import QtQuick;
import QtQuick.Layouts;

Rectangle {
  implicitWidth: 100;
  radius: 5;

  Layout.minimumHeight: parent.height;
  color: theme.green;

  Text {
    id: date;

    font {
      family: theme.fontFamily;
      pixelSize: 14;
    }

    anchors {
      centerIn: parent;
    }

    Process {
      id: dateProc;
      running: true;
      command: ["date", "+%a %b %d"];

      stdout: StdioCollector {
        onStreamFinished: date.text = this.text;
      }
    }

    Timer {
      interval: 1000;
      running: true;
      repeat: true;
      onTriggered: dateProc.running = true;
    }
  }
}
