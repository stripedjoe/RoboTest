import bluetooth
import struct
import enum


class MessageType(enum.Enum):
    Text = 0
    Numeric = 1
    Logic = 2


class BluetoothSender:
    @staticmethod
    def send_message_to_device(mac_address: str, message: str):
        try:
            sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
            sock.connect((mac_address, 1))

            encoded_message = BluetoothSender.__encode_message(MessageType.Text, 'abc', message)
            sock.send(encoded_message)
            print(f"Sent message: {message}")

            sock.close()
        except bluetooth.btcommon.BluetoothError as err:
            print(f"Bluetooth error: {err}")

    @staticmethod
    def __encode_message(msg_type: MessageType, mail, value):
        mail = mail + '\x00'
        mail_bytes = mail.encode('ascii')
        mail_size = len(mail_bytes)
        fmt = '<H4BB' + str(mail_size) + 'sH'

        if msg_type == MessageType.Logic:
            value_size = 1
            value_bytes = 1 if value is True else 0
            fmt += 'B'
        elif msg_type == MessageType.Numeric:
            value_size = 4
            value_bytes = float(value)
            fmt += 'f'
        else:
            value = value + '\x00'
            value_bytes = value.encode('ascii')
            value_size = len(value_bytes)
            fmt += str(value_size) + 's'

        payloadSize = 7 + mail_size + value_size
        s = struct.pack(fmt, payloadSize, 0x01, 0x00, 0x81, 0x9e, mail_size, mail_bytes, value_size, value_bytes)
        return s
