
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
        anchors.fill: parent
        color: "#101010"
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
        text: qsTr("ADC Measure")
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
        width:700
        height:400

        anchors{
            top:title.bottom
            topMargin:10
            horizontalCenter:parent.horizontalCenter
        }
        antialiasing: true
        theme: ChartView.ChartThemeDark

        property int  timcnt: 0
        property double  valueCH1: 0
        property double  valueCH2: 0
        property double  valueCH3: 0
        property double  valueCH4: 0

        ValueAxis{
            id:xAxis
            min: cv.timcnt < 10 ? 0 : cv.timcnt - 10
            max: cv.timcnt < 10 ? 10 : cv.timcnt + 1
            tickCount: 11
            labelFormat: "%d"
        }

        ValueAxis{
            id:yAxis
            min: 0
            max: 500
            tickCount: 1
            labelFormat: "%d"
        }

        LineSeries {
            name: "CH1"
            id:lines1
            axisX: xAxis
            axisY: yAxis
            width: 3
            color: "#1267D4"
        }

        LineSeries {
            name: "CH2"
            id:lines2
            axisX: xAxis
            axisY: yAxis
            width: 3
            color: "#8D7A1F"
        }

        LineSeries {
            name: "CH3"
            id:lines3
            axisX: xAxis
            axisY: yAxis
            width: 3
            color: "#8A1E1D"
        }

        LineSeries {
            name: "CH4"
            id:lines4
            axisX: xAxis
            axisY: yAxis
            width: 3
            color: "#C21FE4"
        }

        Timer{
            id:tm
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                cv.timcnt = cv.timcnt + 1
                cv.valueCH1 = _Controler.get_adc1()
                cv.valueCH2 = _Controler.get_adc2()
                cv.valueCH3 = _Controler.get_adc3()
                cv.valueCH4 = _Controler.get_adc4()

                lines1.append(cv.timcnt,cv.valueCH1)
                lines2.append(cv.timcnt,cv.valueCH2)
                lines3.append(cv.timcnt,cv.valueCH3)
                lines4.append(cv.timcnt,cv.valueCH4)

                console.log("--------------------")
                console.log("qml adc value1:",cv.valueCH1)
                console.log("qml adc value2:",cv.valueCH2)
                console.log("qml adc value3:",cv.valueCH3)
                console.log("qml adc value4:",cv.valueCH4)

            }
        }
    }
}


