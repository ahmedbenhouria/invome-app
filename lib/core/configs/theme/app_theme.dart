import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.white),
    splashColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    fontFamily: 'AcuminPro',
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w500,
        fontSize: 13,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
    ),
  );
}
