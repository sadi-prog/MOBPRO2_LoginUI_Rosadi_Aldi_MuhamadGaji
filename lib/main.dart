import 'package:flutter/material.dart';

class TugasLoginPage extends StatelessWidget {
  const TugasLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Login')),
      body: const Center(
        child: Text('Ini Halaman Login Kamu'),
      ),
    );
  }
}
