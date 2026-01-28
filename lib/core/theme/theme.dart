import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static final lightTheme = ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.pink),
  );
  static final darkTheme = ThemeData(
    brightness: .dark,
    colorScheme: .fromSeed(brightness: .dark, seedColor: Colors.pink),
  );

  ThemeMode _themeMode = .system;
  ThemeMode get themeMode => _themeMode;

  void toLight() {
    _themeMode = .light;
    notifyListeners();
  }

  void toDart() {
    _themeMode = .dark;
    notifyListeners();
  }

  void toSystem() {
    _themeMode = .system;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
