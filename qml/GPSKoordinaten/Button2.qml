// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import QtMobility.feedback 1.1

Rectangle { id: mainRect
    property string buttonText: "buttonText"
    property int fontSize: (mainRect.height > 0) ? mainRect.height * .4 : 20
    property string fontFamily: "Helvetica"

    signal clicked(string text)

    color: "blue"
    width: 100
    height: 100
    radius: 10

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#0d00ff" }
        GradientStop { position: 1.0; color: "#020202" }
    }

    Text { id: text
        color: "white"
        text: buttonText
        anchors.centerIn: parent
        font.pixelSize: fontSize
        font.family: fontFamily
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea { id: mouseArea
        anchors.fill: parent

        onClicked: {
            mainRect.clicked(buttonText)
        }

        onPressed: {
            mainRect.state = "Pressed"
        }

        onReleased: {
            mainRect.state = ""
        }
    }

    //    HapticsEffect { id: hapticsEffect
    //        duration: 20
    //        intensity: 1.0
    //    }

    states: [
        State {
            name: ""
            PropertyChanges {
                target: mainRect
                border.width: 1
                border.color: "black"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: mainRect
                border.width: 2
                border.color: "white"
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "width"
            easing.type: Easing.InOutQuad
            duration: 200
        }
    }
}
