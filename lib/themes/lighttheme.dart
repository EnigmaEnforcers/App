import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1b444f),
  ),
  brightness: Brightness.light,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xff000000),
    ),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  dialogBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Color(0xffc3f54e),
    secondary: Color(0xffd3c3f8),
    tertiary: Color(0xff1b444f),
  ),
);
