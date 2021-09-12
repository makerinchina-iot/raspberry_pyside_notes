
import os
import sys
from pathlib import Path

import serial
import threading
from PySide2 import QtCore
from PySide2.QtCore import Qt, QObject, Slot
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication

mserial1 = serial.Serial('/dev/ttyAMA1',115200)
mserial2 = serial.Serial('/dev/ttyAMA2',115200)

def Serial1Reading():
    while True:
        while mserial1.inWaiting() > 0:
            s = mserial1.read(mserial1.inWaiting())
            s = s.decode()

            if s != "":
                print("serial1 recv:", s)
                controler.uart1sig.emit(s)

def Serial2Reading():
    while True:
        while mserial2.inWaiting()>0:
            s = mserial2.read(mserial2.inWaiting())
            s = s.decode()

            if s != "":
                print("serail2 recv:",s)
                controler.uart2sig.emit(s)


thread1 = threading.Thread(target=Serial1Reading)
thread2 = threading.Thread(target=Serial2Reading)

class Controler(QObject):

    uart1sig = QtCore.Signal(str)
    uart2sig = QtCore.Signal(str)

    def __init__(self):
        super().__init__()

    @Slot()
    def exit(self):

        sys.exit()

    @Slot(str)
    def uart1send(self,s):
        print("uart1 send:",s)
        if mserial1.isOpen():
            mserial1.write(str(s).encode())

    @Slot(str)
    def uart2send(self,s):
        print("uart2 send:",s)
        if mserial2.isOpen():
            mserial2.write(str(s).encode())

if __name__=='__main__':

    os.environ["QT_IM_MODULE"] = "qtvirtualkeyboard"

    a = QApplication(sys.argv)

    a.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler", controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)

    root = engine.rootObjects()[0]
    controler.uart1sig.connect(root.uart1ReadyRead)
    controler.uart2sig.connect(root.uart2ReadyRead)

    thread1.daemon=True
    thread2.daemon=True
    thread1.start()
    thread2.start()

    sys.exit(a.exec_())
