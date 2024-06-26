from colorcontroller import ColorController
from pybricks.tools import wait


class CylinderController:

    @staticmethod
    def turn_cyclinder(selected: str):
        while True:
            color_int = ColorController.get_color()
            if 110 <= color_int <= 165 and selected == "party":
                print("put logic of motor to turn until if detects green")
                break

            wait(100)
            # continue paikutin
