import 'package:flutter/material.dart';
import '../constants/style_constants.dart';

class StepText extends StatelessWidget {
  const StepText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kStepTitleTextStyle,
    );
  }
}
