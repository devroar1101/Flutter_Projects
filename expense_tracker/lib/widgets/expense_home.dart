import 'package:expense_tracker/charts/chart.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});
  @override
  State<ExpenseHome> createState() {
    return _ExpenseHomeState();
  }
}

class _ExpenseHomeState extends State<ExpenseHome> {
  final List<Expense> expenseList = [
    Expense(
        title: 'Flutter Course',
        amount: 659,
        date: DateTime.now(),
        category: Category.Course),
    Expense(
        title: 'Udipi Hotel',
        amount: 400,
        date: DateTime.now(),
        category: Category.Food),
    Expense(
        title: 'KeyBoard and Mouse',
        amount: 300,
        date: DateTime.now(),
        category: Category.Job),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final index = expenseList.indexOf(expense);

    setState(() {
      expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('expense removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            expenseList.insert(index, expense);
          }),
        ),
      ),
    );
  }

  Widget setup() {
    const defultWidget = Center(child: Text('no expense data'));
    if (expenseList.isEmpty) {
      return defultWidget;
    }
    return ExpenseList(
      expenses: expenseList,
      removeExpense: removeExpense,
    );
  }

  void onClickAddButton() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(ctx).size.height,
          child: AddExpense(addExpense),
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: onClickAddButton, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: expenseList),
          Expanded(child: setup()),
        ],
      ),
    );
  }
}
