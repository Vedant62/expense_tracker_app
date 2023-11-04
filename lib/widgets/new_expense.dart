import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  var _enteredTitle = "";
  void _saveTitleInput(String inputValue){
    _enteredTitle = inputValue;
  }
//the builtin behavior of TextField is such that onChanged,
// the entered text is automatically sent as an argument for the _saveTitleInput function
// i.e. as inputValue

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          onChanged: _saveTitleInput ,
          maxLength: 50,
          decoration: InputDecoration(label: Text("Title ")),
        ),
        Row(children: [
          ElevatedButton(onPressed: (){print(_enteredTitle);}, child: Text("Save expense"))
        ],)

      ],),
    );
  }
}
