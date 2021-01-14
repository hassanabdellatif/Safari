import 'package:flutter/material.dart';
import 'package:project/constants_colors.dart';

class ThemeProvider extends ChangeNotifier {


  ThemeData _themeData;
  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
  final dark = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1e2336),
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    //dialogBackgroundColor: Colors.red,
    //canvasColor: Colors.red,
    //cardColor: redColor,
    //cardTheme: CardTheme(color: Colors.orange),
    backgroundColor: Color(0xFF1e2336),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black54,
  );

  final light = ThemeData(
    scaffoldBackgroundColor: grey50Color,
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.grey[50],
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

