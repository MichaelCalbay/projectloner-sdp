import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';

class CustomObsTextField extends StatefulWidget {
  final TextEditingController? confPwdController;

  final String hint;
  bool isPassword;
  final Function(String)? onChanged;
  CustomObsTextField({
    Key? key,
    this.confPwdController,
    this.onChanged,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<CustomObsTextField> createState() => _CustomObsTextFieldState();
}

class _CustomObsTextFieldState extends State<CustomObsTextField> {
  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.confPwdController,
        obscureText: widget.isPassword,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.hint,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          fillColor:
              (themeProvider.isDarkMode) ? Colors.black : Colors.grey[200],
          filled: false,
          suffixIcon: IconButton(
            onPressed: () => setState(
              (() => widget.isPassword = !widget.isPassword),
            ),
            icon: Icon(
                widget.isPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.deepPurple),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
