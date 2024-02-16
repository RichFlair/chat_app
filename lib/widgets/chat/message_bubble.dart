import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  const MessageBubble({
    required this.message,
    required this.isMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Colors.pink,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(14),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(14),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
