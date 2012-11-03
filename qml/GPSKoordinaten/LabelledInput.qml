// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    property string labelText: "labelText"
    property string fontFamily: "Helvetica"
    property int fontSize: 40
    property int textInputWidth: width / 2 // 200
    property string text: ""
    property bool textInputFocus: false
    property string charMode: "DigitMode"

    signal characterModeChanged(string mode);
    signal textSelected(string text)

    color: "transparent"
    width: 400
    height: 50

    Column {
        Row {
            Text { id: label
                color: "white"
                text: labelText
                font.pixelSize: fontSize
                font.family: fontFamily
//                width: textInputWidth - 12 // refac: border
            }

            Rectangle { id: textInputRect
                color: "transparent"
                width: mainRect.width - label.width - 12
                height: mainRect.height

                TextInput { id: textInput
                    color: "white"
                    width: mainRect.width - label.width - 12
                    font.pixelSize: fontSize
                    focus: textInputFocus
                    text: mainRect.text

                    onFocusChanged: {
                        if(focus){
                            textInputRect.border.color = "white"
                            characterModeChanged(charMode)
                            textSelected(textInput.text)
                        }else{
                            textInputRect.border.color = "transparent"
                        }
                    }

                }
            }

        }
    }
}
