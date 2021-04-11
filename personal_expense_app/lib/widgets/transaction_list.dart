import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  // An invisible box widget for vertical/horizontal spacings
                  height: 30,
                ),
                Container(
                  // Adding an image from local assets
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit
                        .cover, // Try to fit the whole image into the bounding box
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         child: Text(
              //             '\$${transactions[index].amount.toStringAsFixed(2)}',
              //             style: Theme.of(context).textTheme.headline6
              //             // TextStyle(
              //             //   fontWeight: FontWeight.bold,
              //             //   fontSize: 20,
              //             //   color: Theme.of(context).primaryColorDark, // Theme object for direct access to the app theme
              //             // ),
              //             ),
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         padding: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColorLight,
              //             width: 2,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16,
              //             ),
              //           ),
              //           Text(
              //             DateFormat('dd/MM/yyyy')
              //                 .format(transactions[index].date),
              //             style: TextStyle(color: Colors.grey.shade600),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );

              return Card(
                elevation: 6,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    radius: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
