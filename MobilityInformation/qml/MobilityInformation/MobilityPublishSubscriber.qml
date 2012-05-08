import QtQuick 1.1
import com.nokia.meego 1.1
import QtMobility.publishsubscribe 1.2

Sheet {
    id: sheet

    acceptButtonText: "Close"
    rejectButtonText: ""

    content: Flickable {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.topMargin: 10
        contentWidth: col2.width
        contentHeight: col2.height
        flickableDirection: Flickable.VerticalFlick
        Column {
            id: col2
            anchors.top: parent.top
            spacing: 10

            Label {
                id: nowPlayingText
                text: "Now playing: " + nowPlaying.value
                wrapMode: Text.WordWrap
            }

            Label {
                id: pathParserText
                wrapMode: Text.WordWrap
            }

            TextEdit {
                id: editText
                width: parent.width
            }
            Button {
                width: parent.width
                height: 30
                text: "update path"
                onClicked: {
                    pathParser.setPath(editText.text)
                }
            }


        }
    }

    // http://doc.qt.nokia.com/qtmobility-1.2/qml-valuespacesubscriber.html
    ValueSpaceSubscriber {
        id: nowPlaying
        path: "/Applications/mediaplayer/now-playing"

        // According to N9, onConnectedChanged, onSubPathsChanged does not exist
        /*
        onConnectedChanged: {
            console.log("nowPlaying connected changed: " + connected)
        }
        onSubPathsChanged: {
            console.log("nowPlaying subPaths changed: " + subPaths)
        }
        */

        onContentsChanged: {
            console.log("nowPlaying contents changed: " + content)
        }
        onValueChanged: {
            console.log("nowPlaying value changed: " + value)
        }

        /*
        Properties
            connected : bool
            path : string
            subPaths : QStringList
            value : QVariant
        */
    }


    ValueSpaceSubscriber {
        id: pathParser
        property variant paths: []

        path: "/Applications"

        function iteratePaths() {
            var len = subPaths.length;
            for (var i = 0; i < len; i++) {
                var p = path + subPaths[i];
                if (paths.indexOf(p) === -1) {
                    paths.push(p);
                }
            }
            if (len > 0) {
                console.log("paths: " + paths.join("\n"));
                pathParserText.text = paths.join("\n");
            }
        }

        /*
        onConnectedChanged: {
            console.log("pathParser connected changed: " + connected)
        }
        onSubPathsChanged: {
            console.log("pathParser subPaths changed: " + subPaths)
        }
        */
        onContentsChanged: {
            console.log("contents changed: " + content)
            console.log("value: " + value)
            //iteratePaths();
            pathParserText.text = "connected: " + pathParser.connected + ", value: " + pathParser.value + ", subPaths: " + pathParser.subPaths
        }

        /*
        Properties
            connected : bool
            path : string
            subPaths : QStringList
            value : QVariant
        */

        /*
        QValueSpaceSubscriber base("/Settings");
        QValueSpaceSubscriber equiv("/Settings/Nokia/General/Mappings");

        // Is true
        equiv.value() == base.value("Nokia/General/Mappings");
        */
    }
}
