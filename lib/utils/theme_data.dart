import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Color(0xff030313),
    ),
    brightness: Brightness.light);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color(0xff030313),
    ),
    brightness: Brightness.dark);
