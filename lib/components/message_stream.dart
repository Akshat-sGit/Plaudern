import 'package:flutter/material.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart'; 
import 'package:flash_chat_flutter/components/message_bubble.dart';

final _fireStore = FirebaseFirestore.instance;

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('1').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final message = snapshot.data!.docs;
          List<MessageBubble> messageWidgets =
              []; // Changed List<Text> to List<Widget>

          for (var messages in message) {
            final messageText = messages.get('text');
            final messageSender = messages.get('sender');

            final currentUser = loggedInUser.email;

            if (currentUser == messageSender) {}

            final messageWidget =
                MessageBubble(
                  text: messageText, 
                  sender: messageSender,
                  isMe: currentUser==messageSender ,
                );

            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
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