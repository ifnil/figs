import QtQuick
import Quickshell.Io

Item {
    id: volumeLevel

    property int level: 0

    Process {
        id: volProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var match = data.match(/Volume:\s*([\d.]+)/);
                if (match) {
                    volumeLevel.level = Math.round(parseFloat(match[1]) * 100);
                }
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 200
        running: true
        repeat: true
        onTriggered: volProc.running = true
    }
}
