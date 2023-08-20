// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final reset;
  Result(this.resultScore, this.reset);

  String get resultPhrase {
    String resText;
    if (resultScore <= 8)
      resText = 'You are Bad!';
    else if (resultScore <= 12)
      resText = 'You are moderate';
    else if (resultScore <= 16)
      resText = 'You are Pretty likable';
    else
      resText = 'You are Great';
    return resText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: reset,
            child: Text('Reset Quiz!!'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
