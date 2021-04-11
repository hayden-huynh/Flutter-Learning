import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // Lock the app to portrait orientation
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
      // Theme for app-wide stylings
      theme: ThemeData(
        primarySwatch: Colors
            .green, // A variety of shades automatically created from one color
        accentColor: Colors.yellow.shade600,
        errorColor: Colors.red[200],
        fontFamily:
            'Quicksand', // Must be same as font name given in pubspec.yaml
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green[600],
            )),
        appBarTheme: AppBarTheme(
          // Theme for the appbar in every page available
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    )
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    // Execute a function on every item in a list and keep them in the new list if true is returned
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled:
          true, // Allow modal sheet to scroll up to not be covered by the keyboard
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation ==
        Orientation
            .landscape; // Accessing the current orientation of the device

    // Adding type "PreferredSizeWidget" so that the "appBar" variable can access the preferredSize property
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: TextButton(
              child: Icon(CupertinoIcons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );

    // Use MediaQuery.of(context).size.height (or width) to access screen's height or width
    // appBar.preferredSize.height = height of the app bar
    // MediaQuery.of(context).padding.top = height of the status bar
    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final txList = Container(
      height: screenHeight * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      // SafeArea widget makes sure contents only rendered where they should be (e.g. avoid the device's notch if there is one)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The Row of Text and Switch is visible only if isLandscape is true
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                    // adaptive: automatically changes its look depending on the platform
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
          if (!isLandscape)
            Container(
              height: screenHeight * 0.3,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscape) txList,
          if (isLandscape)
            _showChart
                ? Container(
                    height: screenHeight * 0.7,
                    child: Chart(_recentTransactions),
                  )
                : txList
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform
                    .isIOS // If the platfrom is iOS, do not render the floating action button
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
