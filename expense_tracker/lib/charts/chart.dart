import 'package:expense_tracker/charts/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.categoryList(expenses, Category.Food),
      ExpenseBucket.categoryList(expenses, Category.Job),
      ExpenseBucket.categoryList(expenses, Category.Shopping),
      ExpenseBucket.categoryList(expenses, Category.Course),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.sumExpense > maxTotalExpense) {
        maxTotalExpense = bucket.sumExpense;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.sumExpense == 0
                        ? 0
                        : bucket.sumExpense / maxTotalExpense,
                  )
              ],
            ),
          ),
        const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Icon(
                      categoryIcons[bucket.category], 
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
