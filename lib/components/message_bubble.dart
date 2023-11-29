import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe,});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.0),
                    bottomStart: Radius.circular(30.0),
                    bottomEnd: Radius.circular(30.0))
                : const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(30.0),
                    bottomStart: Radius.circular(30.0),
                    bottomEnd: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.green : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
