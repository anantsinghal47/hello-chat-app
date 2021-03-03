import 'package:flutter/material.dart';
import './questions.dart';
import './answers.dart';
class Quiz extends StatelessWidget {
  final  List<Map<String,Object>> questions;
  final Function answerQuestion;
  final int i;
    Quiz({
      @required this.questions,
      @required this.answerQuestion,
      @required this.i,
    });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
       Questions(
         questions[i]['questionText'],
      ),
      ...(questions[i]['answers'] as List<Map<String,Object>>)
        .map((answer){
            return Answers(()=>answerQuestion(answer['score']),answer['Text']);
        }).toList()
    ],
);
  }
}
