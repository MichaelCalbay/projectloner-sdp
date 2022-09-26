import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;
  const CustomTextHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontStyle: FontStyle.italic,
        color: Colors.black54,
      ),
    );
  }
}
