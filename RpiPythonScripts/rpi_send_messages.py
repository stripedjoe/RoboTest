from azure.iot.device import IoTHubDeviceClient, Message

CONNECTION_STRING = "HostName=IotHubPGlobalPoC.azure-devices.net;DeviceId=RpiPoCDevice;SharedAccessKey=rLPG+ySg4ul1/Oo1DU1h0yKxvs/4EDenQAIoTFh3S4U="

def send_message():
    try:
        client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
        client.connect()

        # Create a message
        message = Message("Sending a message: 2:00pm")

        # Send the message
        client.send_message(message)
        print("Message sent:", message)

        # Disconnect the client
        client.disconnect()

    except Exception as ex:
        print("An error occurred while sending the message:")
        print(ex)

if __name__ == "__main__":
    send_message()
