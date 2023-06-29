import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeMode themeMode = ThemeMode.light;

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue.shade500,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.transparent,
    backgroundColor: Color.fromARGB(100, 222, 222, 222),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue.shade700,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.blue.shade800,
    secondary: Colors.blue.shade500,
    error: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (_) {
          return Colors.blue;
        },
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.grey.shade200,
  cardColor: Colors.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (_) {
          return Colors.black;
        },
      ),
    ),
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      color: Colors.white,
    ),
    bodyLarge: const TextStyle(
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey.shade600,
    ),
    displayMedium: const TextStyle(
      color: Colors.white,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.purple.shade300,
  appBarTheme: const AppBarTheme(
    shadowColor: Colors.transparent,
    backgroundColor: Color.fromARGB(100, 110, 110, 110),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.white
    ),
    displayMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.purple.shade700,
  ),
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color.fromARGB(100, 90, 90, 90),
  colorScheme: ColorScheme.dark(
    primary: Colors.purple.shade700,
    secondary: Colors.purple.shade300,
    error: Colors.grey,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (_) {
          return Colors.white;
        },
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (_) {
          return Colors.purple;
        },
      ),
    ),
  ),
);
