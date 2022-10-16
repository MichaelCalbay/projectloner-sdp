import 'package:flutter/material.dart';

class LonerThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();  
  }
}

class LonerTheme {
  static const primaryColour = Colors.deepPurple;
  static final darkMode = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    primarySwatch: primaryColour,
  );

  static final lightMode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primarySwatch: primaryColour,
  );
}