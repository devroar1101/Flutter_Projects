import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

// ignore: must_be_immutable
class AddExpense extends StatefulWidget {
  AddExpense(this.addNewExpense, {super.key});

  void Function(Expense) addNewExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedCategory = Category.Shopping;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void selectCurrentdate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final dateSelected = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selecteddate = dateSelected;
    });
  }

  void onClickSaveButton() {
    var _amountenterd = double.tryParse(_amountController.text);
    var amountinvalid = _amountenterd == null || _amountenterd <= 0;

    // ignore: unnecessary_null_comparison
    if (_titleController.text.trim() == null ||
        amountinvalid ||
        _selecteddate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('validations'),
          content: const Text('enterd value invalid'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('Okay')),
          ],
        ),
      );
      return;
    } else {
      final newExpense = Expense(
          title: _titleController.text,
          amount: _amountenterd,
          date: _selecteddate!,
          category: _selectedCategory);
      widget.addNewExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selecteddate == null
                        ? 'no date selected'
                        : dateFormatter.format(_selecteddate!)),
                    IconButton(
                      onPressed: selectCurrentdate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: onClickSaveButton,
                child: const Text('Save'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
