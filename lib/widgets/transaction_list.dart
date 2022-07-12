import 'package:expenses_app/widgets/transactionItem.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactionList;

  final Function deleteTransaction;

  const TransactionList(this.userTransactionList, this.deleteTransaction,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return userTransactionList.isEmpty
        ? LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
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
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                userTransaction: userTransactionList[index],
                deleteTransaction: deleteTransaction,
              );
            },
            itemCount: userTransactionList.length,
          );
  }
}
