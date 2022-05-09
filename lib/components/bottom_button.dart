import 'package:flutter/material.dart';
import '../constants/text_constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.buttonTitle, required this.onPressed});

  String buttonTitle = kSpace;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed(),
      child: Center(
        child: Text(buttonTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
