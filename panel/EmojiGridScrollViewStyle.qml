import QtQuick 2.0
import QtQuick.Controls.Styles 1.2

ScrollViewStyle {
    handle: Item {
        implicitWidth: 5
        implicitHeight: 20
        Rectangle {
            color: "#424246"
            anchors.fill: parent
            radius: 3
        }
    }
    scrollBarBackground: Item {
        implicitWidth: 5
        implicitHeight: 20
    }
    decrementControl: Item { opacity: 0 }
    incrementControl: Item { opacity: 0 }
}
