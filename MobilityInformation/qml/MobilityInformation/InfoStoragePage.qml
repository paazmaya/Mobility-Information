import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.systeminfo 1.2

Page {
    id: page
    tools: commonTools

    property string title : qsTr("Storage Information")

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
                model: storage.logicalDrives

                Column {
                    property real totalSpace: 0
                    property real availSpace: 0
                    property string storageState: "" // QSystemStorageInfo::StorageState
                    property int driveType: 0 // QSystemStorageInfo::DriveType
                    property string driveUri: ""

                    width: pageContent.width

                    Component.onCompleted: {
                        totalSpace = storage.totalDiskSpace(modelData);
                        availSpace = storage.availableDiskSpace(modelData);
                        storageState = storage.getStorageState(modelData).toString();
                        driveType = storage.typeForDrive(modelData);
                        driveUri = storage.uriForDrive(modelData);
                    }

                    Rectangle {
                        opacity: 0.6
                        color: "red"
                        width: parent.width
                        height: 20
                        Rectangle {
                            color: "green"
                            anchors.left: parent.left
                            height: parent.height
                            width: availSpace / totalSpace * parent.width
                        }
                    }

                    Label {
                        width: pageContent.width
                        text: modelData + " (" + availSpace + " / " + totalSpace + ")"
                        wrapMode: Text.WordWrap
                    }
                    Label {
                        width: pageContent.width
                        text: "URI: " + driveUri + ", State: " + storageState + ", Type: " + driveType
                        platformStyle: LabelStyle {
                            fontPixelSize: 20 // UI.FONT_LSMALL
                        }
                        wrapMode: Text.WordWrap
                    }
                }
            }

        }
    }

    ScrollDecorator {
        flickableItem: pageFlickableContent
    }

    // Mobility 1.2
    // http://doc.qt.nokia.com/qtmobility-1.2/qml-storageinfo.html
    StorageInfo {
        id: storage

        onLogicalDriveChanged: {
            // ( bool added, string drive )
            console.log("Storage logicalDriveChanged. added: " + added + ", drive: " + drive)
        }
        onLogicalDrivesChanged: {
            console.log("Storage logicalDrivesChanged.")
        }
        onStorageStateChanged: {
            // ( string drive, QSystemStorageInfo::StorageState state )
            console.log("Storage storageStateChanged.")
        }


    }

    /*
    enum QSystemStorageInfo::DriveType

    This enum describes the type of drive or volume
    Constant	Value	Description
    QSystemStorageInfo::NoDrive	0	Drive type undetermined.
    QSystemStorageInfo::InternalDrive	1	Is internal mass storage drive like a hard drive.
    QSystemStorageInfo::RemovableDrive	2	Is a removable disk like MMC.
    QSystemStorageInfo::RemoteDrive	3	Is a network drive.
    QSystemStorageInfo::CdromDrive	4	Is a cd rom drive.
    QSystemStorageInfo::InternalFlashDrive	5	Is an internal flash disk, or Phone Memory. Since 1.2
    QSystemStorageInfo::RamDrive	6	Is a virtual drive made in RAM memory. Since 1.2


    enum QSystemStorageInfo::StorageState

    This enum describes the state of the storage level of drive or volume.
    Constant	Value	Description
    QSystemStorageInfo::UnknownStorageState	0	Storage level indicates an error, offline or unknown.
    QSystemStorageInfo::NormalStorageState	1	Storage level indicates normal.
    QSystemStorageInfo::LowStorageState	2	Storage level indicates below 40%.
    QSystemStorageInfo::VeryLowStorageState	3	Storage level indicates below 10%.
    QSystemStorageInfo::CriticalStorageState	4	Storage level indicates below 2%.
    */
}
