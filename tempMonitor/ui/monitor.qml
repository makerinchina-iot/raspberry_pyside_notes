
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
import QtCharts 2.2

ApplicationWindow{
    id:root
    width: 800
    height: 480
    visible: true
    visibility: Window.FullScreen

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
        text: qsTr("Temperature Monitor")
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

    ChartView{
        id:cv
        width:600
        height:400

        anchors{
            top:title.bottom
            topMargin:10
            left:parent.left
            leftMargin:40
        }
        antialiasing: true
        theme: ChartView.ChartThemeDark

        property int  timcnt: 0
        property double  tempValue: 0

        ValueAxis{
            id:xAxis
            min: 0
            max: cv.timcnt < 10 ? 10 : cv.timcnt + 1
            tickCount: 11
            labelFormat: "%d"
        }

        ValueAxis{
            id:yAxis
            min: 20
            max: 40
            tickCount: 1
            labelFormat: "%d"
        }

        LineSeries {
            name: "Temperature"
            id:lines
            axisX: xAxis
            axisY: yAxis
            width: 3
            color: "#F11C9C"
        }

        Timer{
            id:tm
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                cv.timcnt = cv.timcnt + 1
                cv.tempValue = _Controler.getTempValue()

                lines.append(cv.timcnt,cv.tempValue)

                console.log("qml temp value:",cv.tempValue)
            }
        }
    }

    Rectangle {
        width: 80
        height: 300
        color: "transparent"
        anchors{
            left: cv.right
            leftMargin: 20
            verticalCenter: cv.verticalCenter
        }

        Timer {
            running: true
            repeat: true
            interval: 600
            onTriggered: gauge.value = cv.tempValue
        }

        Gauge {
            id: gauge
            anchors.fill: parent
            anchors.margins: 10
            minimumValue: 20
            maximumValue: 40

            Behavior on value {
                NumberAnimation {
                    duration: 600
                }
            }

            style: GaugeStyle {
                valueBar: Rectangle {
                    color: "#e34c22"
                    implicitWidth: 28
                }
            }
        }

    }

}


