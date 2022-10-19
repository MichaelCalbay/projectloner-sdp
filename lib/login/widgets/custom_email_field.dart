import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController email;
  final bool isPassword;
  const CustomEmailField({
    super.key,
    required this.email,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: (themeProvider.isDarkMode) ? Colors.black : Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: email,
            obscureText: isPassword,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'E-mail',
              icon: Icon(
                Icons.email_rounded,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ),
      );
      ),
    );
  }
}
