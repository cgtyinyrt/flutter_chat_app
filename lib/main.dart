import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/login_or_register_page.dart';
import 'package:flutter_chat_app/themes/light_mode.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegisterPage(),
      theme: lightMode,
    );
  }
}
