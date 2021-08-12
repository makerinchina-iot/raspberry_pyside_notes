
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
        text: qsTr("BUZZER Control")
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }
        font{
            pointSize: 24
            bold: true
        }
        color: "#1165B7"
    }

    AnimatedImage{
        source: "./image/dance.gif"
        anchors{
            left: parent.left
            top:parent.top
            leftMargin: 40
            topMargin: 40
        }
        width: 200
        height: 160
    }

    Row{
        id:pannelBack
        spacing: 1
        anchors{

            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 30
        }

        Repeater{
            model:8

            Rectangle{
                width: 80
                height: 140
                color: "#C4B197"

            }
        }
    }

    Row{
        spacing: 12
        anchors{

            top: pannelBack.top
            horizontalCenter: parent.horizontalCenter
        }

        Repeater{
            model:7

            Button {
                width: 70
                height: 100

                property color backcolor: "#165D8F"

                background: Rectangle{
                    anchors.fill: parent
                    color: parent.backcolor
                }
                onPressed: {
                    backcolor="#34ADE3"
                }
                onReleased: {
                    backcolor="#165D8F"
                }

                onClicked: {
                    console.log("click:"+index)
                    switch(index){
                    case 0:
                        one.visible=true;
                        one.restart();
                        _Controler.play("C5");
                        break;
                    case 1:
                        two.visible=true;
                        two.restart();
                        _Controler.play("D5");
                        break;
                    case 2:
                        three.visible=true;
                        three.restart();
                        _Controler.play("E5");
                        break;
                    case 3:
                        four.visible=true;
                        four.restart();
                        _Controler.play("F5");
                        break;
                    case 4:
                        five.visible=true;
                        five.restart();
                        _Controler.play("G5");
                        break;
                    case 5:
                        six.visible=true;
                        six.restart();
                        _Controler.play("A5");
                        break;
                    case 6:
                        seven.visible=true;
                        seven.restart();
                        _Controler.play("G4");
                        break;
                    }
                }
            }
        }
    }


    Row{
        spacing: 64
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: pannelBack.top
        }
        Repeater{
            model: ["1","2","3","4","5","6","5."]

            Text {
                text: modelData
                font.pointSize: 24
                color: "#C4A781"
            }
        }

    }

    Image{
//        anchors.centerIn: parent
        id:one
        x:pannelBack.x+50
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/1.svg"
        visible: false

        function restart(){
            anixone.restart();
            aniyone.restart();
            anirone.restart();
        }

        NumberAnimation on y{
            id:anixone
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniyone
            from:pannelBack.x+50
            to: pannelBack.x +400
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirone
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:two
        x:pannelBack.x+120
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/2.svg"
        visible: false

        function restart(){
            anixtwo.restart();
            aniytwo.restart();
            anirtwo.restart();
        }

        NumberAnimation on y{
            id:anixtwo
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniytwo
            from:pannelBack.x+120
            to: pannelBack.x +400+100*1
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirtwo
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:three
        x:pannelBack.x+210
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/3.svg"
        visible: false

        function restart(){
            anixthree.restart();
            aniythree.restart();
            anirthree.restart();
        }

        NumberAnimation on y{
            id:anixthree
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniythree
            from:pannelBack.x+210
            to: pannelBack.x +400+100*2
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirthree
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:four
        x:pannelBack.x+290
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/4.svg"
        visible: false

        function restart(){
            anixfour.restart();
            aniyfour.restart();
            anirfour.restart();
        }

        NumberAnimation on y{
            id:anixfour
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniyfour
            from:pannelBack.x+290
            to: pannelBack.x +400+100*3
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirfour
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:five
        x:pannelBack.x+370
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/5.svg"
        visible: false

        function restart(){
            anixfive.restart();
            aniyfive.restart();
            anirfive.restart();
        }

        NumberAnimation on y{
            id:anixfive
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniyfive
            from:pannelBack.x+370
            to: pannelBack.x +400+100*4
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirfive
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:six
        x:pannelBack.x+460
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/6.svg"
        visible: false

        function restart(){
            anixsix.restart();
            aniysix.restart();
            anirsix.restart();
        }

        NumberAnimation on y{
            id:anixsix
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniysix
            from:pannelBack.x+460
            to: pannelBack.x +400+100*5
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirsix
            to: 720
            duration: 8000
        }

    }

    Image{
//        anchors.centerIn: parent
        id:seven
        x:pannelBack.x+540
        y:pannelBack.y-60
        width: 64
        height: 64
        source: "./image/7.svg"
        visible: false

        function restart(){
            anixseven.restart();
            aniyseven.restart();
            anirseven.restart();
        }

        NumberAnimation on y{
            id:anixseven
            from:pannelBack.y-60
            to: pannelBack.y - 1000
            duration: 20000
            easing.type: Easing.OutCirc

        }

        NumberAnimation on x{
            id:aniyseven
            from:pannelBack.x+540
            to: pannelBack.x +400+100*6
            duration: 8000
            easing.type: Easing.OutBounce
        }

        RotationAnimator on rotation{
            id:anirseven
            to: 720
            duration: 8000
        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:480;width:800}
}
##^##*/
