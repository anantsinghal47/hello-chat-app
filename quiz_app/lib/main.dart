import 'package:flutter/material.dart';
import 'package:quiz_app/result.dart';
import './quiz.dart';
import './result.dart';

void main(){
  runApp(MyFirstApp());
}
class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

      return _MyFirstAppState();
  }

}
class _MyFirstAppState extends State<MyFirstApp>{
  final _questions = [
    //map
    { 'questionText':'What\'s your favorite movie ?',
      'answers':[
        {'Text':'Inception','score':5},
        {'Text':'Fifty shades','score':7},
        {'Text':'Tees Maar Khan','score':10},
        {'Text':'PK','score':8},
        ],
    },
    { 'questionText':'What\'s your favorite food ?',
      'answers':[
        {'Text':'Poha','score':5},
        {'Text':'Dosa','score':7},
        {'Text':'Pav Bhaji','score':8},
        {'Text':'Parent\'s ke Taane','score':10},
      ],
    },
    { 'questionText':'What\'s your favorite actor ?',
      'answers':[
        {'Text':'Selmon bhoi','score':10},
        {'Text':'Akshay kumar','score':6},
        {'Text':'Ananya Pandey','score':8},
        {'Text':'Neha dhoopia','score':2},
      ],
    },
    { 'questionText':'Who\'s your favorite YouTuber ?',
      'answers':[
        {'Text':'BB ki Vines','score':8},
        {'Text':'CarryMinati','score':10},
        {'Text':'Dhinchak Pooja','score':5},
        {'Text':'Hindustani Bhau','score':8},
      ],
    },

  ];
  var _i=0,_j=0;
  var _totalScore=0;
  void _resetQuiz(){
    setState(() {
      _i=0;
      _totalScore=0;
    });
  }

  void _answerQuestion(int score){
    _totalScore+=score;

    setState(() {
      _i = _i + 1;
      _j = _j + 3;
    });
      print(_i);
      print(_j);
    if(_i<_questions.length){
      print('We have more Questions');
    }
  }
  @override
  Widget build(BuildContext context){

    return MaterialApp(home:Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text('Quiz App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ) ,

      body: _i<_questions.length ?
                Quiz(
                  questions:_questions,
                  answerQuestion: _answerQuestion,
                  i: _i,

                )
                :Result(_totalScore,_resetQuiz),
     ),
    );
  }
}