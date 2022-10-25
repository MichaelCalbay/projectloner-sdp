import 'package:flutter_test/flutter_test.dart';
import 'package:projectloner/theme/theme_provider.dart';

void main() {
  test('Testing dark mode enabled', () {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    themeProvider.toggleTheme(true);

    expect(themeProvider.isDarkMode, true);
  });
  test('Testing dark mode disabled', () {
    LonerThemeProvider themeProvider = LonerThemeProvider();

    themeProvider.toggleTheme(false);

    expect(themeProvider.isDarkMode, false);
  });
}
