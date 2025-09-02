import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {
  final String ChatroomName;
  final String ChatroomId;

  ChatroomScreen({
    super.key,
    required this.ChatroomName,
    required this.ChatroomId,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  final db = FirebaseFirestore.instance;
  final TextEditingController messageText = TextEditingController();

  Future<void> sendMessage() async {
    if (messageText.text.isEmpty) {
      return;
    }

    Map<String, dynamic> messageToSend = {
      "text": messageText.text,
      "sender_name": Provider.of<UserProvider>(context, listen: false).userName,
      "chatroom_id": widget.ChatroomId,
      "timestamp": FieldValue.serverTimestamp(),
    };

    try {
      await db.collection("messages").add(messageToSend);
    } catch (e) {
      print("Erreur lors de l'envoi : $e");
    }
    messageText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.ChatroomName)),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  db
                      .collection("messages")
                      .where("chatroom_id", isEqualTo: widget.ChatroomId)
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Aucun message pour l'instant"));
                }

                var allMessages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: allMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var message = allMessages[index];
                    return ListTile(
                      title: Text(message["sender_name"] ?? "Inconnu"),
                      subtitle: Text(message["text"] ?? ""),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(onTap: sendMessage, child: Icon(Icons.send)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
