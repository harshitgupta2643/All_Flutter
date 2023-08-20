import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final select;
  final String answerText;
  Answer(this.select, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(answerText),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(190, 120, 17, 189),
        ),
        onPressed: select,
      ),
    );
  }
}
