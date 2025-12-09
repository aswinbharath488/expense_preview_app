import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/constants/colors.dart';

class ExpenseTile extends StatelessWidget {
  final Transaction data;
  const ExpenseTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isIncome = data.amount > 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
          color: isIncome ? AppColors.income : AppColors.expense,
        ),
        title: Text(
          data.title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${data.category} • ${DateFormatter.format(data.date)}",
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: Text(
          "₹ ${data.amount.abs().toStringAsFixed(0)}",
          style: TextStyle(
            color: isIncome ? AppColors.income : AppColors.expense,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
