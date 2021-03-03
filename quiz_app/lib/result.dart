
import 'package:flutter/material.dart';

class Result extends StatelessWidget {

  final int resultScore;
  final Function resetQuiz;
  Result(this.resultScore,this.resetQuiz);

  String get resultPhrase{

    String resultText;

    if (resultScore<=25){
      resultText="We have different interests";
    }

    else if (resultScore<=35){
      resultText="We both have some interests in common ";
    }
    else if (resultScore<40){
      resultText="We both have almost same interests";
    }
    else{
      resultText="We have exactly same interests";
    }

    return resultText;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(40),
      child: Column(
      children: [
        Text('Your Total score is '+
            resultScore.toString()+' out of 40',
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.lightBlue),
        ),
        Text('                     ',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
        ),
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
          textAlign: TextAlign.center,
        ),
        Text('                     ',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
        ),

        FlatButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          child: Text('Restart Quiz'),onPressed: resetQuiz,),
      ],
    ),);
  }
}
