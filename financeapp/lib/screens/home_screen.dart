import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Default config (mirroring the JS config)
  Map<String, dynamic> config = {
    'background_gradient_start': const Color(0xFF667eea),
    'background_gradient_middle': const Color(0xFF4fd1c5),
    'background_gradient_end': const Color(0xFF764ba2),
    'card_background': Colors.white.withOpacity(0.1),
    'text_color': Colors.white,
    'user_name': 'Rosadi',
    'main_balance': 'Rp 12.500.000',
    'bank_name_1': 'Bank DompetKu',
    'bank_name_2': 'Bank BCA',
    'transaction_1': 'Kopi Janji Jiwa',
    'transaction_2': 'Gaji Bulanan',
  };

  late AnimationController _rotationController;
  late AnimationController _floatController1;
  late AnimationController _floatController2;

  final PageController _pageController = PageController();
  int _currentCard = 0;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _floatController1 = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true);

    _floatController2 = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..repeat(reverse: true);
    _floatController2.value = 0.33; // Delay for second orb
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _floatController1.dispose();
    _floatController2.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              config['background_gradient_start'],
              config['background_gradient_middle'],
              config['background_gradient_end'],
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated background effects
            AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Positioned.fill(
                  child: Transform.rotate(
                    angle: _rotationController.value * 2 * 3.14159,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(-0.5, -0.5),
                          radius: 1.0,
                          colors: [
                            config['background_gradient_middle'].withOpacity(
                              0.15,
                            ),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Glow orbs
            AnimatedBuilder(
              animation: _floatController1,
              builder: (context, child) {
                return Positioned(
                  top:
                      MediaQuery.of(context).size.height * 0.1 +
                      (_floatController1.value * 30),
                  left:
                      -MediaQuery.of(context).size.width * 0.1 +
                      (_floatController1.value * 20),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: config['background_gradient_start'].withOpacity(
                        0.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 100,
                          color: config['background_gradient_start']
                              .withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _floatController2,
              builder: (context, child) {
                return Positioned(
                  bottom:
                      MediaQuery.of(context).size.height * 0.2 +
                      (_floatController2.value * 30),
                  right:
                      -MediaQuery.of(context).size.width * 0.05 -
                      (_floatController2.value * 20),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: config['background_gradient_middle'].withOpacity(
                        0.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 100,
                          color: config['background_gradient_middle']
                              .withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Main content
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double screenWidth = constraints.maxWidth;
                  final double screenHeight = constraints.maxHeight;
                  final bool isSmallScreen = screenWidth < 600;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 20 : 40,
                      vertical: isSmallScreen ? 24 : 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selamat datang kembali,',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 16,
                                      color: config['text_color'].withOpacity(
                                        0.8,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    config['user_name'] + ' 👋',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 20 : 24,
                                      fontWeight: FontWeight.w700,
                                      color: config['text_color'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'DompetKu',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 28,
                                fontWeight: FontWeight.w800,
                                color: config['text_color'],
                                shadows: [
                                  Shadow(
                                    color: config['background_gradient_middle']
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _showMessage('Profil akan segera hadir! 👤'),
                              child: Container(
                                width: isSmallScreen ? 40 : 50,
                                height: isSmallScreen ? 40 : 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isSmallScreen ? 30 : 40),

                        // Balance cards
                        SizedBox(
                          height: isSmallScreen ? 200 : 250,
                          child: PageView(
                            controller: _pageController,
                            physics: const PageScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                _currentCard = index;
                              });
                            },
                            children: [
                              _buildBalanceCard(
                                bankName: config['bank_name_1'],
                                cardType: 'Debit',
                                cardNumber: '**** 2345',
                                balance: config['main_balance'],
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    config['background_gradient_start'],
                                    config['background_gradient_end'],
                                  ],
                                ),
                                onTap: () => _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                ),
                                isSmallScreen: isSmallScreen,
                              ),
                              _buildBalanceCard(
                                bankName: 'Bank BCA',
                                cardType: 'Credit',
                                cardNumber: '**** 5678',
                                balance: 'Rp 1.250.000',
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    config['background_gradient_middle'],
                                    config['background_gradient_start'],
                                  ],
                                ),
                                onTap: () => _pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                ),
                                isSmallScreen: isSmallScreen,
                              ),
                              _buildBalanceCard(
                                bankName: 'Bank BRI',
                                cardType: 'Saving',
                                cardNumber: '**** 9012',
                                balance: 'Rp 850.000',
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    config['background_gradient_end'],
                                    config['background_gradient_middle'],
                                  ],
                                ),
                                onTap: () => _pageController.animateToPage(
                                  3, // arahkan ke kartu Mandiri nanti
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                ),
                                isSmallScreen: isSmallScreen,
                              ),

                              // 🟢 Tambahan kartu baru
                              _buildBalanceCard(
                                bankName: 'Bank Mandiri',
                                cardType: 'Debit',
                                cardNumber: '**** 3456',
                                balance: 'Rp 2.500.000',
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFB75E), // kuning keemasan
                                    Color(0xFFED8F03), // oranye terang
                                  ],
                                ),
                                onTap: () => _pageController.animateToPage(
                                  0, // balik ke kartu pertama
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                ),
                                isSmallScreen: isSmallScreen,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 15 : 20),

                        // Dot indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return GestureDetector(
                              onTap: () {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Container(
                                width: isSmallScreen ? 8 : 10,
                                height: isSmallScreen ? 8 : 10,
                                margin: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 4 : 6,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentCard == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
                                ),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: isSmallScreen ? 30 : 40),

                        // Quick menu
                        Text(
                          'Akses Cepat',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 22,
                            fontWeight: FontWeight.w700,
                            color: config['text_color'],
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 25),

                        GridView.count(
                          crossAxisCount: isSmallScreen ? 4 : 6,
                          shrinkWrap:
                              true, // penting supaya tinggi menyesuaikan isi
                          physics:
                              const NeverScrollableScrollPhysics(), //  biar gak bentrok dengan scroll utama
                          crossAxisSpacing: isSmallScreen ? 16 : 24,
                          mainAxisSpacing: isSmallScreen ? 16 : 24,
                          childAspectRatio: isSmallScreen
                              ? 0.9
                              : 1.0, //  biar icon + teks gak terlalu tinggi di HP kecil
                          children: [
                            _buildMenuItem(
                              '💸',
                              'Transfer',
                              () => _showMessage(
                                'Transfer akan segera hadir! 💸',
                              ),
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildMenuItem(
                              '💰',
                              'Top Up',
                              () =>
                                  _showMessage('Top Up akan segera hadir! 💰'),
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildMenuItem(
                              '📄',
                              'Tagihan',
                              () =>
                                  _showMessage('Tagihan akan segera hadir! 📄'),
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildMenuItem(
                              '📊',
                              'Statistik',
                              () => _showMessage(
                                'Statistik akan segera hadir! 📊',
                              ),
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildMenuItem(
                              '🎁',
                              'Reward',
                              () =>
                                  _showMessage('Reward akan segera hadir! 🎁'),
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildMenuItem(
                              '⚙️',
                              'Pengaturan',
                              () => _showMessage(
                                'Pengaturan akan segera hadir! ⚙️',
                              ),
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallScreen ? 50 : 70),

                        // Recent transactions
                        Text(
                          'Transaksi Terbaru',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 22,
                            fontWeight: FontWeight.w700,
                            color: config['text_color'],
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 10 : 15),
                        Column(
                          children: [
                            _buildTransactionItem(
                              icon: '🛒',
                              title: config['transaction_1'],
                              subtitle: 'Makanan & Minuman',
                              amount: '-Rp 25.000',
                              isIncome: false,
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildTransactionItem(
                              icon: '💼',
                              title: config['transaction_2'],
                              subtitle: 'Pemasukan',
                              amount: '+Rp 5.000.000',
                              isIncome: true,
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildTransactionItem(
                              icon: '🎬',
                              title: 'Tiket Bioskop',
                              subtitle: 'Hiburan',
                              amount: '-Rp 60.000',
                              isIncome: false,
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildTransactionItem(
                              icon: '🍔',
                              title: 'Makan Siang',
                              subtitle: 'Kebutuhan Sehari-hari',
                              amount: '-Rp 60.000',
                              isIncome: false,
                              isSmallScreen: isSmallScreen,
                            ),
                            _buildTransactionItem(
                              icon: '⚠️',
                              title: 'Biaya tak terduga',
                              subtitle: 'Darurat',
                              amount: '-Rp 6000.000',
                              isIncome: false,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMessage('Tambah transaksi akan segera hadir! ➕'),
        backgroundColor: config['background_gradient_middle'],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBalanceCard({
    required String bankName,
    required String cardType,
    required String cardNumber,
    required String balance,
    required LinearGradient gradient,
    required VoidCallback onTap,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : 15),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(isSmallScreen ? 25 : 30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isSmallScreen ? 25 : 30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Saldo',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isSmallScreen ? 16 : 18,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 10),
                  Text(
                    balance,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 28 : 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankName,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                      Text(
                        cardNumber,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Perbaikan: jadikan isSmallScreen named parameter (sesuai pemanggilan)
  Widget _buildMenuItem(
    String icon,
    String label,
    VoidCallback onTap, {
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: isSmallScreen ? 55 : 65,
            width: isSmallScreen ? 55 : 65,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
            ),
            child: Center(
              child: Text(
                icon,
                style: TextStyle(fontSize: isSmallScreen ? 28 : 32),
              ),
            ),
          ),
          SizedBox(height: isSmallScreen ? 6 : 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Perbaikan lengkap untuk transaksi:
  Widget _buildTransactionItem({
    required String icon,
    required String title,
    required String subtitle,
    required String amount,
    required bool isIncome,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: () => _showMessage('Detail transaksi akan segera hadir! 📝'),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 6 : 8),
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        ),
        child: Row(
          children: [
            Container(
              width: isSmallScreen ? 44 : 52,
              height: isSmallScreen ? 44 : 52,
              decoration: BoxDecoration(
                color: isIncome
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: TextStyle(fontSize: isSmallScreen ? 20 : 24),
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 12 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isSmallScreen ? 12 : 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: isIncome ? Colors.greenAccent : Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 13 : 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
