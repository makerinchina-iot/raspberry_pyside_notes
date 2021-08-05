
# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtCore import Qt, QObject, Slot
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from gpiozero import PWMLED


class Controler(QObject):

    led = PWMLED(26)

    def __init__(self):
        super().__init__()

    @Slot()
    def exit(self):
        sys.exit()

    @Slot(int)
    def changeLEDPWM(self,value):
        print("set led pwm:", value)
        self.led.value = value/100.00

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    app.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler", controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/qml/dashboard.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())