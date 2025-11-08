import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _orbController;
  late AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    // Controller untuk orb berputar
    _orbController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Controller untuk titik-titik loading (lebih cepat)
    _dotController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();

    // Timer pindah ke login
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _orbController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  // Widget lingkaran glowing yang berputar halus
  Widget _buildGlowOrb(
    double size,
    Color color,
    double top,
    double left,
    double delay,
    double blur,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: AnimatedBuilder(
        animation: _orbController,
        builder: (context, child) {
          final angle = (_orbController.value * 2 * math.pi) + delay;
          final dx = math.sin(angle) * 10;
          final dy = math.cos(angle) * 10;
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color.withOpacity(0.4),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.6),
                    blurRadius: blur,
                    spreadRadius: blur / 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF667EEA),
                  Color(0xFF4FD1C5),
                  Color(0xFF764BA2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Glow orbs animasi
          _buildGlowOrb(300, const Color(0xFF667EEA), 80, -80, 0, 60),
          _buildGlowOrb(250, const Color(0xFF4FD1C5), 500, 280, 1, 50),
          _buildGlowOrb(200, const Color(0xFF764BA2), 300, 50, 2, 40),

          // Konten utama
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan efek glow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x994FD1C5),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Nama aplikasi
                const Text(
                  "DompetKu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color(0x804FD1C5),
                        offset: Offset(0, 2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                const Text(
                  "Kelola Keuangan Lebih Cerdas",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                // Loading dots animasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedBuilder(
                      animation: _dotController,
                      builder: (context, child) {
                        final t = (_dotController.value + (index * 0.2)) % 1;
                        final scale = 1 + (math.sin(t * math.pi * 2) * 0.4);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x994FD1C5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
