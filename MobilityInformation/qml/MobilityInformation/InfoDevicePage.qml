import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Device Information")

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

            Label {
                height: 300
                width: parent.width
                text: "device.inputMethodType: " + device.inputMethodType + "\n" +
                      "DeviceInfo.Mouse: " +  DeviceInfo.Mouse + ", " + (device.inputMethodType & DeviceInfo.Mouse) + "\n" +
                      "DeviceInfo.SingleTouch: " +  DeviceInfo.SingleTouch + ", " + (device.inputMethodType & DeviceInfo.SingleTouch) + "\n" +
                      "DeviceInfo.Keys: " +  DeviceInfo.Keys + ", " + (device.inputMethodType & DeviceInfo.Keys) + "\n" +
                      "DeviceInfo.Keypad: " +  DeviceInfo.Keypad + ", " + (device.inputMethodType & DeviceInfo.Keypad) + "\n" +
                      "DeviceInfo.Keyboard: " +  DeviceInfo.Keyboard + ", " + (device.inputMethodType & DeviceInfo.Keyboard) + "\n" +
                      "DeviceInfo.MultiTouch: " +  DeviceInfo.MultiTouch + ", " + (device.inputMethodType & DeviceInfo.MultiTouch) + "\n";

                wrapMode: Text.WordWrap
            }

            Repeater {
                model: [
                    "IMEI: " + device.imei,
                    "IMSI" + device.imsi,
                    "Manufacturer: " + device.manufacturer,
                    "Model: " + device.model,
                    "Bluetooth power state: " + device.currentBluetoothPowerState,
                    "uniqueDeviceID: " + device.uniqueDeviceID
                ]
                /*
                batteryLevel : int
                batteryStatus : BatteryStatus
                currentBluetoothPowerState : bool
                currentPowerState : PowerState
                currentProfile : Profile
                currentThermalState : ThermalState
                imei : QString
                imsi : QString
                inputMethodType : InputMethodFlags
                isDeviceLocked : bool
                isKeyboardFlippedOpen : bool
                isWirelessKeyboardConnected : bool
                keyboardTypes : KeyboardTypeFlags
                lockStatus : LockTypeFlags
                manufacturer : QString
                messageRingtoneVolume() : int
                model : QString
                primaryKeypadLightOn() : bool
                productName : QString
                secondaryKeypadLightOn() : bool
                simStatus : SimStatus
                uniqueID : string
                vibrationActive() : bool
                voiceRingtoneVolume() : int
                */
                /*
                  QSystemDeviceInfo::InputMethod
                QSystemDeviceInfo::Keys	0x0000001	Device has key/buttons.
                QSystemDeviceInfo::Keypad	0x0000002	Device has keypad (1,2,3, etc).
                QSystemDeviceInfo::Keyboard	0x0000004	Device has qwerty keyboard.
                QSystemDeviceInfo::SingleTouch	0x0000008	Device has single touch screen.
                QSystemDeviceInfo::MultiTouch	0x0000010	Device has multi-point touch screen.
                QSystemDeviceInfo::Mouse	0x0000020	Device has a mouse.
                */

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
                    width: device.batteryLevel * parent.width / 100
                    height: parent.height
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }




    // Mobility 1.1, but used here like 1.2 version
    // http://doc.qt.nokia.com/qtmobility-1.2/qml-deviceinfo.html
    DeviceInfo {
        id: device

        monitorBatteryLevelChanges: true
        monitorBatteryStatusChanges: true
        monitorBluetoothStateChanges: true
        //monitorCurrentProfileChanges: true
        //monitorKeyboardFlips: true
        monitorLockStatusChanges: true
        monitorPowerStateChanges: true
        //monitorThermalStateChanges: true
        //monitorWirelessKeyboardConnects: true


        /*
        batteryLevelChanged: {
            console.log("Device batteryLevelChanged.")
        }
        batteryStatusChanged: {
            console.log("Device batteryStatusChanged.")
        }
        bluetoothStateChanged: {
            console.log("Device bluetoothStateChanged.")
        }
        onCurrentProfileChanged: {
            console.log("Device currentProfileChanged.")
        }
        onDeviceLocked: {
            console.log("Device.deviceLocked changed: " + deviceLocked)
        }
        keyboardFlipped: {
            console.log("Device keyboardFlipped.")
        }
        onLockStatusChanged: {
            console.log("Device lockStatusChanged.")
        }
        powerStateChanged: {
            console.log("Device powerStateChanged.")
        }
        thermalStateChanged: {
            console.log("Device thermalStateChanged.")
        }
        wirelessKeyboardConnected: {
            console.log("Device wirelessKeyboardConnected.")
        }
        */
    }

}
