import QtQuick
import Quickshell.Io

Item {
    id: kernelInfo

    property string kernelVersion: "Linux"

    Process {
        id: kernelProc
        command: ["uname", "-r"]
        stdout: SplitParser {
            onRead: data => {
                if (data)
                    kernelInfo.kernelVersion = data.trim();
            }
        }
        Component.onCompleted: running = true
    }
}
