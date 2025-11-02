import 'package:flutter/material.dart';

class RickAndMortyTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0C0C1E),
      primaryColor: const Color(0xFF00FF9D),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00FF9D),
        secondary: Color(0xFFFFE81F),
        surface: Color(0xFF1B1B2F),
        background: Color(0xFF0C0C1E),
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        error: Color(0xFFFF4D4D),
        onError: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Orbitron',
          color: Color(0xFF00FF9D),
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Orbitron',
          color: Color(0xFFFFE81F),
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white70,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1B1B2F),
        selectedItemColor: Color(0xFF00FF9D),
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1B1B2F),
        elevation: 4,
        shadowColor: Colors.black54,
        titleTextStyle: TextStyle(
          fontFamily: 'Orbitron',
          fontSize: 20,
          color: Color(0xFF00FF9D),
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF9D),
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: const Color(0xFF00FF9D).withOpacity(0.3),
        elevation: 6,
      ),
    );
  }
}
