from pybricks.hubs import EV3Brick


class BluetoothManager:
    @staticmethod
    def listen_to_message():
        # ToDo. to be changed soon, https://pybricks.com/ev3-micropython/messaging.html
        ev3 = EV3Brick()
        ev3.speaker.beep()
