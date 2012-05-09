import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.sensors 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Compass")

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

    Item {
        id: pageContent
        anchors {
            top: pageHeader.bottom
            bottom: page.bottom
            left: page.left
            right: page.right
            margins: 16
        }

        Column {
            Row {
                spacing: 16
                Switch {
                    id: sensorEnable
                    checked: false
                }
                Label {
                    text: "Sensor is " + (sensorEnable.checked ? "enabled" : "disabled")
                }
            }

            // http://doc.qt.nokia.com/qtmobility-1.2/qml-compassreading.html
            Label {
                id: labelAzi
                width: pageContent.width
                wrapMode: Text.WordWrap
                text: "So far nothing..."
            }
            Label {
                id: labelCal
                width: pageContent.width
                wrapMode: Text.WordWrap
                text: "So far nothing..."
            }
            Label {
                width: pageContent.width
                wrapMode: Text.WordWrap
                text: "Sensor datarate: " + cSensor.datarate
            }
        }
    }

    // http://doc.qt.nokia.com/qtmobility-1.2/qml-compass.html
    Compass {
        id: cSensor
        active: sensorEnable.checked
        onReadingChanged: {
            if (reading) {
                labelAzi.text = "Compass azimuth: " + reading.azimuth
                labelCal.text = "Compass calibrationLevel: " + reading.calibrationLevel
            }

        }
    }

}
