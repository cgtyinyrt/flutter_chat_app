import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_app/services/auth/auth_gate.dart';
import 'package:flutter_chat_app/services/notification/firebase_api.dart';
import 'package:flutter_chat_app/themes/dark_mode.dart';
import 'package:flutter_chat_app/themes/light_mode.dart';
import 'package:flutter_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
