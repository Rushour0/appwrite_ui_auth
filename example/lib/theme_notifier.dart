import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  static ThemeMode _themeData = ThemeMode.system;

  ThemeNotifier();

  static ThemeMode getTheme() => _themeData;

  static Brightness getBrightness() =>
      _themeData == ThemeMode.light ? Brightness.light : Brightness.dark;

  set setTheme(ThemeMode theme) {
    _themeData = theme;
    notifyListeners();
  }
}
