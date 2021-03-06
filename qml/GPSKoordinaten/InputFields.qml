// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    property string fontFamily: "Helvetica"
    property int space: 10

    property bool inputAFocus: true
    property bool inputBFocus: false
    property bool inputCFocus: false
    property bool inputDFocus: false

    property double widthPercentage: width / 400
    property double heightPercentage: height / 400

    signal characterModeChanged(string mode);
    signal textSelected(string text)
    signal back()
    signal ok(double latitude, double longitude, double altitude, double name)

    color: "transparent"
    width: 400
    height: 400

    function setTextFields(latitude, longitude, altitude, name) {
        inputA.text = latitude
        inputB.text = longitude
        inputC.text = altitude
        inputD.text = name

        if(inputA.textInputFocus) {
            textSelected(inputA.text)
        } else if(inputB.textInputFocus) {
            textSelected(inputB.text)
        } else if(inputC.textInputFocus) {
            textSelected(inputC.text)
        } else if(inputD.textInputFocus) {
            textSelected(inputD.text)
        }
    }

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

    function buttonSize() {
        return 100 * (heightPercentage < widthPercentage ? heightPercentage : widthPercentage)
    }

    function getMaxLabelWidth() {
        var max = 0;
        if(inputA.getLabelWidth() > max)
            max = inputA.getLabelWidth()
        if(inputB.getLabelWidth() > max)
            max = inputB.getLabelWidth()
        if(inputC.getLabelWidth() > max)
            max = inputC.getLabelWidth()
        if(inputD.getLabelWidth() > max)
            max = inputD.getLabelWidth()
        return max
    }

    Column { id: mainColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        spacing: space

        Row {
            Rectangle {
                color: "white"
                radius: 10.0

                width: 390 * widthPercentage
                height: 50 * heightPercentage

                Text {
                    color: "black"
                    text: "Waypoint Coordinates"
                    anchors.centerIn: parent
                    font.pixelSize: 38 * heightPercentage // 40 without heightPercentage
                    font.family: fontFamily
                }
            }
        }
        Row {
            LabelledInput { id: inputA
                width:   400 * widthPercentage
                height:   50 * heightPercentage
                fontSize: 40 * heightPercentage

                labelRectWidth: getMaxLabelWidth(width)

                labelText: "Latitude:"
                textInputFocus: inputAFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                    textSelected.connect(mainRect.textSelected)
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(0) }
                }
            }
        }
        Row {
            LabelledInput { id: inputB
                width:   400 * widthPercentage
                height:   50 * heightPercentage
                fontSize: 40 * heightPercentage

                labelRectWidth: getMaxLabelWidth(width)

                labelText: "Longitude:"
                textInputFocus: inputBFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                    textSelected.connect(mainRect.textSelected)
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(1) }
                }
            }
        }
        Row {
            LabelledInput { id: inputC
                width:   400 * widthPercentage
                height:   50 * heightPercentage
                fontSize: 40 * heightPercentage

                labelRectWidth: getMaxLabelWidth(width)

                labelText: "Altitude/ft:"
                textInputFocus: inputCFocus
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                    textSelected.connect(mainRect.textSelected)
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: { mainRect.next(2) }
                }
            }
        }
        Row {
            LabelledInput { id: inputD
                width:   400 * widthPercentage
                height:   50 * heightPercentage
                fontSize: 40 * heightPercentage

                labelRectWidth: getMaxLabelWidth(width)

                labelText: "Name:"
                textInputFocus: inputDFocus
                charMode: "LetterMode"
                Component.onCompleted: {
                    characterModeChanged.connect(mainRect.characterModeChanged)
                    textSelected.connect(mainRect.textSelected)
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
                width: buttonSize()
                height: buttonSize()

                buttonText: "<="
                onClicked: {
                    mainRect.back()
                }
            }
            Button2 {
                width: buttonSize()
                height: buttonSize()

                buttonText: "OK"
                onClicked: {
                    mainRect.ok(inputA.text, inputB.text, inputC.text, inputD.text)
                }
            }
        }
    }
}

