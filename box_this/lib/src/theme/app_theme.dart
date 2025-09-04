import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(250, 250, 250, 1), // Alabaster
      secondary: Color.fromRGBO(223, 185, 131, 1.0), // Tumbleweed
      tertiary: Color.fromRGBO(58, 72, 1, 1.0), // Verdun Green
      onPrimary: Color.fromRGBO(78, 15, 25, 1.0), // Heath

      onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
      error: Color.fromRGBO(255, 12, 12, 1.0),
      onError: Color.fromRGBO(255, 255, 255, 1.0),
      surface: Color.fromRGBO(250, 250, 250, 1),
      onSurface: Color.fromRGBO(78, 15, 25, 1.0),
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(250, 250, 250, 1), // Alabaster
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(78, 15, 25, 1.0), // Heath
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(78, 15, 25, 1.0), // Heath
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(250, 250, 250, 1), // Alabaster
      )
    ),
    extensions: <ThemeExtension<dynamic>>[
      const GradientsExtension(
        greenGradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF3A4801), Color(0xFF7D9200)],
          stops: [0.0, 1.0],
        ),
        beigeGradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFF1D5AE), Color(0xFFDBB77F), Color(0xFFDFB983)],
          stops: [0.0, 0.5564, 1.0],
        ),
      ),
    ],
  );
}
