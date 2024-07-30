import 'package:flutter/material.dart';
import 'package:tracker/expense_widgets/expense_item.dart';
import 'package:tracker/models/expense.dart';

// ignore: must_be_immutable
class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  List<Expense> expenses;
  void Function(int idx, Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        child: ExpenseItem(expense: expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(index, expenses[index]);
        },
      ),
    );
  }
}
