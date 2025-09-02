import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderName;
  final String text;
  final DateTime? timestamp;
  final String chatroomId;

  Message({
    required this.id,
    required this.senderName,
    required this.text,
    required this.chatroomId,
    this.timestamp,
  });

  /// Factory pour convertir un DocumentSnapshot en Message
  factory Message.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return Message(
      id: doc.id,
      senderName: data?["sender_name"]?.toString() ?? "Inconnu",
      text: data?["text"]?.toString() ?? "(message supprimé)",
      chatroomId: data?["chatroom_id"]?.toString() ?? "",
      timestamp:
          (data?["timestamp"] is Timestamp)
              ? (data?["timestamp"] as Timestamp).toDate()
              : null,
    );
  }
}
