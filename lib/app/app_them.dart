import 'package:ecomm_bloc/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  /// -------------------- LIGHT THEME --------------------
  static ThemeData get LightThemeData {
    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 3,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
      ),

      // BottomNavigationBar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.themeColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.themeColor),
      ),

      // TextField / Input Decoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 2),
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }

  /// -------------------- DARK THEME --------------------
  static ThemeData get DarkThemeData {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.black,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        // backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 3,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 24),
      ),

      // BottomNavigationBar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //backgroundColor: AppColors.themeColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.themeColor),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.grey[900],
      ),

      // Text Theme
      textTheme: const TextTheme(
        titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 13, color: Colors.lightGreen),
        bodySmall: TextStyle(fontSize: 12, color: Colors.white70),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: Colors.tealAccent, size: 20),

      // Input Decoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.grey,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 2),
        ),
      ),
    );
  }
}
