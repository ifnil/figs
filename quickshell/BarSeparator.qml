import QtQuick
import QtQuick.Layouts

Rectangle {
    property color separatorColor: "#444b6a"
    property int leftPad: 0
    property int rightPad: 8
    property int heightSize: 16

    Layout.preferredWidth: 1
    Layout.preferredHeight: heightSize
    Layout.alignment: Qt.AlignVCenter
    Layout.leftMargin: leftPad
    Layout.rightMargin: rightPad
    color: separatorColor
}
