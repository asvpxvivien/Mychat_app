import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat/providers/userProvider.dart';
import 'package:mychat/models/message.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatroomScreen extends StatefulWidget {
  final String chatroomName;
  final String chatroomId;

  const ChatroomScreen({
    super.key,
    required this.chatroomName,
    required this.chatroomId,
  });

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  final db = FirebaseFirestore.instance;
  final TextEditingController messageText = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageText.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    if (messageText.text.trim().isEmpty) {
      return;
    }

    final currentUser = Provider.of<UserProvider>(context, listen: false);

    Map<String, dynamic> messageToSend = {
      "text": messageText.text.trim(),
      "sender_name": currentUser.userName,
      "sender_id": currentUser.userId,
      "chatroom_id": widget.chatroomId,
      "timestamp": FieldValue.serverTimestamp(),
      "read_by": [currentUser.userId],
    };

    try {
      await db.collection("messages").add(messageToSend);
      // Scroll automatiquement vers le bas après envoi
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      print("Erreur lors de l'envoi du message : $e");
    }

    messageText.clear();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      // TODO: Implémenter l'upload d'image vers Firebase Storage
      // et l'envoi du message avec l'URL de l'image
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fonctionnalité d'image à venir !")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatroomName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Message>>(
              stream:
                  db
                      .collection("messages")
                      .withConverter<Message>(
                        fromFirestore: Message.fromFirestore,
                        toFirestore: Message.toFirestore,
                      )
                      .where("chatroom_id", isEqualTo: widget.chatroomId)
                      .orderBy(
                        "timestamp",
                        descending: true,
                      ) // Nouveaux messages en haut
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Aucun message pour l'instant"),
                  );
                }

                final allMessages = snapshot.data!.docs;
                final currentUserId =
                    Provider.of<UserProvider>(context, listen: false).userId;

                return ListView.builder(
                  reverse: true, // Pour avoir les nouveaux messages en bas
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  itemCount: allMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final msg = allMessages[index].data();

                    // Marquer comme lu si le message est d'un autre et non lu
                    if (msg.senderId != currentUserId &&
                        !msg.readBy.contains(currentUserId) &&
                        allMessages[index].reference.id.isNotEmpty) {
                      allMessages[index].reference.update({
                        'read_by': FieldValue.arrayUnion([currentUserId]),
                      });
                    }

                    final String text = msg.text;
                    final String senderName = msg.senderName;
                    final String senderId = msg.senderId ?? '';
                    final String timeStr =
                        msg.timestamp != null
                            ? TimeOfDay.fromDateTime(
                              msg.timestamp!,
                            ).format(context)
                            : '';
                    final bool isMe = senderId == currentUserId;
                    final bool isRead = msg.readBy.contains(currentUserId);

                    return _MessageBubble(
                      isMe: isMe,
                      text: text,
                      senderName: senderName,
                      timeStr: timeStr,
                      isRead: isMe ? isRead : null,
                    );
                  },
                );
              },
            ),
          ),

          SafeArea(
            top: false,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.add_circle_outline),
                    tooltip: "Ajouter une image",
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      textCapitalization: TextCapitalization.sentences,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Écrire un message…",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: messageText,
                    builder: (context, value, _) {
                      final canSend = value.text.trim().isNotEmpty;
                      return IconButton(
                        onPressed: canSend ? sendMessage : null,
                        icon: const Icon(Icons.send),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  final String senderName;
  final String timeStr;
  final bool? isRead; // null = message de l'autre

  const _MessageBubble({
    required this.isMe,
    required this.text,
    required this.senderName,
    required this.timeStr,
    this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bubbleColor =
        isMe ? colorScheme.primaryContainer : colorScheme.surfaceVariant;
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final mainAxis = isMe ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisAlignment: mainAxis,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) ...[const SizedBox(width: 4)],
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: alignment,
                  children: [
                    if (!isMe)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          senderName,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    Text(text),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeStr,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        if (isMe && isRead != null) ...[
                          const SizedBox(width: 6),
                          Icon(
                            isRead! ? Icons.done_all : Icons.done,
                            size: 14,
                            color:
                                isRead!
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).hintColor,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
