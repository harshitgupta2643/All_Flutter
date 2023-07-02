import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/result.dart';
// void main() {
//   runApp(const MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': "What's Your Favourite COLOUR?",
      'answer': [
        {'text': 'Blue', 'Score': 5},
        {'text': 'Black', 'Score': 3},
        {'text': 'red', 'Score': 2},
        {'text': 'Pink', 'Score': 10}
      ]
    },
    {
      'questionText': "What's Your Favourite ANIMAL?",
      'answer': [
        {'text': 'Monkey', 'Score': 4},
        {'text': 'Hourse', 'Score': 3},
        {'text': 'Cow', 'Score': 10},
        {'text': 'Fish', 'Score': 5}
      ]
    },
    {
      'questionText': "Who's Your Favourite Hero?",
      'answer': [
        {'text': 'Manoj Bajpee', 'Score': 3},
        {'text': 'Nawazuddin Siddiqui', 'Score': 2},
        {'text': 'Akshay Kumar', 'Score': 10},
        {'text': 'Pankaj Tripathi', 'Score': 1}
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore = _totalScore + score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more Questions!!!');
    } else {
      print('no more question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'QUIZ',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.justify,
          ),
        ),
        body: (_questionIndex < _questions.length)
            ? Quiz(
                questions: _questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
