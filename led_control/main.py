import os
import sys
from pathlib import Path

from PySide2.QtCore import QObject, Slot
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from gpiozero import LED


class Control(QObject):
    led = LED(26)
    @Slot()
    def ledOn(self):
        print("led on")
        self.led.on()

    @Slot()
    def ledOff(self):
        print("led off")
        self.led.off()

if __name__=="__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    context = engine.rootContext()
    controler = Control()
    context.setContextProperty("_Control",controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/led.qml"))
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())