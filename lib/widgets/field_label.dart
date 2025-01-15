import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double textSize;
  const FieldLabel(
    this.text, {
    super.key,
    this.textColor,
    this.textSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: textSize,
        ),
      ),
    );
  }
}
