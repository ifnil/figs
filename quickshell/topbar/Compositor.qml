pragma Singleton

import Quickshell
import QtQuick

// Which compositor the bar runs under. Modules branch on this so they only
// touch that compositor's singleton; the other one warns about its missing
// IPC socket.
Singleton {
	readonly property bool isSway: !!Quickshell.env("SWAYSOCK")
}
