import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/models/expense.dart';

// ignore: must_be_immutable
class AddExpense extends StatefulWidget {
  AddExpense({super.key, required this.addNewExpense});

  void Function(Expense) addNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory _selectedItem = ExpenseCategory.Food;
  DateTime? _selectedDate;
  DateFormat formatter = DateFormat.yMd();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void onClickDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final _dateSelected = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = _dateSelected;
    });
  }

  void onClickSaveButon() {
    final double? _amount = double.tryParse(_amountController.text);

    // ignore: unnecessary_null_comparison
    if (_titleController.text.trim() == null ||
        _amount == null ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text('please enter valid information, before save'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      Expense newExpense = Expense(
          _titleController.text, _amount, _selectedDate!, _selectedItem);

      widget.addNewExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constains) {
      final width = constains.maxWidth;

      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (width >= 600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 50,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
              )
            else
              TextField(
                maxLength: 50,
                controller: _titleController,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
            const SizedBox(
              height: 8,
            ),
            if (width >= 600)
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _selectedDate == null
                          ? const Text('No date selected')
                          : Text(formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: onClickDatePicker,
                        icon: const Icon(Icons.calendar_month_rounded),
                      ),
                    ],
                  ),
                  const Spacer(),
                  DropdownButton(
                      value: _selectedItem,
                      items: ExpenseCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      }),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      _selectedDate == null
                          ? const Text('No date selected')
                          : Text(formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: onClickDatePicker,
                        icon: const Icon(Icons.calendar_month_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(
              height: 8,
            ),
            if (width >= 600)
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onClickSaveButon,
                    child: const Text('Save'),
                  ),
                ],
              )
            else
              Row(
                children: [
                  DropdownButton(
                      value: _selectedItem,
                      items: ExpenseCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: onClickSaveButon,
                    child: const Text('Save'),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}
