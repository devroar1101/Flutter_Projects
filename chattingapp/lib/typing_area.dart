import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TypingAreaWidget extends StatefulWidget {
  const TypingAreaWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TypingAreaWidgetState();
  }
}

class TypingAreaWidgetState extends State<TypingAreaWidget> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      print('Message is empty, not sending.');
      return;
    }
    FocusScope.of(context).unfocus();

    final messageText = messageController.text;
    messageController.clear();

    // Ensure user is logged in
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userdata.exists) {
      print('User data does not exist.');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('chats').add({
        'message': messageText,
        'time': Timestamp.now(),
        'createdBy': user.uid,
        'username': userdata.data()?['username'] ?? 'Unknown User',
        'imageUrl': userdata.data()?['imageUrl'] ?? '',
      });
      print('Message sent to Firestore.');
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            autocorrect: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), label: Text('send a message')),
            textCapitalization: TextCapitalization.sentences,
            controller: messageController,
          )),
          const SizedBox(
            width: 10,
          ),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
