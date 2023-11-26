import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
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
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implemented logout functionality
                _auth.signOut();
                Navigator.popUntil(
                    context, ModalRoute.withName("login_screen"));
                // messagesStream();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('1').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final message = snapshot.data!.docs;
                  List<Widget> messageWidgets =
                      []; // Changed List<Text> to List<Widget>

                  for (var messages in message) {
                    final messageText = messages.get('text'); 
                    final messageSender = messages.get('sender');
                    final messageWidget =
                        Text('$messageText from $messageSender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: messageWidgets,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
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
