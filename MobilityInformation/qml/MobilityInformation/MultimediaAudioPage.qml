import QtQuick 1.1
import com.nokia.meego 1.1
import QtMultimediaKit 1.1
import QtMobility.gallery 1.1

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Multimedia Audio")

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
            bottom: nowPlayingRow.top
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
                    rootType: DocumentGallery.Audio
                    properties: ["url", "title",
                        "artist", "audioCodec", "duration"]
                    // http://doc.qt.nokia.com/qtmobility-1.2/qdocumentgallery.html
                    filter: GalleryWildcardFilter {
                        property: "fileName";
                        value: "*.mp3";
                    }
                }

                Label {
                    width: pageContent.width
                    text: artist + " - " + title + " (" + audioCodec + ") " + duration
                    wrapMode: Text.WordWrap

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            audio.source = url;
                        }
                    }
                }
            }


        }
    }

    // Now playing...
    Row {
        id: nowPlayingRow
        anchors {
            bottom: page.bottom
            left: page.left
            right: page.right
            margins: 16
        }
        height: 100
        Image  {
            source: "" //audio.metaData.posterUrl
            width: 100
            height: width
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectCrop
        }
        Label {
            text: audio.source
        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }

    // http://doc.qt.nokia.com/qtmobility-1.2/qml-audio.html
    Audio {
        id: audio
        /*

        autoLoad : url
        bufferProgress : real
        duration : int
        error : enumeration
        errorString : string
        metaData.albumArtist : variant
        metaData.albumTitle : variant
        metaData.audioBitRate : variant
        metaData.audioCodec : variant
        metaData.author : variant
        metaData.averageLevel : variant
        metaData.category : variant
        metaData.channelCount : variant
        metaData.chapterNumber : variant
        metaData.comment : variant
        metaData.composer : variant
        metaData.conductor : variant
        metaData.contributingArtist : variant
        metaData.copyright : variant
        metaData.coverArtUrlLarge : variant
        metaData.coverArtUrlSmall : variant
        metaData.date : variant
        metaData.description : variant
        metaData.director : variant
        metaData.genre : variant
        metaData.keywords : variant
        metaData.language : variant
        metaData.leadPerformer : variant
        metaData.lyrics : variant
        metaData.mediaType : variant
        metaData.mood : variant
        metaData.parentalRating : variant
        metaData.peakValue : variant
        metaData.pixelAspectRatio : variant
        metaData.posterUrl : variant
        metaData.publisher : variant
        metaData.ratingOrganisation : variant
        metaData.resolution : variant
        metaData.sampleRate : variant
        metaData.size : variant
        metaData.subTitle : variant
        metaData.title : variant
        metaData.trackCount : variant
        metaData.trackNumber : variant
        metaData.userRating : variant
        metaData.videoBitRate : variant
        metaData.videoCodec : variant
        metaData.videoFrameRate : variant
        metaData.writer : variant
        metaData.year : variant
        muted : bool
        paused : bool
        playbackRate : real
        playing : bool
        position : int
        seekable : bool
        source : url
        status : enumeration
        volume : real


        Signals

        onError
        onPaused
        onResumed
        onStarted
        onStopped
        */
    }

}
