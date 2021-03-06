import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.cyan,

        // colorScheme: ColorScheme.light(Colors.amber),
        //accentColor: Colors.amber, // no logger needed

        //https://api.flutter.dev/flutter/material/ThemeData-class.html
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
          // primaryColorDark: Colors.cyan,
        ).copyWith(
          secondary: Colors.amber,
        ),

        //fonts
        fontFamily: 'Quicksand',

        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'Opensans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        //appbar
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,

          //
          //textTheme: ThemeData.light().textTheme.copyWith(
          //   headline6: TextStyle(
          //     fontFamily: 'OpenSans',
          //     fontSize: 20,
          //   ),
          // ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: "t1",
    //   title: "New Shoes",
    //   amount: 99.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Nike Shirt",
    //   amount: 29.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t3",
    //   title: "Apple Watch",
    //   amount: 299.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (transaction) {
        return transaction.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        //return GestureDetector(
        // onTap: null,
        //child: NewTransaction(_addNewTransaction),
        // behavior: HitTestBehavior.opaque,
        //); // sau nay ko can nua
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense app"),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTransaction, _deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
