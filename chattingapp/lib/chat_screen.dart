import 'package:chattingapp/message_area.dart';
import 'package:chattingapp/typing_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: const Column(
        children: [Expanded(child: MessageAreaWidget()), TypingAreaWidget()],
      ),
    );
  }
}
