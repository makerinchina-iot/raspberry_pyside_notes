import math
import os
import sys
import time
from pathlib import Path

from PySide2.QtCore import Qt, QObject, Slot
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication

class Controler(QObject):

    def __init__(self):
        super().__init__()
        self.tempValue = 0

    @Slot()
    def exit(self):
        sys.exit()

    @Slot(result=float)
    def getTempValue(self):
        file_name = os.path.join("/", "mnt", "1wire", "uncached", "28.99E88D0D0000", "temperature")

        file_object = open(file_name, 'r')
        temp = file_object.read()

        self.tempValue = float(temp)

        print("tempvalue:",self.tempValue)

        file_object.close()

        return self.tempValue

if __name__=='__main__':

    a = QApplication(sys.argv)

    a.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler", controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/monitor.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(a.exec_())
