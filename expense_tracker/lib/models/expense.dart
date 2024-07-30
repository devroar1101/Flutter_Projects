import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

// ignore: constant_identifier_names
enum Category { Food, Job, Shopping, Course }

const categoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Course: Icons.cast_for_education,
  Category.Shopping: Icons.shop,
  Category.Job: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket(this.category, this.expenses);

  ExpenseBucket.categoryList(List<Expense> allexpense, this.category)
      : expenses = allexpense
            .where(
              (expense) => expense.category == category,
            )
            .toList();

  final List<Expense> expenses;
  final Category category;

  double get sumExpense {
    double sum = 0;
    for (Expense expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
