import 'helpers.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

final help = Helper();
Parser p = Parser();
bool tap = false;
// for modular clock, switches between list views
int timer = 0;
void main() {
  runApp(const MyApp());
}
extension NumberParsing on String{
    double parseDouble(){
        return double.parse(this);
      }
  }
class SettingsScreenNotifier extends ChangeNotifier {
  /// 1
  bool _isDarkModeEnabled = false;

  /// 2
  get isDarkModeEnabled => _isDarkModeEnabled;

  /// 3
  void toggleApplicationTheme(bool darkModeEnabled) {
    /// 4
    _isDarkModeEnabled = darkModeEnabled;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// use state and hooks to change between the lists below on push of a button
// class with helper functions for graphing and more

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  String numtext = '';
  String i = '';
  double k = 0;
  // the list that alternates with state and modulo
  final List<String> numpad = [
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
    '+'
  ];
  
  List<String> buttons = [
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
// Array of button
// mod 3 == 0
  final List<String> origin = [
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

// mod 3 == 1
  final List<String> alt = [
    'AC',
    '+/-',
    'DEL',
    'ALT',
    'acos',
    'asin',
    'atan',
    'sqrt',
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
// mod 3 == 2
  final List<String> graphing = [
    'AC',
    '+/-',
    'DEL',
    'ALT',
    'log',
    '^',
    'graph',
    'x',
    '(',
    ')',
    'y',
    '÷',
    'z',
    'int',
    'd/dx',
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
// parser for parsing string expressions

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
                    padding: const EdgeInsets.all(17),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(17),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                          fontSize: 25,
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
                    case 3:
                      {
                        // ALT CASE, SWAPS ARRAY LISTS
                        return MyButton(
                          buttontapped: () {
                            setState(() {
                              if (timer % 3 == 2) {
                                buttons = origin;
                              }
                              if (timer % 3 == 0) {
                                buttons = alt;
                              }
                              if (timer % 3 == 1) {
                                buttons = graphing;
                              }
                              timer++;
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
                            buttonText: buttons[index],
                            textColor: Colors.black);
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
                            buttonText: buttons[index],
                            textColor: Colors.black);
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
                            buttonText: buttons[index],
                            textColor: Colors.black);
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
                              if (userInput.contains('cos') == true &&
                                  numtext.toString() != '') {
                                userInput += (help.myCos('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('sin()') == true &&
                                  numtext.toString() != '') {
                                userInput += (help.mySin('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('tan()') == true &&
                                  numtext.toString() != '') {
                                userInput += (help.myTan('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('arcsin()') ==
                                      true ) {
                                // polynomial evaluator for symbols like x, y, etc
                                userInput += (help.myArcSin('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('arccos()') ==
                                      true) {
                                // polynomial evaluator for symbols like x, y, etc
                                userInput += (help.myArcCos('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('arctan()') == true) {
                                // polynomial evaluator for symbols like x, y, etc
                                userInput += (help.myArcTan('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('sqrt()') == true)  {
                                // square root function
                                userInput += (help.mySqrt('$numtext'.parseDouble())).toString();
                              } else if (userInput.contains('log') == true ) {
                                // square root function
                                userInput += (help.log2('$numtext'.parseDouble())).toString();
                              } else if( userInput.contains('!') == true){
                               userInput+= (help.myFactorial('$numtext'.parseDouble())).toString();
                              }else {
                                userInput += buttons[index];
                              }
                            });
                          },
                          buttonText: buttons[index],
                          color: help.isOperator(buttons[index])
                              ? Colors.orangeAccent
                              // not an operator(orange if so). For button color, is it a number?
                              : help.isNumber(buttons[index], 0)
                                  ? Colors.blueGrey
                                  : Colors.white,
                          textColor: help.isOperator(buttons[index])
                              ? Colors.white
                              // not an operator(white text if so). for text color, is it a number?
                              : help.isNumber(buttons[index], 0)
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

    // context model for dynamic screen overflow protection
    ContextModel cm = ContextModel();
    if (userInput.contains('÷')) {
      userInput = userInput.replaceAll(RegExp('[÷]'), '/');
    }
    // parser to parse string expressions into numerical value
    Expression exp = p.parse(userInput);
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    // refresh the number text variable, so that it can be used again later
    numtext = '';
  }
}
