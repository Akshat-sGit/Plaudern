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

  // void getMessages() async {
  //   final messages = await _fireStore.collection('1').get();
  //   for (var message in messages.docs) {
  //     // ignore: avoid_print
  //     print(message.data());
  //   }
  // }

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
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.popUntil(
                //     context, ModalRoute.withName("login_screen"));
                messagesStream();
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
