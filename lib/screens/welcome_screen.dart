import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/components/rounded_button.dart'; 
import 'package:google_fonts/google_fonts.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
  with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration:const Duration(
        seconds: 3,
      ),
      vsync: this,
      upperBound: 1.0,
    );

    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = ColorTween(
      begin: Colors.blueGrey, 
      end: Colors.black).animate(controller);
    controller.forward();

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }

    controller.addListener(() {
      setState(() {});
      // print(animation.value);
    });

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: controller.value * 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      "Flash Chat",
                      textStyle:GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                      colors: [
                        Colors.white,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                      speed:const Duration(milliseconds: 200),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlue,
              title: "Log In",
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
                colour: const Color.fromARGB(255, 25, 104, 239),
                title: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}

