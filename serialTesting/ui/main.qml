
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
//import QtQuick.VirtualKeyboard 2.1
//import QtQuick.VirtualKeyboard.Settings 2.1


ApplicationWindow{
    id:root
    width: 800
    height: 480
    visible: true
    visibility: Window.FullScreen

    function uart1ReadyRead(string){
//        console.log("uart1 recv:",string)
        uart1recv.append(string)
    }

    function uart2ReadyRead(string){
//        console.log("uart2 recv:",string)
        uart2recv.append(string)
    }

    background: Rectangle{
        color: "black"
        anchors.fill: parent
    }

    Button{
        id:btnexit
        background: Rectangle{
            color: "#a01010"
            anchors.fill: parent
            radius:12
        }
        width: 48
        height: 48
        anchors{
            top: parent.top
            right: parent.right
            topMargin: 8
            rightMargin: 8
        }
        Text {
            text: qsTr("X")
            anchors.centerIn: parent
            font{
                pointSize: 32
            }
            color: "white"
        }
        onClicked: {
            _Controler.exit();
        }
    }

    Text {
        id: title
        text: qsTr("Serial Testing")
        anchors{
            top:  parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 20
        }
        font{
            pointSize: 24
        }
        color: "#a0a0a0"
    }

    TextField {
        id: uart1send
        width: 200
        font.pointSize: 12
        placeholderText: qsTr("uart1 send text")
        anchors{
            top: title.bottom
            left: parent.left
            topMargin: 20
            leftMargin: 30
        }
        color: "#DBD6D6"
        background: Rectangle{
            anchors.fill: parent
            color: "#303030"
        }
    }
    Button{
        id:btnsend
        text: "Send"
        width: 100
        height: uart1send.height
        anchors{
            left: uart1send.right
            leftMargin: 40
            top: uart1send.top
        }
        background: Rectangle{
            anchors.fill: parent
            color: btnsend.pressed ? "#216CB8" : "#a0a0a0"
            radius: 10
        }
        font.pixelSize: 20
        font.bold: true
        onClicked: {
            _Controler.uart1send(uart1send.text)
        }
    }

    TextArea{
        id:uart1recv
        width: 360
        height: 320
        anchors{
            top: uart1send.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 20

        }
        font.pointSize: 12
        color: "#20a0a0"
        background: Rectangle{
            anchors.fill: parent
            color: "#202020"
        }
    }

    TextField {
        id: uart2send
        width: 200
        font.pointSize: 12
        placeholderText: qsTr("uart2 send text")
        anchors{
            top: title.bottom
            right: btn2send.left
            topMargin: 20
            rightMargin: 20
        }
        color: "#DBD6D6"
        background: Rectangle{
            anchors.fill: parent
            color: "#303030"
        }
    }
    Button{
        id:btn2send
        text: "Send"
        width: 100
        height: uart2send.height
        anchors{
            right: parent.right
            rightMargin: 30
            leftMargin: 40
            top: uart1send.top
        }
        background: Rectangle{
            anchors.fill: parent
            color: btn2send.pressed ? "#216CB8" : "#a0a0a0"
            radius: 10
        }
        font.pixelSize: 20
        font.bold: true
        onClicked: {
            _Controler.uart2send(uart2send.text)
        }
    }

    TextArea{
        id:uart2recv
        width: 360
        height: 320
        anchors{
            top: btn2send.bottom
            topMargin: 10
            right: parent.right
            rightMargin: 20

        }
        font.pointSize: 12
        color: "#a020b0"
        background: Rectangle{
            anchors.fill: parent
            color: "#202020"
        }
    }


//    InputPanel {
//        id: inputPanel
//        z: 99
//        x: 50
//        y: parent.height
//        width: parent.width-100

//        states: State {
//            name: "visible"
//            when: inputPanel.active
//            PropertyChanges {
//                target: inputPanel
//                y: parent.height - inputPanel.height
//            }
//        }
//        transitions: Transition {
//            from: ""
//            to: "visible"
//            reversible: true
//            ParallelAnimation {
//                NumberAnimation {
//                    properties: "y"
//                    duration: 250
//                    easing.type: Easing.InQuart
//                }
//            }
//        }
//    }

}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
