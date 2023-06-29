import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeModeType _currentThemeMode = ThemeModeType.light;
  SharedPreferences _prefs;

  ThemeProvider(this._prefs) {
    loadThemeMode();
  }

  ThemeModeType get currentThemeMode => _currentThemeMode;

  void toggleTheme() {
    // print('toggle theme');
    _currentThemeMode = _currentThemeMode == ThemeModeType.dark
        ? ThemeModeType.light
        : ThemeModeType.dark;
    saveThemeMode();
    // print('notify');
    notifyListeners();
  }

  Future loadThemeMode() async {
    _prefs = await SharedPreferences.getInstance();
    final isDarkTheme = _prefs.getBool('isDarkTheme') ?? false;
    _currentThemeMode = isDarkTheme ? ThemeModeType.dark : ThemeModeType.light;
    notifyListeners();
  }

  Future saveThemeMode() async {
    // print('save Theme');
    await _prefs.setBool(
      'isDarkTheme',
      _currentThemeMode == ThemeModeType.dark,
    );
  }
}
