import 'package:flutter/material.dart';

class OurTheme {
  final Color _lightGreen = const Color.fromARGB(255, 213, 235, 220);
  final Color _ligtGrey = const Color.fromARGB(255, 164, 164, 164);
  final Color _darkGrey = const Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _lightGreen,
      primaryColor: _lightGreen,
      dividerColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: const Color(0xff1d1e26),secondary:  const Color(0xff252041)),
      secondaryHeaderColor: _darkGrey,
      hintColor: _ligtGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: _ligtGrey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: _lightGreen)),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkGrey,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 200,
        height: 40.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
