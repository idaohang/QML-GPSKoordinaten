// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import GpsGraphics 1.0

Rectangle { id: mainRect
    property int space: 12
    property int buttonSize: calculateButtonSize(4, 10, space)
    property string charMode: "DigitMode"

    signal next()
    signal buttonClicked(string text)

    state: characterModeState(charMode)

    color: "transparent"
    width: 400
    height: 400

    border.width: 1
    border.color: "grey"
    radius: 5

    function nextButtonWidth() {
        if(state == "Digits") {
            return buttonSize * 2 + space
        } else {
            return buttonSize
        }
    }

    function numberSignButtonWidth() {
        if(state == "Digits") {
            return 0
        } else {
            return buttonSize
        }
    }

    function characterModeState(mode) {
        if(mode === "DigitMode") {
            return "Digits"
        }else if(mode === "LetterMode") {
            return "LowerCaseLetters"
        } else {
            return "UpperCaseLetters"
        }
    }

    function calculateButtonSize(buttonCount, border, spacing) {
        var spacings = spacing * (buttonCount - 1)
        return (mainRect.width - spacings - (2 * border)) / buttonCount
    }

    Column { id: mainColumn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        spacing: space

        Row {
            spacing: space
            Button2 { id: button00
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button01
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button02
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button03
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
        }
        Row {
            spacing: space
            Button2 { id: button10
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button11
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button12
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button13
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
        }
        Row {
            spacing: space
            Button2 { id: button20
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button21
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button22
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button23
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
        }
        Row {
            spacing: space
            Button2 { id: button30
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button31
                width: buttonSize
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 { id: button32
                width: numberSignButtonWidth()
                height: buttonSize
                Component.onCompleted: {
                    clicked.connect(mainRect.buttonClicked)
                }
            }
            Button2 {  id: button33
                width: nextButtonWidth()
                height: buttonSize
                onClicked: {
                    mainRect.next()
                }
            }
        }
    }

    // onReturnPressed -> signalHandler

    states:[
        State{ name: "Digits"
            StateChangeScript{ name: "switchToDigits"
                script: {
                    button00.buttonText = "1"
                    button01.buttonText = "2"
                    button02.buttonText = "3"
                    button03.buttonText = "<-"

                    button10.buttonText = "4"
                    button11.buttonText = "5"
                    button12.buttonText = "6"
                    button13.buttonText = "-"

                    button20.buttonText = "7"
                    button21.buttonText = "8"
                    button22.buttonText = "9"
                    button23.buttonText = "."

                    button30.buttonText = "*"
                    button31.buttonText = "0"
                    button32.buttonText = ""
                    button33.buttonText = "Next"
                }}},
        State{ name: "LowerCaseLetters"
            StateChangeScript { name: "switchToLowerCaseLetters"
                script: {
                    button00.buttonText = "1<br>.,?"
                    button01.buttonText = "2<br>abc"
                    button02.buttonText = "3<br>def"
                    button03.buttonText = "<-"

                    button10.buttonText = "4<br>ghi"
                    button11.buttonText = "5<br>jkl"
                    button12.buttonText = "6<br>mno"
                    button13.buttonText = "-"

                    button20.buttonText = "7<br>pqrs"
                    button21.buttonText = "8<br>tuv"
                    button22.buttonText = "9<br>wxyz"
                    button23.buttonText = "."

                    button30.buttonText = "*<br>Î"
                    button31.buttonText = "0<br>+"
                    button32.buttonText = "#"
                    button33.buttonText = "Next"
                }}},
        State{ name: "UpperCaseLetters"
            StateChangeScript{ name: "switchToUpperCaseLetters"
                script: {
                    button00.buttonText = "1<br>.,?"
                    button01.buttonText = "2<br>ABC"
                    button02.buttonText = "3<br>DEF"
                    button03.buttonText = "<-"

                    button10.buttonText = "4<br>GHI"
                    button11.buttonText = "5<br>JKL"
                    button12.buttonText = "6<br>MNO"
                    button13.buttonText = "-"

                    button20.buttonText = "7<br>PQRS"
                    button21.buttonText = "8<br>TUV"
                    button22.buttonText = "9<br>WXYZ"
                    button23.buttonText = "."

                    button30.buttonText = "*<br>Î"
                    button31.buttonText = "0<br>+"
                    button32.buttonText = "#"
                    button33.buttonText = "Next"
                }}}
    ]
}
