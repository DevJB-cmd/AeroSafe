import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the aviation safety application.
/// Implements Aerospace Minimalism design philosophy with Institutional Trust Palette.
class AppTheme {
  AppTheme._();

  // Primary color palette
  static const Color primaryLight = Color(0xFF0A1A3A); // Deep institutional blue
  static const Color primaryVariantLight = Color(0xFF0056B3); // Supporting institutional blue
  static const Color secondaryLight = Color(0xFF00C6FF); // Electric cyan
  static const Color backgroundLight = Color(0xFFF8FAFC); // Light background
  static const Color surfaceLight = Color(0xFFFFFFFF); // Light surface
  static const Color cardLight = Color(0xFFFFFFFF); // Light card
  static const Color errorLight = Color(0xFFFF4757); // Error color
  static const Color successLight = Color(0xFF00D95A); // Success color
  static const Color warningLight = Color(0xFFFFB347); // Warning color
  static const Color textPrimaryLight = Color(0xFF1A202C); 
  static const Color textSecondaryLight = Color(0xFFA0AEC0); 
  static const Color onPrimaryLight = Color(0xFFFFFFFF); 
  static const Color onSecondaryLight = Color(0xFF0A1A3A);
  static const Color onBackgroundLight = Color(0xFF1A202C);
  static const Color onSurfaceLight = Color(0xFF1A202C);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color shadowLight = Color(0x33000000); // 20% black opacity
  static Color successColor = const Color(0xFF00D95A); // Couleur de succès
  static Color warningColor = const Color(0xFFFFB347); // Couleur d'avertissement
  static const Color neutralColor = Color(0xFFA0AEC0); // Couleur neutre

  /// Exemple de configuration d'une méthode pour obtenir des styles monospaces
  // Dark theme colors
  static const Color primaryDark = Color(0xFF00C6FF);
  static const Color primaryVariantDark = Color(0xFF0056B3);
  static const Color secondaryDark = Color(0xFF00C6FF);
  static const Color backgroundDark = Color(0xFF0A1A3A);
  static const Color surfaceDark = Color(0xFF1A2A4A);
  static const Color cardDark = Color(0xFF1A2A4A);
  static const Color errorDark = Color(0xFFFF4757);
  static const Color successDark = Color(0xFF00D95A);
  static const Color warningDark = Color(0xFFFFB347);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFA0AEC0);
  static const Color onPrimaryDark = Color(0xFF0A1A3A);
  static const Color onBackgroundDark = Color(0xFFF8FAFC);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color borderDark = Color(0xFF2A3A5A); // Dark divider color
  static const Color shadowDark = Color(0x33FFFFFF); // 20% white opacity
  static const Color dividerDark = Color(0x1AF8FAFC); // Dark divider color

  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      error: errorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      outline: borderLight,
      shadow: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: borderLight,

    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: onPrimaryLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: onPrimaryLight,
      ),
    ),

    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryLight,
      foregroundColor: onSecondaryLight,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 48),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderLight, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: borderLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 2),
      ),
      labelStyle: GoogleFonts.inter(fontSize: 16, color: textSecondaryLight),
      hintStyle: GoogleFonts.inter(fontSize: 16, color: textSecondaryLight),
      errorStyle: GoogleFonts.inter(fontSize: 12, color: errorLight),
    ),
  );

  /// Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      error: errorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      outline: borderDark,
      shadow: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,

    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: onSurfaceDark,
      ),
    ),

    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
    ),

    // Additional components for dark theme can be similarly defined...
  );


}