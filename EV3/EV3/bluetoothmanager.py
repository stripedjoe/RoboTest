from pybricks.hubs import EV3Brick
from pybricks.messaging import BluetoothMailboxServer, TextMailbox, BluetoothMailboxClient


class BluetoothManager:
    @staticmethod
    def listen_to_message() -> str:
        # # ToDo. to be changed soon, https://pybricks.com/ev3-micropython/messaging.html
        # ev3 = EV3Brick()
        # ev3.speaker.beep()

        SERVER = 'ev3dev'
        client = BluetoothMailboxClient()
        mbox = TextMailbox('greeting', client)

        print('establishing connection...')
        client.connect(SERVER)
        print('connected!')

        # In this program, the client sends the first message and then waits for the
        # server to reply.
        mbox.send('hello!')
        mbox.wait()
        message_received = mbox.read()
        print(mbox.read())
        return message_received
