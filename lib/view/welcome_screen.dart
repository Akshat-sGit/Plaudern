import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/view/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_flutter/view/registration_screen.dart';
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
      duration: const Duration(
        seconds: 3,
      ),
      vsync: this,
      upperBound: 1.0,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.blue)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: controller.value * 100,
                    child: Image.asset('images/logo1.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText("Plaudern",
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          shadows: [
                            const Shadow(
                              color: Color.fromARGB(255, 20, 168, 3),
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                        speed: const Duration(milliseconds: 100)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RawMaterialButton(
                          fillColor: Colors.yellow,
                          elevation: 5.0,
                          shape: const CircleBorder(),
                          constraints: const BoxConstraints.tightFor(
                            width: 100.0,
                            height: 100.0,
                          ),
                          onPressed: () {
                            //Go to login screen.
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: const Icon(
                            Icons.login,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              const Shadow(
                                color: Colors.black,
                                blurRadius: 5.0,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      shape: const CircleBorder(),
                      constraints: const BoxConstraints.tightFor(
                        width: 100.0,
                        height: 100.0,
                      ),
                      fillColor: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: const Icon(
                        Icons.app_registration,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Registrier',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
