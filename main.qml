import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia


Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Multimedia Player")
    property alias source: mediaPlayer.source

    Popup {
        id: mediaError
        anchors.centerIn: Overlay.overlay
        Text {
            id: mediaErrorText
        }
    }

    MediaPlayer {
        id: mediaPlayer

        videoOutput: videoOutput
        audioOutput: AudioOutput {
            id: audio
            muted: playbackControl.muted
            volume: playbackControl.volume
        }

        onErrorOccurred: { mediaErrorText.text = mediaPlayer.errorString; mediaError.open() }
    }

    PlayerMenuBar {
        id: menuBar

        anchors.left: parent.left
        anchors.right: parent.right

        visible: !videoOutput.fullScreen

        mediaPlayer: mediaPlayer
        videoOutput: videoOutput
        onClosePlayer: root.close()
    }


    VideoOutput {
        id: videoOutput

        property bool fullScreen: false

        anchors.top: fullScreen ? parent.top : menuBar.bottom
        anchors.bottom: playbackControl.top
        anchors.left: parent.left
        anchors.right: parent.right

        TapHandler {
            onDoubleTapped: {
                parent.fullScreen ?  showNormal() : showFullScreen()
                parent.fullScreen = !parent.fullScreen
            }
        }
    }

    PlaybackControl {
        id: playbackControl

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        mediaPlayer: mediaPlayer
    }
}
