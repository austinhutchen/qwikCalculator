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

class _HomePageState extends State<HomePage> {
var userInput = '';
var answer = '';

// Array of button
final List<String> buttons = [
	'AC',
	'+/-',
	'%',
	'DEL',
  'cos',
  'sin',
  'tan',
  'log',
	'7',
	'8',
	'9',
	'/',
	'4',
	'5',
	'6',
	'x',
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
	appBar: new AppBar(
	title:  new Text("Calculator"),
	), //AppBar
	backgroundColor: Colors.white,
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
						style: const TextStyle(fontSize: 23, color: Colors.black),
					),
					),
					Container(
					padding: const EdgeInsets.all(15),
					alignment: Alignment.centerRight,
					child: Text(
						answer,
						style: const TextStyle(
							fontSize: 30,
							color: Colors.black,
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
							userInput = userInput.substring(0, userInput.length - 1);
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
						color: Colors.white,
						textColor: Colors.black,
					);
					}
          // cosin button, to use this check if next input is a valid integer and replace inside of string with integer ex. cos()x -> cos(x)
          else if(index == 4){
          String i =buttons[index];
          return MyButton(buttontapped: (){
            setState((){
            String k= buttons[index].replaceAll('cos', 'cos()');
            userInput += k;
            });
          },
          buttonText: i);
          }
          // sin button
          else if(index == 5){
          String i =buttons[index];
          return MyButton(buttontapped: (){
            setState((){
            String k= buttons[index].replaceAll('sin', 'sin()');
            userInput += k;
            });
          },
          buttonText: i);
          }
          // tan button
          else if(index == 6){
          String i =buttons[index];
          return MyButton(buttontapped: (){
            setState((){
            String k= buttons[index].replaceAll('tan', 'tan()');
            userInput += k;
            });
          },
          buttonText: i);
          }
          // log button
          else if(index == 7){
          String i =buttons[index];
          return MyButton(buttontapped: (){
            setState((){
            String k= buttons[index].replaceAll('log', 'log()');
            userInput += k;
            });
          },
          buttonText: i);
          }
					// other buttons, numbers
					else {
					return MyButton(
						buttontapped: () {
						setState(() {
              if(userInput.startsWith('cos')==true){
                // DEBUG HERE AND FIX BELOW, THIS WILL ONLY WORK FOR ONE NUMBER INPUT AT A TIME
                userInput = 'cos(${buttons[index]})';
              }
              else if(userInput.startsWith('sin')==true){
                userInput = 'sin(${buttons[index]})';
              }
              else if(userInput.startsWith('tan')==true){
                userInput = 'tan(${buttons[index]})';
              }
              else if (userInput.startsWith('log')==true){
                userInput = 'log(${buttons[index]})';
              }
              else{
              userInput += buttons[index];
              }
						
						});
						},
						buttonText: buttons[index],
						color: isOperator(buttons[index])
							? Colors.orangeAccent
							: Colors.white,
						textColor: isOperator(buttons[index])
							? Colors.white
							: Colors.black,
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
	if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=' || x == 'Cos' || x == 'Sin' || x == 'Tan' || x == 'Log') {
	return true;
	}
	return false;
}

// function to calculate the input operation
void equalPressed() {
	String finaluserinput = userInput;
	finaluserinput = userInput.replaceAll('x', '*');

	Parser p = Parser();
	Expression exp = p.parse(finaluserinput);
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toString();
}
}
