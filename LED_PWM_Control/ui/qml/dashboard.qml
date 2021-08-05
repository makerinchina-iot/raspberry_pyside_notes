
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0

ApplicationWindow{
    id:root
    width: 800
    height: 480
    visible: true
    color: "#000103"
    visibility: Window.FullScreen

    property int  progressValue: 0

    Text {
        id: title
        text: qsTr("LED PWM Control")
        color: "#BFBFBF"
        font{
            pointSize: 24
            bold: true

        }
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 20
        }
    }

    Button{
        id:exitbtn
        anchors{
            top:parent.top
            right: parent.right
            topMargin: 6
            rightMargin: 4
        }
        width: 40
        height: 30
        background: Rectangle{
            anchors.fill: parent
            color: "#a01010"
            radius: 6
        }
        Text {
            id: txt
            text: qsTr("X")
            anchors{
                centerIn: parent
            }
            font{
                pointSize: 20
                bold: true
            }
            color: "white"
        }

        onClicked: {
            console.log("exit")
            _Controler.exit()
        }
    }

    CircularGauge{
        id:pannel
        width: 300
        height: 280
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: title.bottom
            topMargin: 20
        }
        style: DashboardGaugeStyle{}

        value: root.progressValue
    }

    SlideProgress {
        id:slider
        from: 0
        to:100
        stepSize: 1
        value: 0
        anchors{
            top: pannel.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        onValueChanged: {
            root.progressValue = slider.value
            _Controler.changeLEDPWM(root.progressValue)
        }

    }

}

/*##^##
Designer {
    D{i:0;height:480;width:800}
}
##^##*/
