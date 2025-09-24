import 'package:brew_verse/splash_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'models/main_navigation.dart';

void main() {
  runApp(const BrewVerseApp());
}

class BrewVerseApp extends StatelessWidget {
  const BrewVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew Verse',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}
