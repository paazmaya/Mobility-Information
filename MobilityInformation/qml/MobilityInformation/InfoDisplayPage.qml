import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Display Information")

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
                    "Backlight state: " + display.backlightStatus, // QSystemDisplayInfo::BacklightState
                    "Color depth: " + display.colorDepth,
                    "Contrast: " + display.contrast,
                    "Brightness: " + display.displayBrightness,
                    "DPI height: " + display.dpiHeight,
                    "DPI width: " + display.dpiWidth,
                    "Orientation: " + display.orientation, // QSystemDisplayInfo::DisplayOrientation
                    "Physical height: " + display.physicalHeight,
                    "Physical width: " + display.physicalWidth,
                    "Screen: " + display.screen
                ]

                Label {
                    width: pageContent.width
                    text: modelData
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }

    // Mobility 1.2
    // http://doc.qt.nokia.com/qtmobility-1.2/qml-displayinfo.html
    DisplayInfo {
        id: display

        onOrientationChanged: {
            console.log("Display orientationChanged.")
        }

    }
}
