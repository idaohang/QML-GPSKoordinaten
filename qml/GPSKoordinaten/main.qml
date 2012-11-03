// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import GpsGraphics 1.0

Rectangle { id: mainRect
    property int mainBorder: 20

    signal characterModeChanged(string mode)
    signal textSelected(string text)

    color: "black"
    width: 800 + mainBorder
    height: 400 + mainBorder

    border.width: 6
    border.color: "grey"
    radius: 5

    Connections {
        target: numberEdit
        onTextChanged: inputFields.setActiveText(text)
    }

    Rectangle { id: centerRect
        width: mainRect.width - mainBorder // Refac: parent.width - border(20)
        height: mainRect.height - mainBorder
        anchors.centerIn: parent
        color: "transparent"

        function debug(value) {
            console.log(value)
            return 0
        }
        property int w: debug(width)
        property int h: debug(height)

        InputFields { id: inputFields
            anchors.left: parent.left
            Component.onCompleted: {
                characterModeChanged.connect(mainRect.characterModeChanged)
                textSelected.connect(mainRect.textSelected)
            }
        }
        Numberpad { id: numberpad
            anchors.right: parent.right
            width: centerRect.height
            height: centerRect.height
            charMode: numberEdit.characterMode
            Component.onCompleted: {
                next.connect(inputFields.next)
                buttonClicked.connect(numberEdit.addText)
            }
        }
    }
}
