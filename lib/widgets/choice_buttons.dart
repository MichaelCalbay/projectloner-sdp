import 'package:flutter/material.dart';

import '../theme/theme_provider.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color colour;
  final IconData icon;

  const ChoiceButton({
    Key? key,
    this.width = 60,
    this.height = 60,
    this.size = 25,
    required this.colour,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (themeProvider.isDarkMode) ? Colors.black54 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(3, 3),
            )
          ]),
      child: Icon(
        icon,
        color: colour,
        size: size,
      ),
    );
  }
}
