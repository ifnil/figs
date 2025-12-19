import QtQuick
import Quickshell.Io

Item {
    id: cpuUsage

    property int usage: 0
    property var lastIdle: 0
    property var lastTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var user = parseInt(parts[1]) || 0;
                var nice = parseInt(parts[2]) || 0;
                var system = parseInt(parts[3]) || 0;
                var idle = parseInt(parts[4]) || 0;
                var iowait = parseInt(parts[5]) || 0;
                var irq = parseInt(parts[6]) || 0;
                var softirq = parseInt(parts[7]) || 0;

                var total = user + nice + system + idle + iowait + irq + softirq;
                var idleTime = idle + iowait;

                if (cpuUsage.lastTotal > 0) {
                    var totalDiff = total - cpuUsage.lastTotal;
                    var idleDiff = idleTime - cpuUsage.lastIdle;
                    if (totalDiff > 0) {
                        cpuUsage.usage = Math.round(100 * (totalDiff - idleDiff) / totalDiff);
                    }
                }
                cpuUsage.lastTotal = total;
                cpuUsage.lastIdle = idleTime;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }
}
