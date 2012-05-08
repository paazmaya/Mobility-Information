import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Battery Information")

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
                    "batteryStatus: " + battery.batteryStatus,
                    "chargerType: " + battery.chargerType,
                    "chargingState: " + battery.chargingState,
                    "currentFlow: " + battery.currentFlow,
                    "energyMeasurementUnit: " + battery.energyMeasurementUnit,
                    "maxBars: " + battery.maxBars,
                    "nominalCapacity: " + battery.nominalCapacity,
                    "remainingCapacityBars: " + battery.remainingCapacityBars,
                    "remainingCapacity: " + battery.remainingCapacity,
                    "remainingCapacityPercent: " + battery.remainingCapacityPercent,
                    "remainingChargingTime: " + battery.remainingChargingTime,
                    "voltage: " + battery.voltage
                ]

                Label {
                    width: pageContent.width
                    text: modelData
                    wrapMode: Text.WordWrap
                }
            }

            Rectangle {
                color: "red"
                width: parent.width
                height: 60
                Rectangle {
                    color: "green"
                    anchors.left: parent.left
                    width: battery.remainingCapacityPercent * parent.width / 100
                    height: parent.height
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }
    // Mobility 1.2
    // http://doc.qt.nokia.com/qtmobility-1.2/qml-batteryinfo.html
    BatteryInfo {
        id: battery

        monitorBatteryStatusChanges: true
        monitorChargerTypeChanges: true
        monitorChargingStateChanges: true
        monitorCurrentFlowChanges: false
        monitorNominalCapacityChanges: true
        monitorRemainingCapacityBarsChanges: true
        monitorRemainingCapacityChanges: true
        monitorRemainingCapacityPercentChanges: true
        monitorRemainingChargingTimeChanges: true

        onBatteryStatusChanged: {
            console.log("Battery batteryStatusChanged.")
        }
        onChargerTypeChanged: {
            console.log("Battery chargerTypeChanged.")
        }
        onChargingStateChanged: {
            console.log("Battery chargingStateChanged.")
        }
        onCurrentFlowChanged: {
            console.log("Battery currentFlowChanged: " + currentFlow.toString())
        }
        onNominalCapacityChanged: {
            console.log("Battery nominalCapacityChanged.")
        }
        onRemainingCapacityBarsChanged: {
            console.log("Battery remainingCapacityBarsChanged.")
        }
        onRemainingCapacityChanged: {
            console.log("Battery remainingCapacityChanged.")
        }
        onRemainingCapacityPercentChanged: {
            console.log("Battery remainingCapacityPercentChanged.")
        }
        onRemainingChargingTimeChanged: {
            console.log("Battery remainingChargingTimeChanged.")
        }

    }
}
