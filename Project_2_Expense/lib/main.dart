import 'dart:io';
import 'package:expense_app/Widgets/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Models/transaction.dart';
import './Widgets/transaction_list.dart';
import './Widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light(useMaterial3: true).textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoe',flutter
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Grocery',
    //   amount: 19.99,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showchart = false;
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime(2023).subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choseDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
      context: cxt,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    // final titleController = TextEditingController();
    //final amountController = ();
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      title: Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'Open Sans'),
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final pageBody = SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userTransaction, _deleteTx)),
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(
                    activeColor: Colors.amberAccent,
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    })
              ],
            ),
          if (isLandscape)
            _showchart
                ? Container(
                    height: (mediaQuery.size.height -
                            appbar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (mediaQuery.size.height -
                            appbar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: TransactionList(_userTransaction, _deleteTx)),
        ],
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: pageBody,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: () => _startAddNewTransaction(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
