import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_talk/services/auth/login_or_register.dart';
import 'package:talk_talk/pages/homepage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  Homepage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
