import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, this.buttonText,this.buttonTapped});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
