import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectloner/theme/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? confPwdController;

  final String hint;
  final bool isPassword;
  final bool isTextOnly;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.confPwdController,
    this.onChanged,
    required this.hint,
    required this.isPassword,
    required this.isTextOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = LonerThemeProvider();
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: confPwdController,
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        inputFormatters: (isTextOnly)
            ? [FilteringTextInputFormatter.deny(RegExp('[#]'))]
            : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: hint,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          fillColor:
              (themeProvider.isDarkMode) ? Colors.black : Colors.grey[200],
          filled: false,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
