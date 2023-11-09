import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart'; 
import 'package:flash_chat_flutter/constants.dart'; 

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 24.0),
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
              style:const TextStyle(
                color: Colors.black, 
              ),
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: decoration.copyWith(hintText: "Enter your email"), 
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              style:const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                //Do something with the user input.
              },  
              decoration: decoration.copyWith(hintText: "Enter your password"),
              obscureText: true, 
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                colour: Colors.lightBlue, title: "Log In", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
