// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import GpsGraphics 1.0

Rectangle { id: mainRect
    signal characterModeChanged(string mode);

    color: "black"
    width: 820
    height: 420

    border.width: 6
    border.color: "grey"
    radius: 5

    //    function setCharacterMode(mode) {
    //        numberpad.setCharacterMode(mode)
    //    }

    //    Component.onCompleted: {
    //        onCharacterModeChanged2: numberpad.setCharacterMode(mode)
    //        var t = numberEdit.characterMode
    //    }

    Rectangle {
        width: 800 // Refac: parent.width - border(20)
        height: 400
        anchors.centerIn: parent
        color: "transparent"

        InputFields { id: inputFields
            anchors.left: parent.left
            Component.onCompleted: {
                characterModeChanged.connect(mainRect.characterModeChanged)
            }
        }
        Numberpad { id: numberpad
            anchors.right: parent.right
            charMode: numberEdit.characterMode
        }
    }
}
