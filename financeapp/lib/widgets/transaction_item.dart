import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  // 🔹 Fungsi menentukan ikon berdasarkan kategori
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan & minuman':
        return Icons.fastfood;
      case 'transportasi':
        return Icons.directions_car;
      case 'kesehatan':
        return Icons.favorite;
      case 'hiburan':
        return Icons.movie;
      case 'pemasukan':
        return Icons.account_balance_wallet;
      case 'belanja':
        return Icons.shopping_bag;
      default:
        return Icons.attach_money;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpense = transaction.amount.startsWith('-');

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: isExpense
              ? Colors.redAccent.withOpacity(0.1)
              : Colors.greenAccent.withOpacity(0.1),
          child: Icon(
            _getCategoryIcon(transaction.category),
            color: isExpense ? Colors.redAccent : Colors.green,
            size: 24,
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          transaction.category,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        trailing: Text(
          transaction.amount,
          style: TextStyle(
            color: isExpense ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
