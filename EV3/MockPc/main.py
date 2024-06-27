#!/usr/bin/env python3
from time import sleep

from pybricks.messaging import TextMailbox, BluetoothMailboxServer

server = BluetoothMailboxServer()
mbox = TextMailbox('greeting', server)

try:
    while True:
        # The server must be started before the client!
        print('waiting for connection...')
        server.wait_for_connection()
        print('connected!')

        # In this program, the server waits for the client to send the first message
        # and then sends a reply.
        mbox.wait()
        print('wait done')

        message_received = mbox.read()
        print('Message received: ', message_received)
        mbox.send('hello to you!')

        print('sleep 2')
        sleep(2)

except Exception as e:
    print("An error occurred:", e)

print("All good")
