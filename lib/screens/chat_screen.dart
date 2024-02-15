import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat/messages.dart';

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
      body: Container(
        child: const Column(
          children: [
            Expanded(child: Messages()),
          ],
        ),
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
