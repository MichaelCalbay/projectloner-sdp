import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? confPwdController;

  final String hint;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.confPwdController,
    this.onChanged,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    //If app is in dark mode.
    if (themeProvider.isDarkMode) {
      return Container(
        height: 56,
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: confPwdController,
          obscureText: isPassword,
          enableSuggestions: false,
          autocorrect: false,
          style: const TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: hint,
          ),
          onChanged: onChanged,
        ),
      );
    }
    //Otherwise,
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: confPwdController,
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
