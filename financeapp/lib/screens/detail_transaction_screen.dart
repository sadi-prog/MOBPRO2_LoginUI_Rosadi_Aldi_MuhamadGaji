import 'package:flutter/material.dart';
import '../models/transaction.dart';

class DetailTransactionScreen extends StatelessWidget {
  final TransactionModel transaction;

  const DetailTransactionScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Deteksi apakah transaksi pengeluaran atau pemasukan
    final bool isExpense = transaction.amount.startsWith('-');

    // Tentukan ikon dan warna berdasarkan jenis transaksi
    final IconData icon = isExpense
        ? Icons.shopping_bag
        : Icons.account_balance_wallet;
    final Color iconColor = isExpense ? Colors.redAccent : Colors.greenAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF8F9FB),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔹 Icon kategori (tanpa simbol uang)
                CircleAvatar(
                  radius: 40,
                  backgroundColor: iconColor.withOpacity(0.2),
                  child: Icon(icon, color: iconColor, size: 40),
                ),
                const SizedBox(height: 20),

                // 🔹 Nama transaksi
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C2C54),
                  ),
                ),
                const SizedBox(height: 8),

                // 🔹 Kategori transaksi
                Text(
                  transaction.category,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),

                // 🔹 Jumlah uang
                Text(
                  transaction.amount,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isExpense ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Tombol kembali
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Kembali"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
