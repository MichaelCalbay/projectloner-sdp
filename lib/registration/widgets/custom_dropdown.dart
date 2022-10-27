import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatelessWidget {
  final Function(String?)? onChanged;

  final server = [
    'APAC',
    'EU',
    'NA',
    'LATAM',
  ];
  static String? valueServer;
  DropdownMenuItem<String> menuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      );

  CustomDropdown({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LonerThemeProvider themeProvider = LonerThemeProvider();
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: valueServer,
        items: server.map(menuItem).toList(),
        onChanged: onChanged,
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.deepPurple,
        ),
        decoration: const InputDecoration(
          labelText: 'Server',
          border: InputBorder.none,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
