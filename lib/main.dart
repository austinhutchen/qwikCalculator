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
// use this to find square root
  double mySqrt(double x,int precision) {
    // find a way to include decimals in binary search, and convert to integer
    // after. This only works for whole numbers
    double first = 0;
    double last = x;
    double mid;
    double ans=0;
    while (first <= last) {
      mid = (first + last) / 2.0;
      double sq = mid*mid;
      if (sq == x) {
        return mid;
      }
      // if decimals were to be included, the below would be a function call for secondary binary search through the decimals, instead of mid being assigned to ans
      if (sq < x) {
      ans=mid;
        first = mid + 1;
      } 
      else if (sq > x) {
        last = mid - 1;
      }
    }
   
    return ans;
  }

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  String numtext = '';
// Array of button
  final List<String> buttons = [
    'AC',
    '+/-',
    'x',
    'DEL',
    'cos',
    'sin',
    'tan',
    '²',
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
                      padding: const EdgeInsets.all(15),
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
            flex: 3,
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
                    else if (index == 2) {
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
                    else if (index == 3) {
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
                          color:Colors.blue[50],
                          buttonText: buttons[index]);
                          
                    }
                    // sin button
                    else if (index == 5) {
                      return MyButton(
                          buttontapped: () {
                            setState(() {
                              String k =
                                  buttons[index].replaceAll('sin', 'sin()');
                              userInput += k;
                            });
                          },
                          color:Colors.blue[50],
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
                          color:Colors.blue[50],
                          buttonText: buttons[index]);
                    }
                    // log button
                    else if (index == 7) {
                      return MyButton(
                          buttontapped: () {
                            setState(() {
                              String k =
                                  buttons[index].replaceAll('log', 'log()');
                              userInput += k;
                            });
                          },
                          color:Colors.orangeAccent,
                          buttonText: buttons[index]);
                          
                    }
                    // other buttons, numbers, square root, extra functions
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            numtext += buttons[index];
                            if (userInput.startsWith('cos') == true) {
                              userInput = 'cos($numtext)';
                            } else if (userInput.startsWith('sin') == true) {
                              userInput = 'sin($numtext)';
                            } else if (userInput.startsWith('tan') == true) {
                              userInput = 'tan($numtext)';
                            } else if (userInput.startsWith('log') == true) {
                              userInput = 'log($numtext)';
                            } else if (userInput.contains('²') == true) {
                              userInput = '$numtext²';
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
                            // not an operator(black text if so). for text color, is it a number?
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
        x == '+' ||
        x == '=' ||
        x == 'cos' ||
        x == 'sin' ||
        x == 'tan' ||
        x == 'log'||
        x == '²') 
    {
      return true;
    }
    else{
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

// function to calculate the input operation, ran when equal is pressed
  void equalPressed() {
    String finaluserinput = userInput;

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    // refresh the number text variable, so that it can be used again later
    numtext = '';
  }
}
