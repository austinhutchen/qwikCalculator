import 'helpers.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  final help = new Helper();
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

// use state and hooks to change between the lists below on push of a button
// class with helper functions for graphing and more
var help = Helper();
// parser for parsing string expressions
Parser p = Parser();

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
    'ALT',
    'cos',
    'sin',
    'tan',
    '!',
    '7',
    '8',
    '9',
    '÷',
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

  final List<String> alt = [
    'AC',
    '+/-',
    'DEL',
    '',
    'arccos',
    'arcsin',
    'arctan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
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
          Expanded(
            // button setting
            flex: 3,

              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        {
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
                      case 1:
                        {
                          // negative button
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput += '-';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.blue[50],
                            textColor: Colors.black,
                          );
                        }
                      case 2:
                        {
                          // DELETE
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                userInput = userInput.substring(
                                    0, userInput.length - 1);
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
                      case 4:
                        {
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
                      case 5:
                        {
                          return MyButton(
                              buttontapped: () {
                                setState(() {
                                  String k =
                                      buttons[index].replaceAll('sin', 'sin()');
                                  userInput += k;
                                });
                              },
                              color: Colors.blue[50],
                              buttonText: buttons[index]);
                        }
                      case 6:
                        {
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
                      case 22:
                        {
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
                      default:
                        {
                          return MyButton(
                            buttontapped: () {
                              setState(() {
                                if (buttons[index] != '²') {
                                  numtext += buttons[index];
                                }
                                if (userInput.startsWith('cos') == true) {
                                  userInput = 'cos($numtext)';
                                } else if (userInput.startsWith('sin') ==
                                    true) {
                                  userInput = 'sin($numtext)';
                                } else if (userInput.startsWith('tan') ==
                                    true) {
                                  userInput = 'tan($numtext)';
                                } else if (userInput.startsWith('log') ==
                                    true) {
                                  userInput = 'log($numtext)';
                                } else if (userInput.startsWith('poly') ==
                                    true) {
                                  // polynomial evaluator for symbols like x, y, etc
                                  userInput = 'poly($numtext)';
                                } else {
                                  userInput += buttons[index];
                                }
                              });
                            },
                            buttonText: buttons[index],
                            color: help.isOperator(buttons[index])
                                ? Colors.orangeAccent
                                // not an operator(orange if so). For button color, is it a number?
                                : help.isNumber(buttons[index])
                                    ? Colors.blueGrey
                                    : Colors.white,
                            textColor: help.isOperator(buttons[index])
                                ? Colors.white
                                // not an operator(white text if so). for text color, is it a number?
                                : help.isNumber(buttons[index])
                                    ? Colors.black
                                    : Colors.black,
                          );
                        }
                    }
                  }), // GridView.builder
            ),
        ],
      ),
    );
  }

// function to calculate the output operation, ran when equal is pressed
// experiment with moving some of this code up before equal is pressed?
// into respective parts of the functions above
  void equalPressed() {
    // this needs to be fixed for larger operations with more than one square, such as cos(5^2)
    if (userInput.endsWith('²')) {
      int ind = userInput.indexOf('²');
      userInput = userInput.replaceAll(RegExp('[²]'), '');
      userInput = userInput.replaceRange(ind - numtext.length, ind,
          help.mySquare(int.parse(numtext)).toString());
    }

    if (userInput.contains('÷')) {
      userInput.trim();
      userInput = userInput.replaceAll(RegExp('[÷]'), '/');
    }

    // context model for dynamic screen overflow protection
    ContextModel cm = ContextModel();
    // parser to parse string expressions into numerical value
    Expression exp = p.parse(userInput);
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    // refresh the number text variable, so that it can be used again later
    numtext = '';
  }
}
