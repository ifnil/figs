import QtQuick
import QtQuick.Layouts

Text {
    id: clockText

    property QtObject theme

    text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
    color: theme ? theme.colCyan : "#0db9d7"
    font.pixelSize: theme ? theme.fontSize : 14
    font.family: theme ? theme.fontFamily : ""
    font.bold: true
    Layout.rightMargin: 8

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
    }
}
