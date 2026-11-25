import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final Color? color;
  final Color textColor;
  final String buttonText;
  final double textSize=20.0;
  final buttontapped;

//Constructor
  const MyButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.20),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
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
