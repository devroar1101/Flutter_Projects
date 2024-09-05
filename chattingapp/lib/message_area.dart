import 'package:chattingapp/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessageAreaWidget extends StatefulWidget {
  const MessageAreaWidget({super.key});

  @override
  State<MessageAreaWidget> createState() => _MessageAreaWidgetState();
}

class _MessageAreaWidgetState extends State<MessageAreaWidget> {
  @override
  void initState() {
    setupMessaging();
    super.initState();
  }

  void setupMessaging() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (ctx, dataSnapshots) {
          if (dataSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (dataSnapshots.data == null || dataSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('no message found'),
            );
          }

          if (dataSnapshots.hasError) {
            return const Center(
              child: Text('something went wrong'),
            );
          }

          final loadedMessages = dataSnapshots.data!.docs;

          return ListView.builder(
              padding: const EdgeInsets.fromLTRB(13, 1, 13, 43),
              reverse: true,
              itemCount: loadedMessages.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessages[index].data();
                final nextMessage = index + 1 < loadedMessages.length
                    ? loadedMessages[index + 1].data()
                    : null;

                final currentUserId = chatMessage['createdBy'];
                final nextUserid =
                    nextMessage != null ? nextMessage['createdBy'] : null;

                if (currentUserId == nextUserid) {
                  return MessageBubble.next(
                      message: chatMessage['message'],
                      isMe: currentUserId ==
                          FirebaseAuth.instance.currentUser!.uid);
                } else {
                  return MessageBubble.first(
                      userImage: chatMessage['imageUrl'],
                      username: chatMessage['username'],
                      message: chatMessage['message'],
                      isMe: currentUserId ==
                          FirebaseAuth.instance.currentUser!.uid);
                }
              });
        });
  }
}
