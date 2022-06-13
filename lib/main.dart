import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark().copyWith(
              textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.black54),
              ),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => WelcomeScreen(),
              '/login': (context) => LoginScreen(),
              '/registration': (context) => RegistrationScreen(),
              '/chat': (context) => ChatScreen()
            },
          );
        }
        return const Text('Loading...');
      },
    );
  }
}
