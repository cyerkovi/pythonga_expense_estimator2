import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed; //VoidCallback is shorthand for void Function()
  // equivalent to:
  // final void Function onPressed or maybe final void Function() onPressed

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        child: Icon(icon),
        onPressed: onPressed,
        elevation: 0.0,
        shape: const CircleBorder(),
        fillColor: Colors.grey[500],
        // fillColor: Color(0xFF4C4F5E),
        // fillColor: Colors.white54,
        constraints: const BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ));
  }
}
