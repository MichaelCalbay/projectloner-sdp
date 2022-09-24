import 'package:flutter/material.dart';

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
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.confPwdController,
        obscureText: widget.isPassword,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: widget.hint,
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
