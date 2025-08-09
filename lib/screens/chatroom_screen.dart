import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  String ChatroomName;
  String ChatroomId;

  ChatroomScreen({
    super.key,
    required this.ChatroomName,
    required this.ChatroomId,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.ChatroomName)),

      body: Column(
        children: [
          Expanded(child: Container(color: Colors.red)),

          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Expanded(child: TextField()), Icon(Icons.send)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
