import os
import sys
from pathlib import Path

from PySide2.QtCore import Qt, QObject, Slot
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtWidgets import QApplication

from adc_mcp3424 import MCP3424


class Controler(QObject):
    def __init__(self):
        super().__init__()

        self.MCP3424 = MCP3424(6, address=0x68, rate=18)

    @Slot()
    def exit(self):
        sys.exit()

    @Slot(result=float)
    def get_adc1(self):
        adc1 = self.MCP3424.read_raw(1)
        adc1 = adc1/100.00
        # print("adc1:",adc1)
        return adc1

    @Slot(result=float)
    def get_adc2(self):
        adc2 = self.MCP3424.read_raw(2)
        adc2 = adc2/100.00
        # print("adc2:",adc2)
        return adc2

    @Slot(result=float)
    def get_adc3(self):
        adc3 = self.MCP3424.read_raw(3)
        adc3 = adc3/100.00
        # print("adc3:",adc3)
        return adc3

    @Slot(result=float)
    def get_adc4(self):
        adc4 = self.MCP3424.read_raw(4)
        adc4 = adc4/100.00
        # print("adc1:",adc4)
        return adc4

if __name__=='__main__':
    a = QApplication(sys.argv)
    a.setOverrideCursor(Qt.BlankCursor)

    engine = QQmlApplicationEngine()

    controler = Controler()
    context = engine.rootContext()
    context.setContextProperty("_Controler", controler)

    engine.load(os.fspath(Path(__file__).resolve().parent / "ui/adcMeasure.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(a.exec_())