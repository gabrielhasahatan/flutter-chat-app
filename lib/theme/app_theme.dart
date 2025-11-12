import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(0xFF, 145, 18, 188);
  static const Color secondaryColor = Color.fromARGB(0xFF, 199, 56, 189);
  static const Color accentColor = Color.fromARGB(0xFF, 228, 90, 146);
  static const Color backgroundColor = Color.fromARGB(0xFF, 249, 248, 246);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color.fromARGB(0xFF, 26, 26, 29);
  static const Color textSecondaryColor = Color.fromARGB(0xFF, 68, 68, 78);
  static const Color borderColor = Color.fromARGB(0xFF, 197, 176, 205);
  static const Color errorColor = Color.fromARGB(0xFF, 234, 34, 100);
  static const Color succesColor = Color.fromARGB(0xFF, 120, 185, 181);
  static const Color whitePrimary = Color.fromARGB(0xFF, 249, 248, 246);

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: errorColor,
        onSurface: textPrimaryColor,
        onBackground: textSecondaryColor,
      ),
      textTheme: GoogleFonts.soraTextTheme().copyWith(
        headlineLarge: GoogleFonts.sora(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor,
        ),
        headlineMedium: GoogleFonts.sora(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        headlineSmall: GoogleFonts.sora(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor,
        ),
        bodyLarge: GoogleFonts.sora(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textSecondaryColor,
        ),
        bodyMedium: GoogleFonts.sora(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondaryColor,
        ),
        bodySmall: GoogleFonts.sora(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondaryColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: textPrimaryColor),
      ),
      iconTheme: const IconThemeData(
        color: textPrimaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      cardTheme: CardTheme(
          color: cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ))),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: errorColor)),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0));
}
