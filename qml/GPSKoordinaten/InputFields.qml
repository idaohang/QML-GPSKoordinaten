// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    property string fontFamily: "Helvetica"
    property int space: 10
    property string activeText: ""
    property string text: setActiveText(activeText)

    property bool inputAFocus: true
    property bool inputBFocus: false
    property bool inputCFocus: false
    property bool inputDFocus: false

    signal characterModeChanged(string mode);

    color: "transparent"
    width: 400
    height: 400

    function setActiveText(text) {
        if(inputA.textInputFocus) {
            inputA.text = text
        } else if(inputB.textInputFocus) {
            inputB.text = text
        } else if(inputC.textInputFocus) {
            inputC.text = text
        } else if(inputD.textInputFocus) {
            inputD.text = text
        }
        return ""
    }

    function next(index) {
        var a = false
        var b = false
        var c = false
        var d = false

        // 'index' und 'textInputFocus' muss getrennt behandelt werden!
        if(index >= 0) {
            if(index === 0) {
                a = true
            } else if(index === 1) {
                b = true
            } else if(index === 2) {
                c = true
            } else if(index === 3) {
                d = true
            }
        } else {
            if(inputA.textInputFocus) {
                b = true
            } else if(inputB.textInputFocus) {
                c = true
            } else if(inputC.textInputFocus) {
                d = true
            } else if(inputD.textInputFocus) {
                a = true
            }
        }

        inputAFocus = a
        inputBFocus = b
        inputCFocus = c
        inputDFocus = d

        console.log(index)
        console.log(inputA.textInputFocus)
        console.log(inputB.textInputFocus)
        console.log(inputC.textInputFocus)
        console.log(inputD.textInputFocus)
        console.log("--------------------")
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(0) }
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(1) }
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(2) }
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(3) }
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

