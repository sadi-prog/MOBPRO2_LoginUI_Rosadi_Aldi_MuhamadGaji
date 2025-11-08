import 'package:flutter/material.dart';
import 'dart:ui';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Login berhasil! Selamat datang di DompetKu "),
          backgroundColor: Colors.tealAccent.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi email dan password!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFF667EEA),
                      Color(0xFF4FD1C5),
                      Color(0xFF764BA2),
                    ],
                    stops: [0.0, 0.5 + (0.1 * _controller.value), 1.0],
                  ),
                ),
              );
            },
          ),

          // Floating glow circles
          Positioned(
            top: 100,
            left: -80,
            child: _glowOrb(300, Colors.blueAccent.withOpacity(0.3)),
          ),
          Positioned(
            bottom: 100,
            right: -60,
            child: _glowOrb(250, Colors.purpleAccent.withOpacity(0.25)),
          ),
          Positioned(
            top: 300,
            right: 30,
            child: _glowOrb(200, Colors.tealAccent.withOpacity(0.25)),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 380,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo + App Name
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.tealAccent.withOpacity(0.4),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                              size: 70,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "DompetKu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.black26, blurRadius: 10),
                            ],
                          ),
                        ),
                        const Text(
                          "Kelola Keuangan Lebih Cerdas",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 40),

                        // Input fields
                        _inputField(
                          label: "Email / Username",
                          controller: _emailController,
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        _inputField(
                          label: "Password",
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),

                        // Login button
                        ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF667EEA),
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadowColor: Colors.tealAccent.withOpacity(0.5),
                            elevation: 10,
                          ),
                          child: const Text(
                            "Masuk",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Signup text
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Fitur pendaftaran akan segera hadir!",
                                ),
                                backgroundColor: Colors.tealAccent,
                              ),
                            );
                          },
                          child: const Text(
                            "Belum punya akun? Daftar Sekarang",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable glow orb
  Widget _glowOrb(double size, Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            20 * (0.5 - _controller.value),
            30 * (0.5 - _controller.value),
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.7),
                  blurRadius: 80,
                  spreadRadius: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reusable input field
  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.tealAccent, width: 1.5),
        ),
      ),
    );
  }
}
