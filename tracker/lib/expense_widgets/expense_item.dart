import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(expense.amount.toString()),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  Text(expense.formattedDate),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
