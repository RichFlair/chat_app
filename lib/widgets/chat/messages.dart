import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = chatSnapshot.data!.docs;
        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              message: messages[index]['text'],
              isMe: messages[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              keey: ValueKey(messages[index].id),
              userName: messages[index]['userName'],
            );
          },
        );
      },
    );
  }
}
