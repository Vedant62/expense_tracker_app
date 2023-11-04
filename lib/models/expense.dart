import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Category { food, travel, leisure, work }
const categoryIcons = {
  Category.food:Icons.fastfood_rounded,
  Category.travel:Icons.flight_takeoff_rounded,
  Category.work:Icons.work_rounded,
  Category.leisure:Icons.movie_rounded
};





class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;
  String get formattedDate{
    return formatter.format(date);
  }
}
class ExpenseBucket{
  const ExpenseBucket({required this.category,required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) : expenses = allExpenses.where((expense) => expense.category == category).toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;
    for (final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }
}
