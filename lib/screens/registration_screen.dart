import 'package:flash_chat_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              style:const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: decoration.copyWith(hintText: "Enter your password"), 
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                colour:  const Color.fromARGB(255, 25, 104, 239), title: "Register", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
