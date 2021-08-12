
# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtCore import Qt, QObject, Slot, QTimer
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from gpiozero import TonalBuzzer
from gpiozero.tones import Tone


class Controler(QObject):

    buzzer = TonalBuzzer(25)

    def __init__(self):
        super().__init__()

    @Slot()
    def exit(self):
        sys.exit()

    @Slot(str)
    def play(self,mid_tone):
        self.buzzer.play(Tone(mid_tone))
        print("play.")
        QTimer.singleShot(200, lambda: self.stop())

    def stop(self):
        self.buzzer.stop()
        print("stop.")

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    app.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler", controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())