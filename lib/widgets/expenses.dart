import 'package:flutter/material.dart';

import 'expenses_list/expenses_list.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});


  @override
  State<Expenses> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "FlutterCourse",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food
    ),
    Expense(
        title: "Cinema",
        amount: 15.99,
        date: DateTime.now(),
        category: Category.leisure
    ),

  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Text("The chart"),
          Expanded(child: ExpensesList(expenses: _registeredExpenses,))


        ],
      ),
    );
  }
}