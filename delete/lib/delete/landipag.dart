import 'package:delete/delete/flutt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandiPage extends StatefulWidget {
  final List messages;

  const LandiPage({Key? key, required this.messages}) : super(key: key);

  @override
  State<LandiPage> createState() => _LandiPageState();
}

class _LandiPageState extends State<LandiPage> {
  late List<bool> isEditModeList; // Track edit mode for each item
  // ignore: unused_field
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize isEditModeList with false for each item
    isEditModeList = List<bool>.filled(widget.messages.length, false);
  }

  void updateData(Map<String, dynamic> updatedData) async {
    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse('http://localhost:5000/update_data'),
      // Uri.parse('http://192.168.133.39:5000/update_data'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landi Page'),
      ),
      body: ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 24,
                  ),
                ),
                title: Center(
                  child: isEditModeList[index]
                      ? TextField(
                          controller: _controller2,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            // labelText: widget.messages[index]['Username'],
                          ),
                          enabled: true, // Enable editing
                        )
                      : Text(
                          widget.messages[index]['Username'],
                        ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isEditModeList[index] = !isEditModeList[index];
                        });
                        if (!isEditModeList[index]) {
                          // If exiting edit mode, update data
                          Map<String, dynamic> updatedData = {
                            '_id': widget.messages[index]['_id'],
                            'Username': _controller2.text,
                          };
                          print(updatedData);
                          updateData(updatedData);
                        }
                      },
                      child: Icon(
                        isEditModeList[index] ? Icons.check : Icons.edit,
                        color: isEditModeList[index]
                            ? Colors.green
                            : const Color.fromARGB(255, 82, 197, 255),
                      ),
                    ),
                    // SizedBox(width: 5,),
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          isEditModeList[index] = !isEditModeList[index];
                        });
                        Map<String, dynamic> updatedData = {
                          '_id': widget.messages[index]['_id'],
                          'delete': 10,
                        };
                        updateData(updatedData);
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataSender(),
                          ),
                        );
                      },
                      // child: Icon(
                      //   isEditModeList[index]
                      //       ? Icons.delete
                      //       : Icons.delete,
                      //   color: isEditModeList[index] ? Colors.red : Colors.red,
                      // ),
                      child: const Icon(Icons.delete,color: Colors.red,),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
