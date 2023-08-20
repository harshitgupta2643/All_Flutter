import 'package:expense_app/Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalScore = 0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalScore += recentTransaction[i].amount as double;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalScore);
      return {
        'days': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalScore,
      };
    }); //.reversed.toList();
  }

  double get spending_percent_of_total {
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  // double get spendingAmount {
  //   return groupedTransaction.fold(0.0, (sum, item) {
  //     return (tx['amount'] as double);
  //   });
  // }

  // String get label {
  //   return groupedTransaction.fold('', (sm, item) {
  //     return (item['days'] as String);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransaction);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  (tx['days'] as String),
                  (tx['amount'] as double),
                  spending_percent_of_total == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / spending_percent_of_total),
            );
          }).toList(),
        ),
      ),
    );
  }
}
