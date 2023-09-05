import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xff220C10)),
  brightness: Brightness.light,
  dialogBackgroundColor: const Color(0xffACECA1),
  colorScheme:   const ColorScheme.light(
    background: Color(0xffE4F1FF),
    primary: Color(0xff0B666A),
    secondary: Color(0xff071952),
    tertiary: Color.fromARGB(255, 248, 135, 55),
  )
);