import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
const uuid = Uuid();

enum Category { food, travel, leisure, work }
const categoryIcons = {
  Category.food: Icon(Icons.fastfood_rounded),
  Category.travel:Icon(Icons.flight_takeoff_rounded),
  Category.work:Icon(Icons.work_rounded),
  Category.leisure:Icon(Icons.movie_rounded)
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
}
