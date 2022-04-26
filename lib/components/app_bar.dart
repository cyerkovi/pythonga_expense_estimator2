import 'package:flutter/material.dart';
import '../constants/text_constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(kAppTitle2),
      centerTitle: true,
    );
  }
}
