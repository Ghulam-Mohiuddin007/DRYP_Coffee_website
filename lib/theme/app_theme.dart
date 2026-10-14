import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Deep artisanal palette inspired by roasted coffee beans, warm neon, and brass
  static const Color bgDark = Color(0xFF0C0B0A);
  static const Color bgCard = Color(0xFF151311);
  static const Color bgCardElevated = Color(0xFF1E1A17);
  static const Color bgSurface = Color(0xFF26211C);

  // Warm Amber & Caramel Accents (inspired by DRYP neon light and caramel drizzle)
  static const Color accentAmber = Color(0xFFE89A3C);
  static const Color accentCaramel = Color(0xFFD48B38);
  static const Color accentGold = Color(0xFFF7C268);
  static const Color accentWarmOrange = Color(0xFFFF7A3D);

  // Organic foliage green (matching the lush storefront ivy panels)
  static const Color accentGreen = Color(0xFF5A7859);

  // Typography Colors
  static const Color textLight = Color(0xFFF7F5F0);
  static const Color textMuted = Color(0xFFACA49A);
  static const Color textSubtle = Color(0xFF6E675E);

  // Google Colors for authentic Reviews integration
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color starGold = Color(0xFFFFB800);

  // Border & Glows
  static const Color borderSubtle = Color(0x1AFFFFFF);
  static const Color borderAmber = Color(0x3DE89A3C);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      primaryColor: accentAmber,
      colorScheme: const ColorScheme.dark(
        primary: accentAmber,
        secondary: accentCaramel,
        surface: bgCard,
        onPrimary: Colors.black,
        onSurface: textLight,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 56,
          fontWeight: FontWeight.w800,
          color: textLight,
          letterSpacing: -1.5,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: textLight,
          letterSpacing: -1.0,
          height: 1.2,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: textLight,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textMuted,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textMuted,
          height: 1.5,
        ),
      ),
    );
  }
}
