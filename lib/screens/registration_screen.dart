import 'package:chat_app/component/loading.dart';
import 'package:chat_app/component/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 100),
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email'),
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your password'),
                    style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.blueAccent,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, '/chat');
                          }
                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                        }
                      }),
                ],
              ),
            ),
          ),
          loading ? const LoadingWidget() : const SizedBox()
        ],
      ),
    );
  }
}
