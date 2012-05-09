import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : "Mobility Information"

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

        Column {
            id: pageContent
            width: page.width - pageFlickableContent.anchors.margins * 2
            spacing: 16

            Repeater {
                model: [
                    {
                        title: qsTr("Battery Information"),
                        page: "InfoBatteryPage"
                    },
                    {
                        title: qsTr("Device Information"),
                        page: "InfoDevicePage"
                    },
                    {
                        title: qsTr("Display Information"),
                        page: "InfoDisplayPage"
                    },
                    {
                        title: qsTr("Network Information"),
                        page: "InfoNetworkPage"
                    },
                    {
                        title: qsTr("Storage Information"),
                        page: "InfoStoragePage"
                    },
                    {
                        title: qsTr("Multimedia Camera"),
                        page: "MultimediaCameraPage"
                    },
                    {
                        title: qsTr("Multimedia Audio"),
                        page: "MultimediaAudioPage"
                    },
                    {
                        title: qsTr("Multimedia Video"),
                        page: "MultimediaVideoPage"
                    },
                    {
                        title: qsTr("Sensor Light"),
                        page: "SensorLightPage"
                    },
                    {
                        title: qsTr("Sensor Compass"),
                        page: "SensorCompassPage"
                    },
                    {
                        title: qsTr("Sensor Gyroscope"),
                        page: "SensorGyroscopePage"
                    },
                    {
                        title: qsTr("Sensor Accelerometer"),
                        page: "SensorAccelerometerPage"
                    }
                ]

                Button {
                    text: modelData.title
                    width: parent.width
                    onClicked: {
                        var comp = Qt.createComponent(modelData.page + ".qml");
                        if (comp.status == Component.Ready) {
                            pageStack.push(comp);
                        }
                        else if (comp.status == Component.Error) {
                            console.log("Error creating " + modelData.page + ": " + comp.errorString());
                        }
                    }
                }
            }

        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }


    // http://doc.qt.nokia.com/qtmobility-1.2/qml-screensaver.html
    /*
    ScreenSaver {
        id: saver

    }
    */

}
