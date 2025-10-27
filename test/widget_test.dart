import 'package:flutter/material.dart';
import 'package:flutter_tugaslogin/tugaslogin.dart'; // pastikan path sesuai lokasi file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TugasLoginPage(), // pastikan class ini ada di tugaslogin.dart
    );
  }
}
