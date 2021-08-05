
import QtQuick 2.11
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtGraphicalEffects 1.0


Slider {
    id: root

    property color checkedColor: "#3498DB"

    value: 0.5

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 400
        implicitHeight: 22
        width: root.availableWidth
        height: implicitHeight
        radius: height / 2
        color: "#8B8D8F"

        Rectangle {
            width: root.visualPosition == 0 ? 0 : root.handle.x + root.handle.width / 2
            height: parent.height
            color: root.checkedColor
            radius: height / 2


            layer.enabled: root.hovered | root.pressed
            layer.effect: DropShadow {
                transparentBorder: true
                color: root.checkedColor
                samples: 8
            }
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: root.background.implicitHeight + 12
        implicitHeight: implicitWidth
        radius: implicitWidth / 2
        color: root.pressed ? Qt.darker(root.checkedColor, 1.2) : root.checkedColor

        layer.enabled: root.hovered | root.pressed
        layer.effect: DropShadow {
            transparentBorder: true
            color: root.checkedColor
            samples: 10
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
