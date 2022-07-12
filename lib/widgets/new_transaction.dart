import 'package:expenses_app/widgets/adaptiveButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  // @override
  // void didUpdateWidget(covariant NewTransaction oldWidget) {
  //   print("didUpdateWidget");
  //   super.didUpdateWidget(oldWidget);
  // }

  // @override
  // void initState() {
  //   _selectedDate = DateTime.now();
  //   print("init state");
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   print("DISPOSED");
  //   super.dispose();
  // }

  void _submitData() {
    final enteredTitle = _titleController.text;
    if (_amountController.text.isEmpty || enteredTitle.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); // close when submit
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 01, 01),
      lastDate: DateTime.now(), // 31-12-2023
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
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            // calendar
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    // ignore: unnecessary_null_comparison
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                  ),
                  AdaptiveButton("Choose Date", _presentDatePicker)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                "Add Transaction",
              ),
            )
          ],
        ),
      ),
    );
  }
}
