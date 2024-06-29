import time
import pytz
import requests
import bluetooth
from datetime import datetime
from typing import Dict
from dateutil.parser import isoparse
from azure.iot.device import IoTHubDeviceClient

CONNECTION_STRING_IOT_HUB = "HostName=IotHubPGlobalPoC.azure-devices.net;DeviceId=RpiPoCDevice;SharedAccessKey=rLPG+ySg4ul1/Oo1DU1h0yKxvs/4EDenQAIoTFh3S4U="
BASE_URL_API = "https://flutterpocfunction.azurewebsites.net/api"
MAC_ADDRESS_BLUETOOTH_PAIRING = '00:16:53:5F:38:CB'


class Product:
    def __init__(self, name: str, imageUrl: str, category: str, numberEquivalent: str):
        self.name = name
        self.imageUrl = imageUrl
        self.category = category
        self.numberEquivalent = numberEquivalent

    def __repr__(self) -> str:
        return f"Product(name={self.name}, imageUrl={self.imageUrl}, category={self.category}, numberEquivalent={self.numberEquivalent})"


class Category:
    def __init__(self, name: str, numberEquivalent: str, products: list[Dict[str, str]]):
        self.name = name
        self.numberEquivalent = numberEquivalent
        self.products = [Product(**product) for product in products]

    def __repr__(self) -> str:
        return f"Category(name={self.name}, numberEquivalent={self.numberEquivalent}, products={self.products})"


class IotHubListener:
    def __init__(self, connection_string: str, base_url: str, mac_address: str):
        self.__connection_string = connection_string
        self.__base_url = base_url
        self.__mac_address = mac_address
        self.__category_product_collection = []
        self.__script_start_time = datetime.now(pytz.utc)
        self.__client = IoTHubDeviceClient.create_from_connection_string(self.__connection_string)

    def __retry(self):
        print("An error occurred. Retrying in 5 minutes")
        time.sleep(300)
        self.main()

    def __message_handler(self, message):
        try:
            # Get the timestamp property from the message
            message_timestamp = message.custom_properties.get("timestamp")

            if not message_timestamp:
                return

            message_time = message_time = isoparse(message_timestamp)
            if message_time <= self.__script_start_time:
                return

            message_data = message.data.decode('utf-8')
            print(f"Received message: {message_data}")
            self.__send_message_to_bluetooth_device(message_data)

            # # ToDo: use the categoryEquivalent for now
            # # auto detect whether it is product or category so only 1 method to use,
            # # then number equivalent is sent
            # category_equivalent = self.__map_category_to_number_equivalent(message_data)
            # print("Sending message to EV3...")
            # self.__send_message_to_bluetooth_device(category_equivalent)

        except Exception as ex:
            print("An error occurred while handling the message")
            print(ex)

    def __get_all_categories_with_products(self) -> list[Category]:
        url = f"{self.__base_url}/GetAllCategoriesWithProducts"
        response = requests.get(url)

        if response.status_code == 200:
            data = response.json()
            return [Category(**category) for category in data]

        return None

    def __send_message_to_bluetooth_device(self, message: str):
        try:
            sock = bluetooth.BluetoothSocket(bluetooth.RFCOMM)
            sock.connect((self.__mac_address, 1))

            sock.send(message)
            print(f"Sent message to bluetooth device: {message}")

            sock.close()
        except bluetooth.btcommon.BluetoothError as err:
            print(f"Bluetooth error: {err}")

    # ToDo: will use this method later 2
    def __map_category_to_number_equivalent(self, category_name: str) -> str:
        for category in self.__category_product_collection:
            if category.name == category_name:
                return category.numberEquivalent

        return "-1"

    # ToDo: will use this method later
    def __map_product_to_number_equivalent(self, product_name: str) -> str:
        for category in self.__category_product_collection:
            for product in category.products:
                if product.name == product_name:
                    return product.numberEquivalent

        return "-1"

    def main(self):
        try:
            self.__client.connect()
            self.__category_product_collection = self.__get_all_categories_with_products()
            self.__client.on_message_received = self.__message_handler

            print("Listening for IoT Hub, press Ctrl-C to exit")

            while True:
                time.sleep(30)

        except KeyboardInterrupt:
            print("IoT Hub C2D Messaging device stopped")
        except Exception as ex:
            print(ex)
            self.__retry()


if __name__ == '__main__':
    print("Starting listening to commands in 10 secs")
    time.sleep(10)

    listener = IotHubListener(CONNECTION_STRING_IOT_HUB, BASE_URL_API, MAC_ADDRESS_BLUETOOTH_PAIRING)
    listener.main()
