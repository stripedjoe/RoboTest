#!/usr/bin/env pybricks-micropython
# do not remove above, you'll get permission denied
# from pybricks.hubs import EV3Brick
from bluetoothmanager import BluetoothManager
from cylindercontroller import CylinderController


def main():
    message_received = BluetoothManager.listen_to_message()  # party
    CylinderController.turn_cyclinder(message_received)


main()
