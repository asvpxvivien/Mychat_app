import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderName;
  final String? senderId;
  final String text;
  final DateTime? timestamp;
  final String chatroomId;
  final List<String> readBy;

  Message({
    required this.id,
    required this.senderName,
    required this.text,
    required this.chatroomId,
    this.timestamp,
    this.senderId,
    this.readBy = const [],
  });

  Map<String, Object?> toMap() {
    return {
      'sender_name': senderName,
      'sender_id': senderId,
      'text': text,
      'chatroom_id': chatroomId,
      'timestamp':
          timestamp != null
              ? Timestamp.fromDate(timestamp!)
              : FieldValue.serverTimestamp(),
      'read_by': readBy,
    };
  }

  static Message fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    return Message(
      id: doc.id,
      senderName: data?["sender_name"]?.toString() ?? "Inconnu",
      senderId: data?["sender_id"]?.toString(),
      text: data?["text"]?.toString() ?? "(message supprimé)",
      chatroomId: data?["chatroom_id"]?.toString() ?? "",
      timestamp:
          (data?["timestamp"] is Timestamp)
              ? (data?["timestamp"] as Timestamp).toDate()
              : null,
      readBy:
          (data?["read_by"] is List)
              ? (List.from(data?["read_by"])..removeWhere(
                (e) => e == null,
              )).map((e) => e.toString()).toList()
              : const [],
    );
  }

  static Map<String, Object?> toFirestore(
    Message message,
    SetOptions? options,
  ) {
    return message.toMap();
  }
}
