import QtQuick
import Quickshell.Io

Item {
    id: diskUsage

    property int usage: 0

    Process {
        id: diskProc
        command: ["sh", "-c", "df / | tail -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var percentStr = parts[4] || "0%";
                diskUsage.usage = parseInt(percentStr.replace('%', '')) || 0;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: diskProc.running = true
    }
}
