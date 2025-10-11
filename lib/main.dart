import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:home/screens/menu_screen.dart';
import 'package:home/screens/splash_screen.dart';
import 'provider/user_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'main_navigation.dart';
import 'provider/cart_provider.dart';
import 'screens/cart_screen.dart';

// Palet Warna
const Color primaryColor = Color(0xFF6F4E37); 
const Color secondaryColor = Color(0xFFF5F5DC); 
const Color accentColor = Color(0xFFE67E22);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const HomeCoffeeApp(),
    ),
  );
}

class HomeCoffeeApp extends StatelessWidget {
  const HomeCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Coffee',
      theme: ThemeData(
        // --- PERUBAHAN UTAMA DI SINI ---
        // Menggunakan GoogleFonts untuk menerapkan tema teks Lato
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          background: secondaryColor,
        ),
        
        scaffoldBackgroundColor: secondaryColor,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: secondaryColor,
          elevation: 0,
          foregroundColor: primaryColor,
          centerTitle: true,
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainNavigation(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}