// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    property string fontFamily: "Helvetica"
    property int space: 10

    property bool inputAFocus: true
    property bool inputBFocus: false
    property bool inputCFocus: false
    property bool inputDFocus: false

    signal characterModeChanged(string mode);

    color: "transparent"
    width: 400
    height: 400

    function next() {
        var a = false
        var b = false
        var c = false
        var d = false

        if(inputA.textInputFocus)
            b = true

        if(inputB.textInputFocus)
            c = true

        if(inputC.textInputFocus)
            d = true

        if(inputD.textInputFocus)
            a = true

        inputAFocus = a
        inputBFocus = b
        inputCFocus = c
        inputDFocus = d
    }

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
            LabelledInput { id: inputA
                labelText: "Latitude:"
                textInputFocus: inputAFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput { id: inputB
                labelText: "Longitude:"
                textInputFocus: inputBFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput { id: inputC
                labelText: "Altitude/ft:"
                textInputFocus: inputCFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                }
            }
        }
        Row {
            LabelledInput { id: inputD
                labelText: "Name:"
                textInputFocus: inputDFocus
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

