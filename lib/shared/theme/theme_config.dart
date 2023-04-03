import 'package:flutter/material.dart';

const primaryColor = Color(0xFFFFA500);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  textTheme: textThemeLight.apply(
    fontFamily: 'Catamaran',
  ),
  primaryTextTheme: textThemeLight.apply(
    fontFamily: 'Catamaran',
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: primaryColor),
    ),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
  ),
);

const textThemeLight = TextTheme(
  displaySmall: TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 28,
  ),
  headlineMedium: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  headlineSmall: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  titleLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  ),
  bodyLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  labelLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  bodySmall: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  labelSmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  displayLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: Colors.black,
  ),
  displayMedium: TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
);
