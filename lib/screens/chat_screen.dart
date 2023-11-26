import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _fireStore.collection('1').snapshots()) {
      for (var message in snapshot.docs) {
        // ignore: avoid_print
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                //Implemented logout functionality
                _auth.signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName("login_screen"));
                // messagesStream();
              }),
        ],
        title: const Text(
          'Chat',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                      onPressed: () {
                        messageTextController.clear();
                        //Implement send functionality.
                        _fireStore.collection('1').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.text, required this.sender, required this.isMe});

  final String sender;
  final String text;
  final bool isMe; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          Material(
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(30.0),
              bottomStart: Radius.circular(30.0),
              bottomEnd: Radius.circular(30.0),
            ),
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
