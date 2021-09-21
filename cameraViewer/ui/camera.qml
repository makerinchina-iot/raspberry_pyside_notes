import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0
//import QtMultimedia 5.11
import Qt.labs.folderlistmodel 2.0

ApplicationWindow{
    id:root
    width: 800
    height: 480

    visible: true
    visibility: Window.FullScreen

    background: Rectangle{
        color: "#101010"
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
        height: 32
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
                pointSize: 24
            }
            color: "white"
        }
        onClicked: {
            _Controler.exit();
        }
    }

    Text {
        id: title
        text: qsTr("Camera Viewer")
        anchors{
            top:  parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 10
        }
        font{
            pointSize: 24
        }
        color: "#e0e0f0"
    }

    Item {
        id: cameraitem
        width: 800
        height: 420
        anchors{
            top: title.bottom
            topMargin: 6
        }

        property  double brightless: 0

        Camera{
            id:camera
            viewfinder
            {
                resolution: Qt.size(800, 480)
                maximumFrameRate: 30
            }
            imageProcessing{
                brightness: cameraitem.brightless
                whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
            }
            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposurePortrait
            }
            flash.mode: Camera.FlashRedEyeReduction

            imageCapture{
                id:cameraCaptureImage
                onImageCaptured: {
                    photopreview.source = preview
//                    photopreview.visible = true
                    console.log("captured image:",preview)
                }
            }

            digitalZoom: sliderZoom.value
        }

        VideoOutput{
            id:viewer
            anchors.fill: parent
            source: camera
            autoOrientation: true
            focus: visible
            fillMode: VideoOutput.PreserveAspectCrop
        }

        Text {
            id:  lableBrightless
            text: qsTr("Brightless:")
            color: "white"
            font.pointSize: 12
            anchors{
                left: parent.left
                leftMargin: 20
                top: parent.top
                topMargin: 40
            }
        }

        Slider{
            id:slidBrightless
            width: 200
            from:-1.00
            to:1.00
            stepSize: 0.1
            anchors{
                left: lableBrightless.right
                leftMargin: 20
                verticalCenter: lableBrightless.verticalCenter
            }
            onValueChanged: {
                console.log("change brightless:",value)
                cameraitem.brightless = value
            }
        }

        Text {
            id:  lableZoom
            text: qsTr("Zoom:")
            color: "white"
            font.pointSize: 12
            anchors{
                left: lableBrightless.left
                top: lableBrightless.bottom
                topMargin: 20
            }
        }

        Slider{
            id:sliderZoom
            width: 200
            from:0
            to:camera.maximumDigitalZoom
            stepSize: camera.maximumDigitalZoom/10
            anchors{
                left: slidBrightless.left
                verticalCenter: lableZoom.verticalCenter
            }
            onValueChanged: {
                console.log("change zoom:",value)
                camera.setDigitalZoom(value)
            }
        }

        Image {
            id: imagetemp
            source: "./imagetemp.svg"
            width: 84
            height: 84

            anchors{
                left: parent.left
                leftMargin: 40
                bottom: parent.bottom
                bottomMargin: 20
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    photolist.visible=false
                    backbutton.visible=true
                    cameraitem.visible=false
                    photopreview.visible=true
                }
                onPressed: {
                    parent.scale=1.4
                }
                onReleased: {
                    parent.scale=1.0
                }
            }
        }

        Rectangle{
            id:imagecapture
            width: 94
            height: 94
            radius: 47
            color: "#b0b0b0"
            Rectangle{
                id:backs
                width: 74
                height: 74
                radius: 37
                anchors{
                    left:parent.left
                    top:parent.top
                    leftMargin: 10
                    topMargin: 10
                }
                color: "#f06060"
            }
            anchors{
                bottom: parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    camera.imageCapture.capture()
                }
                onPressed: {
                    backs.color="#f01010"
                    backs.scale=0.6
                }
                onReleased: {
                    backs.color="#f06060"
                    backs.scale=1.0
                }
            }
        }

        Image {
            id: iamgefolder
            source: "./imagefolder.svg"
            width: 64
            height: 64
            anchors{
                right: parent.right
                rightMargin: 40
                bottom: parent.bottom
                bottomMargin: 30
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    photolist.visible=true
                    backbutton.visible=true
                    cameraitem.visible=false
                    photopreview.visible=false
                }
                onPressed: {
                    parent.scale=1.4
                }
                onReleased: {
                    parent.scale=1.0
                }
            }
        }


    }


    Image{
        id:photopreview
        width: cameraitem.width-40
        height: cameraitem.height-40
        anchors.top: cameraitem.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectCrop

        visible: false
    }

    Item{
        id:photolist
        visible: false
        anchors.fill: cameraitem

        property string path: "file:///home/pi/Pictures/"


        GridView{
            anchors.fill: parent
            clip: true
            cellWidth: 200
            cellHeight: 120

            FolderListModel{
                id:folerModel
                showDirs: false
                folder: photolist.path

            }
            model: folerModel
            delegate: imagedelegate
            Component {
                id:imagedelegate
                Image {
                    id: imageitem
                    width: 200-4
                    height: 120-4
                    source: photolist.path + fileName
                }
            }
        }

    }

    Image{
        id:backbutton
        source: "./back.svg"
        width: 48
        height: 32
        visible: false
        anchors{
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: 10
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                photolist.visible=false
                photopreview.visible=false
                cameraitem.visible = true
                backbutton.visible=false
            }
        }
    }

}


