// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    signal characterModeChanged(string mode);

    property string fontFamily: "Helvetica"
    property int space: 10

    color: "transparent"
    width: 400
    height: 400

    Column { id: mainColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        spacing: space

        Row {
            Rectangle {
                color: "white"

                width: 390
                height: 50

                radius: 10.0

                Text {
                    color: "black"
                    text: "Waypoint Coordinates"
                    anchors.centerIn: parent
                    font.pixelSize: 40
                    font.family: fontFamily
                }
            }
        }
        Row {
            LabelledInput {
                labelText: "Latitude:"
                textInputFocus: true
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput {
                labelText: "Longitude:"
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput {
                labelText: "Altitude/ft:"
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput {
                labelText: "Name:"
                charMode: "LetterMode"
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            spacing: space
            Button2 {
                buttonText: "<="
            }
            Button2 {
                buttonText: "OK"
            }
        }
    }
}

