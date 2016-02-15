import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import "emoji.js" as Emoji

Window {
    id: window

    title: qsTr("Emoji Panel")
    width: 200
    height: 200
    visible: true
    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"
    x: cursorPos.x
    y: cursorPos.y

    FontLoader { id: emojiFont; name: "Symbola" }

    property variant emojilist: []

    function searchEmojis(keyword) {
        console.log("searchEmojis for keyword : " + keyword);

        if((keyword === undefined) || (keyword === ""))
            emojilist = Emoji.list;
        else {
            keyword = keyword.toLowerCase();

            var list = [];

            for(var i = 0; i < Emoji.list.length; i++) {
                // Search in description
                if(Emoji.list[i].description.indexOf(keyword) >= 0) {
                   console.log("Keyword found in description : " + Emoji.list[i].description);
                   list.push(Emoji.list[i]);
                }
                else {
                   // Search in tags
                   for(var j = 0; (j < Emoji.list[i].tags.length) && (list.indexOf(Emoji.list[i]) < 0); j++) {
                       if(Emoji.list[i].tags[j].indexOf(keyword) >= 0) {
                          console.log("Keyword found in tag : " + Emoji.list[i].tags[j]);
                          list.push(Emoji.list[i]);
                       }
                   }

                   // Search in aliases
                   for(var j = 0; (j < Emoji.list[i].aliases.length) && (list.indexOf(Emoji.list[i]) < 0); j++) {
                       if(Emoji.list[i].aliases[j].indexOf(keyword) >= 0) {
                          console.log("Keyword found in alias : " + Emoji.list[i].aliases[j]);
                          list.push(Emoji.list[i]);
                       }
                   }
               }
            }

            emojilist = list;
        }
    }

    Component.onCompleted: searchEmojis("");

    Keys.forwardTo: [searchField, emojiGrid]

    Rectangle {
        color: "#bbbbbbbb"
        anchors.fill: parent
        radius: 5

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 5

            spacing: 5

            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                spacing: 5

                height: 20

                TextField {
                    id: searchField
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    Layout.fillWidth: true

                    clip: true

                    style: TextFieldStyle {
                        background: Item {
                            Rectangle {
                                id: textfieldBkgd
                                radius: 5
                                border.width: 1
                                border.color: "#55000000"
                                color: "#99ffffff"
                                visible: false

                                anchors.fill: parent
                            }

                            InnerShadow {
                                anchors.fill: textfieldBkgd
                                radius: 16
                                samples: 24
                                horizontalOffset: 0
                                verticalOffset: 1
                                color: "#ff000000"
                                source: textfieldBkgd
                            }

                            Image {
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                anchors.margins: 5
                                source: "emojis/1f50e.png"

                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }

                    onTextChanged: searchEmojis(text);
                }

                Button {
                    id: button
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    style: ButtonStyle {
                        background: Item {
                            implicitWidth: 20
                            implicitHeight: 20

                            Rectangle {
                                anchors.fill: parent
                                color: "#99ffffff"
                                radius: 5
                                opacity: control.hovered

                                Behavior on opacity { PropertyAnimation { duration: 100 } }
                            }

                            Image {
                                anchors.fill: parent
                                anchors.margins: 2
                                source: "emojis/2716.png"
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }

                    onClicked: Qt.quit();
                }
            }

            Item {
                anchors.left: parent.left
                anchors.right: parent.right

                Layout.fillHeight: true

                Rectangle {
                    id: emojiGridBkgd
                    radius: 5
                    border.width: 1
                    border.color: "#55000000"
                    color: "#99ffffff"
                    visible: false

                    anchors.fill: parent
                }

                InnerShadow {
                    anchors.fill: emojiGridBkgd
                    radius: 16
                    samples: 24
                    horizontalOffset: 0
                    verticalOffset: 1
                    color: "#ff000000"
                    source: emojiGridBkgd
                }

                ScrollView {
                    anchors.fill: parent

                    style: EmojiGridScrollViewStyle {}

                    GridView {
                        id: emojiGrid
                        anchors.fill: parent
                        anchors.margins: 2
                        clip:true

                        cellWidth: 30
                        cellHeight: 30

                        delegate: EmojiGridDelegate {
                            width: emojiGrid.cellWidth
                            height: emojiGrid.cellHeight
                        }

                        model: emojilist

                        focus: true
                    }
                }
            }
        }
    }
}
