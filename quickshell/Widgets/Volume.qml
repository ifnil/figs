import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Rectangle {
  implicitWidth: 60;
  radius: 5;

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Layout.minimumHeight: parent.height;
  color: theme.green;

  Text {
    id: volume;

    font {
      family: theme.fontFamily;
      pixelSize: 14;
    }

    anchors {
      centerIn: parent;
    }

    property var curVol: Pipewire.defaultAudioSink.audio.volume;

    function chooseIcon() {
      var vol = Math.floor(curVol * 100);

      switch (vol) {
        case vol < 50:
          return "󰕾 " + vol;
        case vol < 30:
          return "󰖀 " + vol;
        case vol < 10:
          return "󰕿 " + vol;
      }
    }

    text: chooseIcon()
  }
}
