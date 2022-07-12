import 'package:flutter/material.dart';
import 'dart:math';

import 'package:expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const colorList = [
      Colors.red,
      Colors.yellowAccent,
      Colors.cyanAccent,
      Colors.teal
    ];

    _bgColor = colorList[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${widget.userTransaction.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.userTransaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                onPressed: () =>
                    widget.deleteTransaction(widget.userTransaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.deleteTransaction(widget.userTransaction.id),
              ),
      ),
    );
  }
}
