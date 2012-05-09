import QtQuick 1.1
import com.nokia.meego 1.1
import QtMultimediaKit 1.1
import QtMobility.gallery 1.1

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Multimedia Video")

    Image {
        id: pageHeader
        anchors {
            top: page.top
            left: page.left
            right: page.right
        }

        height: parent.width < parent.height ? 72 : 46
        width: parent.width
        source: "image://theme/meegotouch-view-header-fixed-inverted"
        z: 1

        Label {
            id: header
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 16
            }
            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 32
            }
            text: page.title
        }
    }

    Flickable {
        id: pageFlickableContent
        anchors {
            top: pageHeader.bottom
            bottom: page.bottom
            left: page.left
            right: page.right
            margins: 16
        }
        contentHeight: pageContent.height
        contentWidth: pageContent.width
        flickableDirection: Flickable.VerticalFlick

        clip: true

        Column {
            id: pageContent
            width: page.width - pageFlickableContent.anchors.margins * 2
            spacing: 16

            Repeater {
                model: DocumentGalleryModel {
                    rootType: DocumentGallery.Video
                    properties: ["url", "title", "director",
                        "audioCodec", "duration",
                        "videoCodec", "height", "width"]
                    filter: GalleryWildcardFilter {
                        property: "fileName";
                        value: "*.mp4";
                    }
                }
                // http://doc.qt.nokia.com/qtmobility-1.2/qdocumentgallery.html
                /*
                audioBitRate
                audioCodec
                channelCount
                director
                duration
                frameRate
                height
                lastPlayed
                performer
                playCount
                producer
                resumePosition
                sampleRate
                videoBitRate
                videoCodec
                width
                */

                Label {
                    text: director + " - " + title + " (" + audioCodec + "/" + videoCodec + ") " + duration
                    width: pageContent.width
                    wrapMode: Text.WordWrap

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            video.source = url;
                            video.opacity = 1;
                            video.play();
                        }
                    }
                }
            }

        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }

    // http://doc.qt.nokia.com/qtmobility-1.2/qml-video.html
    Video {
        id: video
        anchors.fill: parent
        visible: opacity !== 0
        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: video.pause();
        }
        PinchArea {
            anchors.fill: parent
            enabled: false
        }

    }
}
