
import 'helpers.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
// class with helper functions for graphing and more
var help = Helper();
Parser p = Parser();
// parser for parsing expressions
class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  String numtext = '';
  String i = '';
  double k = 0;
// Array of button
  final List<String> buttons = [
    'AC',
    '+/-',
    'DEL',
    '²',
    'cos',
    'sin',
    'tan',
    '!',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // text contianers for input/output below, don't touch
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style:
                            const TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            // button setting
            flex: 4,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            numtext = '';
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttontapped: () {
                          // use numtext or userInput variable here?
                          setState(() {
                            userInput += '-';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 1) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                            if (userInput.isEmpty) {
                              numtext = '';
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 22) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                      );
                    }
                    // cosin button, to use this check if next input is a valid integer and replace inside of string with integer ex. cos()x -> cos(x)
                    else if (index == 4) {
                      return MyButton(
                          buttontapped: () {
                            setState(() {
                              String k =
                                  buttons[index].replaceAll('cos', 'cos()');
                              userInput += k;
                            });
                          },
                          color: Colors.blue[50],
                          buttonText: buttons[index]);
                    }
                    // sin button
                    else if (index == 5) {
                      return MyButton(
                          buttontapped: () {
                            setState(() {
                              String k =buttons[index].replaceAll('sin', 'sin()');
                              userInput += k;
                            });
                          },
                          color: Colors.blue[50],
                          buttonText: buttons[index]);
                    }
                    // tan button
                    else if (index == 6) {
                      return MyButton(
                          buttontapped: () {
                            setState(() {
                              String k =
                                  buttons[index].replaceAll('tan', 'tan()');
                              userInput += k;
                            });
                          },
                          color: Colors.blue[50],
                          buttonText: buttons[index]);
                    }
                    // other buttons, numbers, square root, extra functions
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            if(buttons[index]!='²'){
                            numtext += buttons[index];
                            }
                            if (userInput.startsWith('cos') == true) {
                              userInput = 'cos($numtext)';
                            } else if (userInput.startsWith('sin') == true) {
                              userInput = 'sin($numtext)';
                            } else if (userInput.startsWith('tan') == true) {
                              userInput = 'tan($numtext)';
                            } else if (userInput.startsWith('log') == true) {
                              userInput = 'log($numtext)';
                            } 
                            else if (userInput.startsWith('poly') == true) {
                              // polynomial evaluator for symbols like x, y, etc
                            userInput = 'poly($numtext)';
                            // finds roots of polynomial with formula of numtext, gives them to userInput
                            userInput=help.solve(numtext).toString();
                            } else {
                              userInput += buttons[index];
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.orangeAccent
                            // not an operator(orange if so). For button color, is it a number?
                            : isNumber(buttons[index])
                                ? Colors.blueGrey
                                : Colors.black,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            // not an operator(white text if so). for text color, is it a number?
                            : isNumber(buttons[index])
                                ? Colors.black
                                : Colors.white,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' ||
        x == '*' ||
        x == '-' ||
        x == '²' ||
        x == '+' ||
        x == '=' ||
        x == 'cos' ||
        x == 'sin' ||
        x == 'tan' ||
        x == 'log' ||
        x == '!') {
      return true;
    } else {
      return false;
    }
  }

  bool isNumber(String x) {
    for (int i = 0; i <= 9; i++) {
      if (x[0] == i.toString() || x[0] == '.') {
        return true;
      }
    }
    return false;
  }



// function to calculate the output operation, ran when equal is pressed
  void equalPressed() {
     if(userInput.endsWith('²')== true){
    userInput='${numtext}*${numtext}';
    }
    // context model for dynamic screen overflow protection
    ContextModel cm = ContextModel();
    Expression exp = p.parse(userInput);
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    // refresh the number text variable, so that it can be used again later
    numtext = '';
  }
}
