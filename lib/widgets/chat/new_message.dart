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

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _typedMessage,
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userName': userData['username'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
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
