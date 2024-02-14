import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyChat App'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            items: const [
              DropdownMenuItem(
                value: "LogOut",
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text("Log Out"),
                  ],
                ),
              ),
            ],
            onChanged: (value) {
              if (value == "LogOut") {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/VeS3TNmBWTduirHaGs1x/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = streamSnapshot.data!.docs;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(messages[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/VeS3TNmBWTduirHaGs1x/messages")
              .add(
            {"text": "Hello World!"},
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
