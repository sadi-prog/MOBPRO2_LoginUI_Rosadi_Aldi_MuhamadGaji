import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Pastikan path sesuai dengan struktur folder Anda
// Jika HomeScreen ada di file terpisah, import juga: import 'screens/home_screen.dart';

void main() {
  runApp(const FinanceMateApp());
}

class FinanceMateApp extends StatelessWidget {
  const FinanceMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A11CB), // Ungu elegan
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Poppins', // Pastikan tambahkan di pubspec.yaml
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const SplashScreen(), 
    );
  }
}