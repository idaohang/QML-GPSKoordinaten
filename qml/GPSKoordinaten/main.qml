// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import GpsGraphics 1.0

Rectangle { id: mainRect
    property int mainBorder: 20
    property bool mapVisibility: true

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
        width: mainRect.width - mainBorder
        height: mainRect.height - mainBorder
        anchors.centerIn: parent
        color: "transparent"

        InputFields { id: inputFields
            anchors.left: parent.left
            width: centerRect.width - centerRect.height
            height: centerRect.height
            Component.onCompleted: {
                characterModeChanged.connect(mainRect.characterModeChanged)
                textSelected.connect(mainRect.textSelected)
                back.connect(mainRect.back)
                ok.connect(mainRect.ok)
            }
        }
        Numberpad { id: numberpad
            anchors.right: parent.right
            width: centerRect.height
            height: centerRect.height
            charMode: numberEdit.characterMode // Refac: Function?
            Component.onCompleted: {
                next.connect(inputFields.next)
                buttonClicked.connect(numberEdit.addText)
            }
        }
    }

    function setTarget(latitude, longitude, altitude) {
        inputFields.setTextFields(latitude, longitude, altitude, "")
        mapVisibility = false
    }

    function back() {
        mapVisibility = true
    }

    function ok(latitude, longitude, altitude, name) {
        mapView.setTarget(latitude, longitude, altitude)
        mapVisibility = true
    }

    MapView { id: mapView
        width: mainRect.width
        height: mainRect.height
        visible: mapVisibility

        Component.onCompleted: {
            target.connect(mainRect.setTarget)
        }
    }
}
