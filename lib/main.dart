import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userquestion = '';
  var useranswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userquestion,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      useranswer,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: (){
                         setState(() {
                           userquestion='';
                           useranswer='';
                         });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );

                    } else if(index==buttons.length-1){
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                           equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == 1) {
                      return MyButton(
                        buttonTapped: (){
                         setState(() {
                           userquestion=userquestion.substring(0,userquestion.length-1);
                         });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                    else {
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            userquestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '+' || x == '-' || x == 'x' || x == '=') {
      return true;
    }
    return false;
  }
  void equalPressed( ) {
    String finalQuestion=userquestion;

    finalQuestion=finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval=exp.evaluate(EvaluationType.REAL, cm);

    useranswer=eval.toString();
  }
}
