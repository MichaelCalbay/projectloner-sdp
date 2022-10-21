import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';

class CustomPassField extends StatefulWidget {
  final TextEditingController password;
  late bool isPassword;

  CustomPassField({
    super.key,
    required this.password,
    required this.isPassword,
  });

  @override
  State<CustomPassField> createState() => _CustomPassFieldState();
}

class _CustomPassFieldState extends State<CustomPassField> {
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
            controller: widget.password,
            obscureText: widget.isPassword,
            enableSuggestions: false,
            autocorrect: false,
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () => setState(
                  (() => widget.isPassword = !widget.isPassword),
                ),
                icon: Icon(
                    widget.isPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.deepPurple),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomPassField extends StatelessWidget {
//   final TextEditingController password;
//   final bool isPassword;
//   const CustomPassField({
//     super.key,
//     required this.password,
//     required this.isPassword,
//   });

//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
