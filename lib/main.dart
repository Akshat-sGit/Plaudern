import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/view/welcome_screen.dart';
import 'package:flash_chat_flutter/view/login_screen.dart';
import 'package:flash_chat_flutter/view/registration_screen.dart';
import 'package:flash_chat_flutter/view/chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black54,
            fontSize: 45.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        // all the routes added here
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
