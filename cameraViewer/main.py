import os
import sys
from pathlib import Path

from PySide2.QtCore import Qt, QObject, Slot, QCoreApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication


class Controler(QObject):

    def __init__(self):
        super().__init__()

    @Slot()
    def exit(self):
        sys.exit()


if __name__=='__main__':


    a = QApplication(sys.argv)
    a.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler",controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/camera.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(a.exec_())