import QtQuick
import Quickshell.Io

Item {
    id: batteryLevel

    property int percent: 0

    Process {
        id: batteryProc
        command: ["sh", "-c", "upower -i \"$(upower -e | grep -m1 -E 'battery_BAT|/battery_')\" " + "| awk '/percentage/ {gsub(/%/,\"\",$2); print $2; exit}'"]

        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim()) {
                    batteryLevel.percent = parseInt(data.trim(), 10);
                }
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: batteryProc.running = true
    }
}
