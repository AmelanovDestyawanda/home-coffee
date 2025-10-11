import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:home/screens/menu_screen.dart';
import 'package:home/screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'main_navigation.dart';
import 'provider/cart_provider.dart';
import 'screens/cart_screen.dart';

// Palet Warna Baru
const Color primaryColor = Color(0xFF6F4E37); // Cokelat Kopi
const Color secondaryColor = Color(0xFFF5F5DC); // Krem
const Color accentColor = Color(0xFFE67E22); // Oranye

void main() {
  runApp(
    MultiProvider( providers: [
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
        // DIUBAH: Menggunakan nama family font yang sudah kita daftarkan
        fontFamily: 'Poppins', 
        
        // textTheme tidak perlu lagi dibungkus dengan GoogleFonts
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87,
              displayColor: Colors.black87,
            ),
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          background: secondaryColor,
        ),
        
        scaffoldBackgroundColor: secondaryColor, // Latar belakang utama aplikasi
        
        // Tema untuk AppBar
        appBarTheme: const AppBarTheme(
          // DIUBAH: Dari Colors.transparent menjadi warna latar belakang
          backgroundColor: secondaryColor, 
          elevation: 0,
          foregroundColor: primaryColor, // Warna ikon dan teks di AppBar
          centerTitle: true,
        ),
        
        // Tema untuk Tombol
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
        
        // Tema untuk Bottom Navigation Bar
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
        '/home': (context) => const MenuScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}