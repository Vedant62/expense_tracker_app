import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense)
      onAddExpense; //returns nothing but provides an expense value
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    //await before the code that yields a future
    final pickedDate = await showDatePicker(
        //showDatePicker returns the picked date but as a future
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    //this line will only execute after the above thing ran
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final _enteredAmount = double.tryParse(
        _amountController.text); // ('3.14') => 3.14, ('hello') => null
    final amountIsInvalid = _enteredAmount == null || _enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              'Please make sure a valid title, amount, date and category was added'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay')),
          ],
        ),
      );
      return; //so that new one is not created if invalid data entered
    }
    //here we use 'widget.'
    // to access functions defined in the widget class in this state class
    widget.onAddExpense(Expense(
        amount: _enteredAmount,
        title: _titleController.text,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //always dispose such controllers when not in focus
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      // print(constraints.minHeight);
      // print(constraints.maxHeight);
      // print(constraints.minWidth);

      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Expanded(
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(label: Text("Title ")),
                          ),
                        ),
                        const SizedBox(width: 24,),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: InputDecoration(
                                label: Text("Amount"), prefixText: "₹ "),
                            keyboardType: TextInputType.number,
                          ),
                        ),

                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text("Title ")),
                    ),
                  if (width>=600)
                    Row(children: [
                      DropdownButton(
                          value: _selectedCategory,
                          //The value of the currently selected [DropdownMenuItem] as opposed to empty
                          items: Category.values
                              .map(
                            // converting enum typr to DropdownMenuItem type
                                (category) => DropdownMenuItem(
                              value: category,
                              //The value to return if the user selects this menu item.
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(
                                  () {
                                if (value == null) {
                                  return;
                                }
                                //above we make sure that value isn't null
                                _selectedCategory =
                                    value; //what has changed has became the _selectedCategory
                              },
                            );
                          }),
                      const SizedBox(width: 24,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? "No date selected"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month_rounded)),
                          ],
                        ),
                      )

                    ],)
                  else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                              label: Text("Amount"), prefixText: "₹ "),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? "No date selected"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month_rounded)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (width>=600)
                    Row(children: [
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("Save expense"))
                    ],)
                  else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          //The value of the currently selected [DropdownMenuItem] as opposed to empty
                          items: Category.values
                              .map(
                                // converting enum typr to DropdownMenuItem type
                                (category) => DropdownMenuItem(
                                  value: category,
                                  //The value to return if the user selects this menu item.
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(
                              () {
                                if (value == null) {
                                  return;
                                }
                                //above we make sure that value isn't null
                                _selectedCategory =
                                    value; //what has changed has became the _selectedCategory
                              },
                            );
                          }),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("Save expense"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
