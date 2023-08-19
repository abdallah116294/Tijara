import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const theme_statues = "THEME_STATUS";
  bool _darkTheme = false;
  bool get getIsDarkTheme => _darkTheme;
  ThemeProvider() {
    getTheme();
  }
  // set to the theme value
  Future<void> setDarkTheme({required bool themeValue}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(theme_statues, themeValue);
    _darkTheme = themeValue;
    notifyListeners();
  }

  //get the function
  Future<bool> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _darkTheme = preferences.getBool(theme_statues) ?? false;
    notifyListeners();
    return _darkTheme;
  }
}
