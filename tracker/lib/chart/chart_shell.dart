import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';

class ChartShell extends StatelessWidget {
  ChartShell({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(ExpenseCategory.Education, expenses),
      ExpenseBucket.forCategory(ExpenseCategory.Food, expenses),
      ExpenseBucket.forCategory(ExpenseCategory.Shopping, expenses),
      ExpenseBucket.forCategory(ExpenseCategory.Work, expenses),
    ];
  }

  double getMaxValue() {
    double maxValue = 0;
    for (final bucket in buckets) {
      if (bucket.sumExpense > maxValue) {
        maxValue = bucket.sumExpense;
      }
    }
    return maxValue;
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = getMaxValue();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200, // Fixed height for the bar chart
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  buckets.length,
                  (index) {
                    final bucket = buckets[index];
                    return Expanded(
                      child: FractionallySizedBox(
                        heightFactor: bucket.sumExpense == 0
                            ? 0
                            : bucket.sumExpense / maxValue,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          color: const Color.fromARGB(240, 58, 204,
                              82), // Customize the color as needed
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buckets
                  .map(
                    (bucket) => Icon(categoryIcons[bucket.category]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
