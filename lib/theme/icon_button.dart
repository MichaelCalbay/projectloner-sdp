import 'package:flutter/material.dart';
import 'package:projectloner/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeIconData {
  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;
}

class ThemeMaterialButton extends StatelessWidget {
  ThemeIconData data = ThemeIconData();

  ThemeMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LonerThemeProvider>(context);
    return RawMaterialButton(
      key: Key("toggleButtonTheme"),
      shape: const CircleBorder(),
      elevation: 2.0,
      fillColor: themeProvider.isDarkMode ? Colors.grey[700] : Colors.grey[200],
      onPressed: () {
        themeProvider.toggleTheme(themeProvider.isDarkMode ? false : true);
      },
      child: Icon(themeProvider.isDarkMode ? data.iconDark : data.iconLight),
    );
  }
}

class ThemeIconButton extends StatelessWidget {
  ThemeIconData data = ThemeIconData();

  ThemeIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LonerThemeProvider>(context);
    return IconButton(
        key: Key("toggleIconTheme"),
        onPressed: () {
          themeProvider.toggleTheme(themeProvider.isDarkMode ? false : true);
        },
        icon: Icon(themeProvider.isDarkMode ? data.iconDark : data.iconLight));
  }
}
