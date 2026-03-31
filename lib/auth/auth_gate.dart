import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/login_or_register_page.dart';
import 'package:flutter_chat_app/screens/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If the snapshot has data, the user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            // If the snapshot does NOT have data, the user is not logged in
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
