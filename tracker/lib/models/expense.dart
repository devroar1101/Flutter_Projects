import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

const uniqueId = Uuid();

DateFormat formatter = DateFormat.yMd();

enum ExpenseCategory { Food, Work, Education, Shopping }

final categoryIcons = {
  ExpenseCategory.Food: Icons.local_florist_rounded,
  ExpenseCategory.Work: Icons.work,
  ExpenseCategory.Education: Icons.cast_for_education,
  ExpenseCategory.Shopping: Icons.shopping_bag,
};

class Expense {
  Expense(this.title, this.amount, this.date, this.category)
      : id = uniqueId.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.forCategory(this.category, List<Expense> allExpense)
      : expenses = allExpense.where((expense) {
          return expense.category == category;
        }).toList();

  final ExpenseCategory category;
  final List<Expense> expenses;

  double get sumExpense {
    double sum = 0;
    for (Expense expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
