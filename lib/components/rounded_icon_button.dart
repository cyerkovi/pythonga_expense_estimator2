import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final Function onPressed; //VoidCallback is shorthand for void Function()
  // equivalent to:
  // final void Function onPressed or maybe final void Function() onPressed

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 40.0,
      color: Colors.grey[500],
      onPressed: onPressed(),
    );
  }
}
