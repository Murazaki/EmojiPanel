import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2

Button {

    // Fixed version of the charCodeAt function
    function fixedCharCodeAt(str, idx) {
      // ex. fixedCharCodeAt('\uD800\uDC00', 0); // 65536
      // ex. fixedCharCodeAt('\uD800\uDC00', 1); // false
      idx = idx || 0;
      var code = str.charCodeAt(idx);
      var hi, low;

      // High surrogate (could change last hex to 0xDB7F to treat high
      // private surrogates as single characters)
      if (0xD800 <= code && code <= 0xDBFF) {
        hi = code;
        low = str.charCodeAt(idx + 1);
        if (isNaN(low)) {
          throw 'High surrogate not followed by low surrogate in fixedCharCodeAt()';
        }
        return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
      }
      if (0xDC00 <= code && code <= 0xDFFF) { // Low surrogate
        // We return false to allow loops to skip this iteration since should have
        // already handled high surrogate above in the previous iteration
        return false;
        /*hi = str.charCodeAt(idx - 1);
        low = code;
        return ((hi - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;*/
      }
      return code;
    }

    // Give hexadecimal value with a minimum of four digits
    function toHexString(num) {
        var hex = num.toString(16);

        if(hex.length < 4)
            hex = ("0000" + hex).substr(-4,4);

        return hex;
    }

    // Concatenates codes for double character emojis
    function getCode(emoji) {
        var codelist = [];

        for(var i=0; i < emoji.length;i++) {
            var codestr = toHexString(fixedCharCodeAt(emoji,i));
            if((codestr !== "false") && (codestr !== "fe0f"))
                codelist.push(codestr);
        }

        return codelist.join('-');
    }


    style: ButtonStyle {
        background: Item {

            Rectangle {
                anchors.fill: parent
                color: "#99ffffff"
                radius: 5
                opacity: control.hovered || emojiGrid.currentIndex == index

                Behavior on opacity { PropertyAnimation { duration: 100 } }
            }

            Text {
                id: text
                font.family: "Symbola"
                text: modelData.emoji
                font.pixelSize: parent.width - 2*image.anchors.margins

                anchors.centerIn: parent

                opacity: (image.status != Image.Ready)
            }

            Image {
                id: image
                anchors.fill: parent
                anchors.margins: 3
                source: "emojis/" + getCode(modelData.emoji) + ".png"
            }
        }
    }

    tooltip: modelData.description

    onClicked: emojiPanel.emojiPressed(modelData.emoji);
}

