import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color primaryGradient;
  final Color secondaryGradient;
  final Color textColor;
  final Function()? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.primaryGradient,
    required this.secondaryGradient,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            primaryGradient,
            secondaryGradient,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          fixedSize: const Size(200, 40),
        ),
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
