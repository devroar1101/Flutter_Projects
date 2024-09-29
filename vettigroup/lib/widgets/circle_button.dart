import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final double iconSize;

  const CircleButton(
      {super.key,
      required this.iconData,
      required this.onPressed,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration:
          BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {
          onPressed();
        },
        icon: Icon(
          iconData,
          size: iconSize,
          color: Colors.black,
        ),
      ),
    );
  }
}
