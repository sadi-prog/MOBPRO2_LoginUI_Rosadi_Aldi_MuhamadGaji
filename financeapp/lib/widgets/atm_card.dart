import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====== Baris Atas: Logo + Bank Name ======
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ====== Saldo ======
          Text(
            'Current Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          // ====== Nomor Kartu + Icon Chip ======
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
              // Chip Icon / NFC Style
              Container(
                height: 24,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: const Icon(Icons.wifi, color: Colors.white70, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
