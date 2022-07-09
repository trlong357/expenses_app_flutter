import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;

  final Function deleteTransaction;

  const TransactionList(this.userTransaction, this.deleteTransaction,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userTransaction.isEmpty
          ? Column(
              children: [
                Text(
                  "No transaction",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Image.asset("assets/images/waiting.png"),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${userTransaction[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransaction[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransaction[index].date),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          deleteTransaction(userTransaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
