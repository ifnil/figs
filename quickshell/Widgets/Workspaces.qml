import QtQuick;
import QtQuick.Layouts;
import Quickshell;
import Quickshell.I3;

Repeater {
  model: 9; // or set to number

  Rectangle {
    property var ws: I3.focusedWorkspace?.number;
    property var isActive: ws === (index + 1);

    width: 20;
    height: parent.height;
    radius: 5;

    color: isActive ? theme.green : "transparent";
    border {
      color: isActive ? theme.green : "transparent";
    }

    Text {
      anchors.centerIn: parent;
      text: index + 1;
      padding: 5;

      font {
        family: theme.fontFamily;
        pixelSize: 14;
      }

      color: isActive ? theme.bg : theme.fg;
      MouseArea {
        anchors.fill: parent
        onClicked: I3.dispatch("workspace " + (index + 1))
      }
    }
  }
}
