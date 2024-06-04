import bluetooth

MAC_ADDRESS = '00:16:53:5F:6B:CF'

def send_message_to_ev3(message):
    try:
        sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
        sock.connect((MAC_ADDRESS, 1))

        sock.send(message)
        print(f"Sent message: {message}")

        sock.close()
    except bluetooth.btcommon.BluetoothError as err:
        print(f"Bluetooth error: {err}")

if __name__ == "__main__":
    message = "hello"
    print("Sending message to EV3...")
    send_message_to_ev3(message)