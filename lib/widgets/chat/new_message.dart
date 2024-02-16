import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _typedMessage = '';

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _typedMessage,
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(hintText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _typedMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _typedMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
