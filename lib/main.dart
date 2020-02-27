import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizbrain.dart';

QuizBrain quizBrain  = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class  QuizPage extends StatefulWidget{
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scoreKeeper = [
    /*Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),*/
  ];

  void checkAns(bool userPicked){

    bool correctans = quizBrain.getCorrectAnswer();

    setState(() {
      if(quizBrain.isFinished() == true){
         int r = quizBrain.scoreRight();
         int w = quizBrain.scoreWrong();

        Alert(
          context: context,
          type: AlertType.success,
          title: "Finihed!",
          desc: "Completed the quiz.\n Right:$r \nWrong:$w",
          buttons: [
            DialogButton(
              child: Text(
                "Done",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ]
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      }

      else{
        if(userPicked == correctans){
          print("true");
          quizBrain.rightAns();
          scoreKeeper.add(
              Icon(
                 Icons.check,
                  color: Colors.green,
              )
          );
        }
        else{
          print("false");
          quizBrain.wrongAns();
          scoreKeeper.add(
              Icon(
                  Icons.close,
                  color: Colors.red,
              )
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),


        //*****************True*************************

        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                "True",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAns(true);
              },
            ),
          ),
        ),


        //******************False************************

        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                "False",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAns(false);
              },
            ),
          ),
        ),

        //*****************Icons**********************

        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

