import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransactionHandler;

  NewTransaction(this.newTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    widget.newTransactionHandler(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize:
              MainAxisSize.min, // Prevent modal sheet from taking whole screen
          children: [
            TextField(
              // onChanged: (value) {
              //   titleInput = value;
              // },
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              // onChanged: (value) => amountInput = value,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Picked Date: ${DateFormat.yMMMMd().format(_selectedDate)}',
                  ),
                  AdaptiveFlatButton(
                    'Choose Date',
                    _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              textColor: Theme.of(context).primaryColorDark,
              color: Theme.of(context).primaryColorLight,
            )
          ],
        ),
      ),
    );
  }
}
