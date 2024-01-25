// import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/view/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/widgets/rounded_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool showSpinner = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo1.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: decoration.copyWith(
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(color: Colors.black),
                ),

              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: passwordController,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: decoration.copyWith(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: Colors.white)),
                obscureText: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.lightBlue,
                  title: "Log In",
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      // ignore: unused_local_variable
                      final user = _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      // ignore: unrelated_type_equality_checks
                      if (user != _auth.currentUser) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      // clear the text field
                      emailController.clear();
                      passwordController.clear();
                    } catch (e) {
                      // ignore: avoid_print
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
