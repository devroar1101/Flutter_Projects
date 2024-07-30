import 'package:flutter/material.dart';
import 'package:tracker/chart/chart_shell.dart';
import 'package:tracker/expense_widgets/add_expense.dart';
import 'package:tracker/expense_widgets/expense_list.dart';
import 'package:tracker/models/expense.dart';

class ExpenseHome extends StatefulWidget {
  ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() {
    return _ExpenseHomeState();
  }
}

class _ExpenseHomeState extends State<ExpenseHome> {
  final List<Expense> expenses = [
    Expense('Course', 200, DateTime.now(), ExpenseCategory.Work),
    Expense('Briyani', 100, DateTime.now(), ExpenseCategory.Food),
    Expense('dr', 1200, DateTime.now(), ExpenseCategory.Education),
  ];

  void onClickFlotingButton() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height,
        child: AddExpense(addNewExpense: onAddNewExpense),
      ),
    );
  }

  void onAddNewExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void onRemoveExpense(index, Expense expense) {
    int idx = index;
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            expenses.insert(idx, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: width < 600
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChartShell(expenses: expenses),
                Expanded(
                    child: ExpenseList(
                  expenses: expenses,
                  onRemoveExpense: onRemoveExpense,
                )),
              ],
            )
          : Row(
              children: [
                Expanded(child: ChartShell(expenses: expenses)),
                Expanded(
                    child: ExpenseList(
                  expenses: expenses,
                  onRemoveExpense: onRemoveExpense,
                )),
              ],
            ),
      floatingActionButton:
          IconButton(onPressed: onClickFlotingButton, icon: Icon(Icons.add)),
    );
  }
}
