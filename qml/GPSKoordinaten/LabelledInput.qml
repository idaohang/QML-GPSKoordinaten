// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle { id: mainRect
    property string labelText: "labelText"
    property string fontFamily: "Helvetica"
    property int fontSize: 40
    property int labelRectWidth: 0
    property string text: ""
    property bool textInputFocus: false
    property string charMode: "DigitMode"

    signal characterModeChanged(string mode);
    signal textSelected(string text)

    color: "transparent"
    width: 400
    height: 50

    function getLabelWidth() {
        return label.width
    }

    Column {
        Row {
            Rectangle { id: labelRect
                width: labelRectWidth
                height: mainRect.height
                color: "transparent"

                Text { id: label
                    color: "white"
                    text: labelText
                    font.pixelSize: fontSize
                    font.family: fontFamily
                }
            }
            Rectangle { id: textInputRect
                color: "transparent"
                width: mainRect.width - labelRect.width - 12 // 12 is left border
                height: mainRect.height

                TextInput { id: textInput
                    color: "white"
                    width: mainRect.width - labelRect.width - 12
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
