import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {

// declaring variables
final Color? color;
final Color textColor;
final String buttonText;
final buttontapped;

//Constructor
const MyButton({super.key, required this.color, required this.textColor, required this.buttonText, this.buttontapped});

@override
Widget build(BuildContext context) {
	return GestureDetector(
	onTap: buttontapped,
	child: Padding(
		padding: const EdgeInsets.all(0.50),
		child: ClipRRect(
		// borderRadius: BorderRadius.circular(25),
    borderRadius: BorderRadius.circular(8),
		child: Container(
			color: color,
			child: Center(
			child: Text(
				buttonText,
				style: TextStyle(
				color: textColor,
				fontSize: 30,
				fontWeight: FontWeight.bold,
				),
			),
			),
		),
		),
	),
	);
}
}
