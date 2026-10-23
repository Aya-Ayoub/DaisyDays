import 'package:flutter/material.dart';

class AppTheme {
  static const Color blushPink = Color(0xFFE9A9BC);
  static const Color deepRose = Color(0xFFAD617B);
  static const Color cream = Color(0xFFFFFAF5);
  static const Color palePink = Color(0xFFFFEEF2);
  static const Color softBrown = Color(0xFF6D555B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(
        seedColor: deepRose,
        brightness: Brightness.light,
        surface: cream,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: softBrown,
        elevation: 0,
        centerTitle: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: palePink,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: deepRose,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }

          return const TextStyle(color: softBrown, fontSize: 12);
        }),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
