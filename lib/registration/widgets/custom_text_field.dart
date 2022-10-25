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
    required this.isTextOnly,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = LonerThemeProvider();
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: (themeProvider.isDarkMode) ? Colors.black : Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: confPwdController,
        obscureText: isPassword,
        enableSuggestions: false,
        autocorrect: false,
        //Validates and only allows texts.
        inputFormatters: (isTextOnly)
            ? [FilteringTextInputFormatter.deny(RegExp('[0-9]'))]
            : null,
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
