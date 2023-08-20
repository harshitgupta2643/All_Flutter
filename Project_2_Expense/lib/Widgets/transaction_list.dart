import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transaction.isEmpty
          ? LayoutBuilder(builder: ((context, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transactions added Yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/image1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              );
            }))
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            '\u{20B9}${transaction[i].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transaction[i].title}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat('dd/MM/yyyy  EEEE ')
                        .add_jm()
                        .format(transaction[i].date)),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTx(transaction[i].id),
                            label: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : IconButton(
                            onPressed: () => deleteTx(transaction[i].id),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
