import QtQuick;
import QtQuick.Layouts;

Rectangle {
  property color bg: "transparent";

  color: this.bg;
  Layout.fillWidth: true;
  Layout.preferredWidth: parent.width;
  Layout.maximumWidth: parent.width;
  Layout.minimumHeight: parent.height;
}
