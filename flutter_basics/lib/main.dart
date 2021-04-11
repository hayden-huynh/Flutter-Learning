// Block of imports from packages first. Block of imports from own files second.
import 'package:flutter/material.dart';
import 'package:flutter_basics/result.dart';

import './quiz.dart';
import './result.dart';

// void main() {
//   runApp(MyApp());
// }

// Same as the above syntax
void main() => runApp(MyApp());

/*
 * Stateless widgets are immutable i.e. cannot hold data that changes
 */
// class MyApp extends StatelessWidget {
//   var questionIndex = 0;

//   // All functions relating to the widget should go into the class of the widget
//   void answerQuestion() {
//     questionIndex++;
//     print(questionIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Array created with square brackets
//     var questions = [
//       'What\'s your favorite color?',
//       'What\'s your favorite animal?'
//     ];

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('My First App'),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Text(questions[questionIndex]),
//               RaisedButton(
//                 child: Text('Answer 1'),
//                 onPressed: answerQuestion,
//               ),
//               RaisedButton(
//                 child: Text('Answer 2'),
//                 onPressed: () => print('Answer 2 Chosen!'),
//               ),
//               RaisedButton(
//                 child: Text('Answer 3'),
//                 onPressed: () {
//                   // Do stuff
//                   print('Answer 3 Chosen!');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/*
 * Stateful widgets are mutable i.e. can hold data that changes
 * 
 * Statefull widgets need two classes: one extending StatefulWidget and one extending State<> because
 * the StatefulWidget-based class is of the UI and will get re-built many times whereas the State<>-based 
 * class should be consistent
 */
class MyApp extends StatefulWidget {
  // Connection #2: Implement the createState function inside the StatefulWidget class
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// Connection #1: State< name of StatefulWidget class >
class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  // Array created with square brackets
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 2},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 5},
        {'text': 'Snake', 'score': 4},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 2},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Brad', 'score': 2},
        {'text': 'Max', 'score': 3},
        {'text': 'Tim', 'score': 4},
        {'text': 'Rob', 'score': 5}
      ],
    },
  ];

  // All functions relating to the widget should go into the class of the widget
  void _answerQuestion(int score) {

    _totalScore += score;

    // The setState function watches and signifies re-rendering whenever there are the changes in the data inside its argument function
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Center(
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questions: _questions,
                  questionIndex: _questionIndex,
                )
              : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
}
