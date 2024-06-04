import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signalr_netcore/signalr_client.dart';

class PubSubPage extends StatefulWidget {
  const PubSubPage({super.key});

  @override
  State<PubSubPage> createState() => _PubSubPageState();
}

class _PubSubPageState extends State<PubSubPage> {
  // localhost http://10.0.2.2:7167/api/
  final String postEndPoint =
      'https://flutterpocfunction.azurewebsites.net/api/PostTriggerAsync';
  final String serverUrl =
      'https://iothublistenerfunction.azurewebsites.net/api/';
  late TextEditingController textController;
  String _message = '';
  String _sent = '';

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    initSignalR();
  }

  @override
  dispose() {
    textController.dispose();
    super.dispose();
  }

  void initSignalR() {
    final hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.start();
    hubConnection.on("newSentMessage", _receivedMessage);
  }

  void _setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _sendMessage() async {
    var response = await http.post(Uri.parse(postEndPoint), body: _message);
    setState(() {
      _sent = "Message Sent! ${response.body}";
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          _sent = '';
        });
      });
    });
  }

  void _receivedMessage(List<Object?>? parameters) {
    String? message = parameters?[0].toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Received Message'),
          content: Text(message ?? 'No message received'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter IoT Arduino'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Message to be sent:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 350.0,
              child: TextField(
                controller: textController,
                onChanged: _setMessage,
                decoration: InputDecoration(
                  hintText: 'Enter your message here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
                onPressed: () {
                  _sendMessage();
                  textController.clear();
                  FocusScope.of(context).unfocus();
                },
                color: Theme.of(context).colorScheme.inversePrimary,
                child: const Text('Send Message')),
            const SizedBox(height: 20.0),
            Text(_sent),
          ],
        ),
      ),
    );
  }
}
