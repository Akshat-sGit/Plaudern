// import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  void navigateToChatScreen(BuildContext context, user) {
    // User? user = FirebaseAuth.instance.currentUser;
    try{
    if (user != null) {
      Navigator.pushNamed(context, ChatScreen.id);
    } 
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: decoration.copyWith(hintText: "Enter your email"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: decoration.copyWith(hintText: "Enter your password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                colour: Colors.lightBlue,
                title: "Log In",
                onPressed: () {
                  try {
                    // ignore: unused_local_variable
                    final user = _auth.signInWithEmailAndPassword(email: email, password: password);
                    navigateToChatScreen(context, user); 
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
