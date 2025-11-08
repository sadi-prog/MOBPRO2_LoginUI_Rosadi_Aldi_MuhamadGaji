import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _floatA;
  late final Animation<double> _floatB;
  late final Animation<double> _floatC;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatA = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _floatB = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.easeInOut),
      ),
    );

    _floatC = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Navigate after delay (same behavior as original HTML)
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Inline SVGs taken / simplified from your html
  static const String _svgMie = '''
<svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="30" cy="35" r="20" fill="#FFF8E1" stroke="#FF8F00" stroke-width="2"/>
  <path d="M15 35 Q20 25 25 35 Q30 25 35 35 Q40 25 45 35" stroke="#FF6F00" stroke-width="2" fill="none"/>
  <path d="M18 35 Q23 28 28 35 Q33 28 38 35 Q42 28 42 35" stroke="#FF6F00" stroke-width="1.5" fill="none"/>
  <circle cx="25" cy="32" r="2" fill="#FF5722"/>
  <circle cx="35" cy="33" r="1.5" fill="#4CAF50"/>
  <rect x="28" y="15" width="4" height="8" fill="#8D6E63" rx="2"/>
</svg>
''';

  static const String _svgKopi = '''
<svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="20" y="25" width="20" height="25" rx="3" fill="#6D4C41"/>
  <rect x="22" y="27" width="16" height="20" rx="2" fill="#8D6E63"/>
  <ellipse cx="30" cy="28" rx="7" ry="2" fill="#5D4037"/>
  <path d="M40 30 Q45 30 45 35 Q45 40 40 40" stroke="#8D6E63" stroke-width="2" fill="none"/>
  <path d="M25 20 Q25 18 27 18 Q29 18 29 20" stroke="#8D6E63" stroke-width="1.5" fill="none"/>
  <path d="M31 20 Q31 18 33 18 Q35 18 35 20" stroke="#8D6E63" stroke-width="1.5" fill="none"/>
</svg>
''';

  static const String _svgNasi = '''
<svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
  <ellipse cx="30" cy="40" rx="22" ry="8" fill="#FFF8E1" stroke="#FF8F00" stroke-width="2"/>
  <circle cx="25" cy="38" r="2" fill="#FFC107"/>
  <circle cx="35" cy="39" r="1.5" fill="#FF5722"/>
  <circle cx="30" cy="37" r="1" fill="#4CAF50"/>
  <circle cx="28" cy="41" r="1.5" fill="#FFC107"/>
  <circle cx="33" cy="40" r="1" fill="#FF5722"/>
  <rect x="15" y="42" width="8" height="3" fill="#8D6E63" rx="1"/>
  <rect x="37" y="43" width="8" height="3" fill="#8D6E63" rx="1"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFFFF6F00);
    final textColor = const Color(0xFF424242);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFB74D), Color(0xFFFFF3E0), Colors.white],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Food Illustrations Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(0, _floatA.value),
                        child: SvgPicture.string(
                          _svgMie,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Transform.translate(
                        offset: Offset(0, _floatB.value),
                        child: SvgPicture.string(
                          _svgKopi,
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Transform.translate(
                        offset: Offset(0, _floatC.value),
                        child: SvgPicture.string(
                          _svgNasi,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Title & Tagline
                  Column(
                    children: [
                      Text(
                        'KantinYu 🍜',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Pesan, Tunggu, Ambil Tanpa Antre!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Loading spinner
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation(primary),
                      backgroundColor: const Color(0xFFFFE0B2),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
