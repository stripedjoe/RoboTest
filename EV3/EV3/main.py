#!/usr/bin/env pybricks-micropython
# do not remove above, you'll get permission denied
# from pybricks.hubs import EV3Brick
from bluetoothmanager import BluetoothManager


def main():
    # ev3 = EV3Brick()
    # ev3.speaker.beep()
    BluetoothManager.listen_to_message()


main()
