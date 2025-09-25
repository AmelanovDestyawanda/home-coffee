import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:brew_verse/models/menu_screen.dart';
import 'package:brew_verse/splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'models/main_navigation.dart';
import 'provider/cart_provider.dart';
import 'models/cart_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const HomeCoffeeApp(),
    ),
  );
}

class HomeCoffeeApp extends StatelessWidget {
  const HomeCoffeeApp({super.key});

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
        '/home': (context) => const MenuScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
