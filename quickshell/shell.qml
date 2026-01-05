import Quickshell;
import Quickshell.Io;
import QtQuick;
import QtQuick.Layouts;
import Quickshell.Services.SystemTray;
import Quickshell.Services.UPower;

import qs.Widgets as Widgets;

Scope {
  id: root;

  Theme { id: theme; }

  Variants {
    model: Quickshell.screens;
    delegate: Component {
      PanelWindow {
        required property var modelData;

        screen: modelData;
        implicitHeight: 30;

        color: "transparent";

        anchors {
          top: true;
          left: true;
          right: true;
        }

        margins {
          top: 5;
          left: 5;
          right: 5;
        }

        RowLayout {
          id: layout;
          width: parent.width;
          height: parent.height;

          anchors {
            fill: parent;
            margins: 5;
          }

          Widgets.Workspaces {}
          Widgets.Spacer {}
          Widgets.Volume {}
          Widgets.Battery {}
          Widgets.Date {}
          Widgets.Clock {}
        }
      }
    }
  }
}
