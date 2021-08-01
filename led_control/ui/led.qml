
import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

ApplicationWindow {
    id:root
    title:qsTr("Led Control")
    visible: true
    width: 800
    height: 480

    background: Rectangle{
        color: "#4d4747"
        anchors.fill: parent
    }

    Text {
        id: info
        color: "#cfcdcd"
        text: qsTr("LED Control")
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 40
        }

        font.bold: true
        font.pointSize: 26
    }

    Item {
        id: contains
        anchors{
            left: parent.left
            top:parent.top
            leftMargin: 260
            topMargin: 150
        }

        Image {
            id: stateOn
            anchors{
                left: contains.left
                top:contains.top
            }
            height: 100
            source: "./image/led-on.svg"
        }

        Rectangle{
            id:  ledOn
            color: "#3061e0"
            radius: 20
            width: 140
            height: 40
            Text {
                id:txOn
                color: "#dbdbdb"
                text: qsTr("On")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter

            }
            anchors{
                top: stateOn.bottom
                topMargin: 30
                horizontalCenter: stateOn.horizontalCenter
            }

            MouseArea{
                anchors.fill: parent
                onPressed: {
                    ledOn.color = "#f0f0f0"
                }
                onReleased: {
                    ledOn.color = "#3061e0"
                }
                onClicked: {
                    _Control.ledOn();
                }
            }
        }

        Image{
            id:stateOff
            source: "./image/led-off.svg"
            height: 100
            anchors{
                left: stateOn.right
                top: stateOn.top
                leftMargin: 80
            }
        }

        Rectangle{
            id: ledOff
            color: "#3061e0"
            radius: 20
            width: 140
            height: 40
            Text {
                id:txOff
                color: "#dbdbdb"
                text: qsTr("Off")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter

            }
            anchors{
                top:stateOff.bottom
                topMargin: 30
                horizontalCenter: stateOff.horizontalCenter
            }
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    ledOff.color = "#f0f0f0"
                }
                onReleased: {
                    ledOff.color = "#3061e0"
                }
                onClicked: {
                    _Control.ledOff();
                }
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
