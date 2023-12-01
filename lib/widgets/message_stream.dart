import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/view/chat/chat_screen.dart';
import 'package:flash_chat_flutter/widgets/message_bubble.dart';

final _fireStore = FirebaseFirestore.instance;

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final message = snapshot.data!.docs.reversed;
          List<MessageBubble> messageWidgets =
              []; // Changed List<Text> to List<Widget>

          for (var messages in message) {
            final messageText = messages.get('text');
            final messageSender = messages.get('sender');
            final messageTime = messages.get('time');

            final currentUser = loggedInUser.email;

            if (currentUser == messageSender) {}

            final messageWidget = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
              time: messageTime,
            );

            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              // reverse: true,
              children: messageWidgets,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
