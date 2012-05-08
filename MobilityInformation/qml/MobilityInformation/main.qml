import QtQuick 1.1
import com.nokia.meego 1.1

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    Component.onCompleted: theme.inverted = true;

    MainPage {
        id: mainPage
    }


    MobilityPublishSubscriber {
        id: sheetPubSub
    }

    ToolBarLayout {
        id: commonTools

        ToolIcon {
            visible: pageStack.depth > 1
            platformIconId: "toolbar-back"
            onClicked: {
                pageStack.pop();
            }
        }

        ToolButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Publish Subscribe"
            onClicked: {
                sheetPubSub.open();
            }
        }

        ToolIcon {
            platformIconId: "toolbar-view-menu"
            onClicked: {
                appWindow.showToolBar = false;
                viewMenu.open();
            }
        }
    }

    QueryDialog {
        id: aboutDialog
        titleText: "Mobility Information"
        message: "(C) 2012 Juga Paazmaya\n0.0.1"
    }

    Menu {
        id: viewMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("About")
                onClicked: {
                    aboutDialog.open();
                }
            }
        }
        onStatusChanged: {
            if (status === DialogStatus.Closed) {
                appWindow.showToolBar = true;
            }
        }
    }
}
