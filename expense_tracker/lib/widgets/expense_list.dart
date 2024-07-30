import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpenseList extends StatelessWidget {
  ExpenseList({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });

  final List<Expense> expenses;
  void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).colorScheme.error,
        ),
        key: ValueKey(expenses[index]),
        child: ExpenseListItem(expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
      ),
    );
  }
}
