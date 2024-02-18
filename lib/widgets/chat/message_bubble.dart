import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key keey;
  final String message;
  final String userName;
  final bool isMe;
  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.keey,
    super.key,
    required this.userName,
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
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
