import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.controller,
    this.onChanged,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);

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
    // return TextField(
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor: Colors.transparent,
    //     hintText: hint,
    //     contentPadding: const EdgeInsets.only(
    //       bottom: 5.0,
    //       top: 12.5,
    //     ),
    //     // focusedBorder: const OutlineInputBorder(
    //     //   borderSide: BorderSide(color: Colors.transparent),
    //     // ),
    //     enabledBorder: const UnderlineInputBorder(
    //       borderSide: BorderSide(color: Colors.transparent),
    //     ),
    //   ),
    // );
  }
}
