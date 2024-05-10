import 'package:delete/delete/landipag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataSender extends StatefulWidget {
  const DataSender({super.key});

  @override
  _DataSenderState createState() => _DataSenderState();
}

class _DataSenderState extends State<DataSender> {
  final TextEditingController _controller = TextEditingController();
  dynamic messageData;

  void sendData() async {
    final response = await http.post(
      // Uri.parse('http://192.168.133.39:5000/send_data'),
      Uri.parse('http://localhost:5000/send_data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'data': _controller.text}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      messageData = responseData['data']; // Update the class-level variable

      // Do something with the received data (e.g., display it)
      print('JOlly :  $messageData');

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandiPage(messages: messageData),
        ),
      );

      print(response.toString()); //summa
      print('Data sent successfully');
    } else {
      print('Failed to send data');
    }
  }

// this function used to receive the data only for view pupose
  void receiveData() async {
    final response = await http.post(
      // Uri.parse('http://192.168.133.39:5000/receive_data'),
      Uri.parse('http://localhost:5000/receive_data'),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      messageData = responseData['data']; // Update the class-level variable

      // Do something with the received data (e.g., display it)
      print('JOlly received :  $messageData');
      if (messageData != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandiPage(messages: messageData),
          ),
        );
      } else {
        print('Message data not available');
      }

      print(response.toString()); //summa
      print('Data received successfully');
    } else {
      print('Failed to send data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Sender'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter data to send',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendData,
              child: const Text('Send Data'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          receiveData(); //receive the data from mongodb and flask
        },
        child: const Icon(Icons.near_me),
      ),
    );
  }
}
