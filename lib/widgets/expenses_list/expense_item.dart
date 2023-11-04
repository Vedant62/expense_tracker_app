import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height: 4,),
          Row(children: [
            Text("₹${expense.amount.toStringAsFixed(2)}"),
            Spacer(), //will take all the remaining space between 2 widgets
            Row(children: [
              Icon(categoryIcons[expense.category]),
              const SizedBox(width: 8,),
              Text(expense.date.toString())
            ],)

          ],)
        ],
      ),
    ),);
  }
}
