// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property string labelText: "labelText"
    property string fontFamily: "Helvetica"
    property int fontSize: 40
    property int textInputWidth: 200

//    property bool hasFocus: false // refac function?
    property bool textInputFocus: false
    property string charMode: "DigitMode"

    signal characterModeChanged(string mode);

    color: "transparent"
    width: 400
    height: 50

    Column {
        Row {
            Text {
                color: "white"
                text: labelText
                font.pixelSize: fontSize
                font.family: fontFamily
                width: 200 - 12 // refac: border
            }

            Rectangle { id: textInputRect
                color: "transparent"
                width: textInputWidth
                height: 50

                TextInput { id: textInput
                    color: "white"
                    width: textInputWidth
                    font.pixelSize: fontSize
                    focus: textInputFocus

                    onFocusChanged: {
                        if(focus){
                            textInputRect.border.color = "white"
//                            hasFocus = true
                            characterModeChanged(charMode)
                        }else{
                            textInputRect.border.color = "transparent"
//                            hasFocus = false
                        }
                    }

                }
            }

        }
    }
}
