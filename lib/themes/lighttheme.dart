import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xff220C10)),
  brightness: Brightness.light,
  dialogBackgroundColor: const Color(0xffACECA1),
  colorScheme:   const ColorScheme.light(
    background: Color(0xffE5EAFA),
    primary: Color(0xff74058A),
    secondary: Color(0xff5D2A42),
    tertiary: Color.fromARGB(255, 192, 249, 245),
  )
);