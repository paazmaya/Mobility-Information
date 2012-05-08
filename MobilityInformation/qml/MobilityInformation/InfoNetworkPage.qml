import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Network Information")

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
                    "Cell ID: " + network.cellId,
                    ""
                ]
                Item {
                    Label {
                        text: modelData
                        wrapMode: Text.WordWrap
                    }
                }
            }

        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }

    // Mobility 1.1
    // http://doc.qt.nokia.com/qtmobility-1.2/qml-networkinfo.html
    NetworkInfo {
        id: network

        monitorCellDataChanges: true
        monitorCellIdChanges: true
        monitorCurrentMobileCountryCodeChanges: true
        monitorCurrentMobileNetworkCodeChanges: true
        monitorModeChanges: true
        monitorNameChanges: true
        monitorSignalStrengthChanges: true
        monitorStatusChanges: true

        onCellDataTechnologyChanges: {
            console.log("Network cellDataTechnologyChanges.")
        }
        onCellDataTechnologyChanged: {
            console.log("Network cellDataTechnologyChanged.")
        }
        onCellIdChanges: {
            console.log("Network cellIdChanges.")
        }
        onCellIdChanged: {
            console.log("Network cellIdChanged.")
        }
        onCurrentMobileCountryCodeChanged: {
            console.log("Network currentMobileCountryCodeChanged.")
        }
        onCurrentMobileNetworkCodeChanged: {
            console.log("Network currentMobileNetworkCodeChanged.")
        }
        onModeChanged: {
            console.log("Network modeChanged.")
        }
        onNameChanged: {
            console.log("Network nameChanged.")
        }
        onSignalStrengthChanged: {
            console.log("Network signalStrengthChanged.")
        }
        onStatusChanged: {
            console.log("Network statusChanged.")
        }

    }
}
