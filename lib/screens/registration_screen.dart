import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
// all the firebase auth is completed

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool showSpinner = false;


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
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: decoration.copyWith(hintText: "Enter your email",
                hintStyle:const TextStyle(
                  color: Colors.white
                )
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: decoration.copyWith(hintText: "Enter your password",
                hintStyle:const TextStyle(
                  color: Colors.white
                )
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: const Color.fromARGB(255, 25, 104, 239),
                  title: "Register",
                  onPressed: () {
                    setState(() {
                      showSpinner = true; 
                    });
                    try{
                         _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpinner = false; 
                        });
                      }catch(e){
                        // ignore: avoid_print
                        print(e); 
                      }
                    }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
