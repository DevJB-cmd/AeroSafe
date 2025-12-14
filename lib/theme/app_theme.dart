import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the aviation safety application.
/// Implements Aerospace Minimalism design philosophy with Institutional Trust Palette.
class AppTheme {
  AppTheme._();
    static const Color primaryLight =
      Color(0xFF0A1A3A); // Deep institutional blue
  static const Color primaryVariantLight =
      Color(0xFF0056B3); // Supporting institutional blue
  static const Color secondaryLight =
      Color(0xFF00C6FF); // Strategic cyan accent
  static const Color secondaryVariantLight = Color(0xFF0056B3);
  static const Color backgroundLight = Color(0xFF0F1B2F); // Primary background
  static const Color surfaceLight = Color(0xFF1A2B4A); // Elevated surface
  static const Color errorLight = Color(0xFFFF4757); // Prohibition red
  static const Color onPrimaryLight = Color(0xFFF8FAFC); // High contrast white
  static const Color onSecondaryLight = Color(0xFF0A1A3A);
  static const Color onBackgroundLight = Color(0xFFF8FAFC);
  static const Color onSurfaceLight = Color(0xFFF8FAFC);
  static const Color onErrorLight = Color(0xFFF8FAFC);

  // Dark theme colors (optimized for OLED displays)
  static const Color primaryDark = Color(0xFF0A1A3A);
  static const Color primaryVariantDark = Color(0xFF0056B3);
  static const Color secondaryDark = Color(0xFF00C6FF);
  static const Color secondaryVariantDark = Color(0xFF0056B3);
  static const Color backgroundDark = Color(0xFF0F1B2F);
  static const Color surfaceDark = Color(0xFF1A2B4A);
  static const Color errorDark = Color(0xFFFF4757);
  static const Color onPrimaryDark = Color(0xFFF8FAFC);
  static const Color onSecondaryDark = Color(0xFF0A1A3A);
  static const Color onBackgroundDark = Color(0xFFF8FAFC);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onErrorDark = Color(0xFFF8FAFC);

  // Semantic colors
  static const Color successColor = Color(0xFF00D95A); // Radar green
  static const Color warningColor = Color(0xFFFFB347); // Runway orange
  static const Color neutralColor =
      Color(0xFF2A4A80); // Balanced cold blue-gray

  // Card and dialog colors
  static const Color cardLight = Color(0xFF1A2B4A);
  static const Color cardDark = Color(0xFF1A2B4A);
  static const Color dialogLight = Color(0xFF1A2B4A);
  static const Color dialogDark = Color(0xFF1A2B4A);

  // Shadow colors with cyan tint (20% opacity)
  static const Color shadowLight = Color(0x3300C6FF);
  static const Color shadowDark = Color(0x3300C6FF);

  // Divider colors (10% opacity)
  static const Color dividerLight = Color(0x1AF8FAFC);
  static const Color dividerDark = Color(0x1AF8FAFC);

  // Text colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(0xFFF8FAFC); // 100% opacity
  static const Color textMediumEmphasisLight = Color(0x99F8FAFC); // 60% opacity
  static const Color textDisabledLight = Color(0x61F8FAFC); // 38% opacity

  static const Color textHighEmphasisDark = Color(0xFFF8FAFC);
  static const Color textMediumEmphasisDark = Color(0x99F8FAFC);
  static const Color textDisabledDark = Color(0x61F8FAFC);

  /// Light theme (optimized for aviation professional credibility)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness
        .dark, // Using dark brightness for institutional night operations
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      secondaryContainer: secondaryVariantLight,
      onSecondaryContainer: onSecondaryLight,
      tertiary: secondaryLight,
      onTertiary: onSecondaryLight,
      tertiaryContainer: secondaryVariantLight,
      onTertiaryContainer: onSecondaryLight,
      error: errorLight,
      onError: onErrorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: textMediumEmphasisLight,
      outline: dividerLight,
      outlineVariant: dividerLight,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: onSurfaceLight,
      elevation: 0,
      shadowColor: shadowLight,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onSurfaceLight,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: dividerLight, width: 1.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: secondaryLight,
      unselectedItemColor: textMediumEmphasisLight,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryLight,
      foregroundColor: onSecondaryLight,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(
            color: secondaryLight.withValues(alpha: 0.5), width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return neutralColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight.withValues(alpha: 0.5);
        }
        return neutralColor.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryLight),
      side: BorderSide(color: dividerLight, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return neutralColor;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondaryLight,
      linearTrackColor: neutralColor.withValues(alpha: 0.3),
      circularTrackColor: neutralColor.withValues(alpha: 0.3),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryLight,
      thumbColor: secondaryLight,
      overlayColor: secondaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: neutralColor.withValues(alpha: 0.3),
      valueIndicatorColor: secondaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onSecondaryLight,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: secondaryLight,
      unselectedLabelColor: textMediumEmphasisLight,
      indicatorColor: secondaryLight,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        color: backgroundLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceLight,
      contentTextStyle: GoogleFonts.inter(
        color: textHighEmphasisLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: secondaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8.0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: dialogLight,
      elevation: 8.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisLight,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceLight,
      elevation: 8.0,
      shadowColor: shadowLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),
  );

  /// Dark theme (identical to light for consistent night operations)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryVariantDark,
      onSecondaryContainer: onSecondaryDark,
      tertiary: secondaryDark,
      onTertiary: onSecondaryDark,
      tertiaryContainer: secondaryVariantDark,
      onTertiaryContainer: onSecondaryDark,
      error: errorDark,
      onError: onErrorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: textMediumEmphasisDark,
      outline: dividerDark,
      outlineVariant: dividerDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    appBarTheme: AppBarTheme(
      color: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      shadowColor: shadowDark,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onSurfaceDark,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: dividerDark, width: 1.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: secondaryDark,
      unselectedItemColor: textMediumEmphasisDark,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryDark,
      foregroundColor: onSecondaryDark,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryDark,
        backgroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side:
            BorderSide(color: secondaryDark.withValues(alpha: 0.5), width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerDark, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryDark, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorDark, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorDark, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return neutralColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark.withValues(alpha: 0.5);
        }
        return neutralColor.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryDark),
      side: BorderSide(color: dividerDark, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return neutralColor;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondaryDark,
      linearTrackColor: neutralColor.withValues(alpha: 0.3),
      circularTrackColor: neutralColor.withValues(alpha: 0.3),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryDark,
      thumbColor: secondaryDark,
      overlayColor: secondaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: neutralColor.withValues(alpha: 0.3),
      valueIndicatorColor: secondaryDark,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onSecondaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: secondaryDark,
      unselectedLabelColor: textMediumEmphasisDark,
      indicatorColor: secondaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        color: backgroundDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: textHighEmphasisDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: secondaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8.0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: dialogDark,
      elevation: 8.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisDark,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceDark,
      elevation: 8.0,
      shadowColor: shadowDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Space Grotesk for headings
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),

      // Headline styles - Space Grotesk for headings
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),

      // Title styles - Space Grotesk for headings
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),

      // Body styles - Inter for body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
      ),

      // Label styles - Inter for captions
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textDisabled,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Helper method to get monospace text style for data display
  static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      letterSpacing: 0,
    );
  }

  /// Animation duration constants
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 250);
  static const Duration slowAnimation = Duration(milliseconds: 300);

  /// Animation curves
  static const Curve defaultCurve = Curves.easeOut;
  static const Curve springCurve = Curves.easeInOut;

  /// Border radius constants
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;

  /// Elevation constants
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  /// Spacing constants
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  /// Touch target size (minimum 48dp for accessibility)
  static const double minTouchTarget = 48.0;
  // Primary color palette - Deep institutional blue establishing trust and authority
  static const Color primaryLight = Color(0xFF0A1A3A);
  static const Color primaryVariantLight = Color(0xFF0056B3);

  // Secondary color - Electric cyan for critical actions and progress indicators
  static const Color secondaryLight = Color(0xFF00C6FF);
  static const Color secondaryVariantLight = Color(0xFF0056B3);

  // Surface and background colors
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dialogLight = Color(0xFFFFFFFF);

  // Semantic colors
  static const Color errorLight = Color(0xFFFF4757);
  static const Color successLight = Color(0xFF00D95A);
  static const Color warningLight = Color(0xFFFFB347);

  // Text colors with proper contrast
  static const Color textPrimaryLight = Color(0xFF1A202C);
  static const Color textSecondaryLight = Color(0xFFA0AEC0);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFF1A202C);
  static const Color onBackgroundLight = Color(0xFF1A202C);
  static const Color onSurfaceLight = Color(0xFF1A202C);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Border and divider colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color dividerLight = Color(0xFFE2E8F0);

  // Shadow colors - subtle elevation
  static const Color shadowLight = Color(0x33000000); // 20% opacity black

  // Dark theme colors
  static const Color primaryDark = Color(0xFF00C6FF);
  static const Color primaryVariantDark = Color(0xFF0056B3);
  static const Color secondaryDark = Color(0xFF00C6FF);
  static const Color secondaryVariantDark = Color(0xFF0056B3);
  static const Color backgroundDark = Color(0xFF0A1A3A);
  static const Color surfaceDark = Color(0xFF1A2A4A);
  static const Color cardDark = Color(0xFF1A2A4A);
  static const Color dialogDark = Color(0xFF1A2A4A);
  static const Color errorDark = Color(0xFFFF4757);
  static const Color successDark = Color(0xFF00D95A);
  static const Color warningDark = Color(0xFFFFB347);
  static const Color onPrimaryDark = Color(0xFF0A1A3A);
  static const Color onSecondaryDark = Color(0xFF0A1A3A);
  static const Color onBackgroundDark = Color(0xFFF8FAFC);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onErrorDark = Color(0xFFFFFFFF);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFA0AEC0);
  static const Color borderDark = Color(0xFF2A3A5A);
  static const Color dividerDark = Color(0xFF2A3A5A);
  static const Color shadowDark = Color(0x33FFFFFF); // 20% opacity white

  /// Light theme with aerospace minimalism aesthetic
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      secondaryContainer: secondaryVariantLight,
      onSecondaryContainer: onSecondaryLight,
      tertiary: secondaryLight,
      onTertiary: onSecondaryLight,
      tertiaryContainer: secondaryVariantLight,
      onTertiaryContainer: onSecondaryLight,
      error: errorLight,
      onError: onErrorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: textSecondaryLight,
      outline: borderLight,
      outlineVariant: dividerLight,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,

    // AppBar theme - clean aerospace aesthetic
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
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: onPrimaryLight,
        size: 24,
      ),
    ),

    // Card theme with subtle elevation
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),

    // Bottom navigation bar theme - thumb zone optimized
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryLight,
      unselectedItemColor: textSecondaryLight,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button - emergency actions
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryLight,
      foregroundColor: onSecondaryLight,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        elevation: 2.0,
        shadowColor: shadowLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 48),
        side: const BorderSide(color: primaryLight, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(64, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Text theme with Inter and Space Grotesk (replaced with Inter)
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration theme - clean form elements
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderLight, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: secondaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorLight, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorLight, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryLight,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryLight,
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: errorLight,
      ),
      prefixIconColor: textSecondaryLight,
      suffixIconColor: textSecondaryLight,
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return textSecondaryLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight.withValues(alpha: 0.5);
        }
        return borderLight;
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryLight),
      side: const BorderSide(color: borderLight, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return borderLight;
      }),
    ),

    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: secondaryLight,
      linearTrackColor: borderLight,
      circularTrackColor: borderLight,
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryLight,
      thumbColor: secondaryLight,
      overlayColor: secondaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: borderLight,
      valueIndicatorColor: primaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: onPrimaryLight,
      ),
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: primaryLight,
      unselectedLabelColor: textSecondaryLight,
      indicatorColor: secondaryLight,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: onPrimaryLight,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryLight,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onPrimaryLight,
      ),
      actionTextColor: secondaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
    ),

    // Bottom sheet theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceLight,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      backgroundColor: dialogLight,
      elevation: 4.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimaryLight,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimaryLight,
      ),
    ),
  );

  /// Dark theme with aerospace minimalism aesthetic
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryVariantDark,
      onSecondaryContainer: onSecondaryDark,
      tertiary: secondaryDark,
      onTertiary: onSecondaryDark,
      tertiaryContainer: secondaryVariantDark,
      onTertiaryContainer: onSecondaryDark,
      error: errorDark,
      onError: onErrorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: textSecondaryDark,
      outline: borderDark,
      outlineVariant: dividerDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,

    // AppBar theme
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
        letterSpacing: 0.15,
      ),
      iconTheme: const IconThemeData(
        color: onSurfaceDark,
        size: 24,
      ),
    ),

    // Card theme
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),

    // Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: textSecondaryDark,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryDark,
      foregroundColor: onSecondaryDark,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryDark,
        backgroundColor: primaryDark,
        elevation: 2.0,
        shadowColor: shadowDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(88, 48),
        side: const BorderSide(color: primaryDark, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(64, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),

    // Text theme
    textTheme: _buildTextTheme(isLight: false),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderDark, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: secondaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorDark, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorDark, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondaryDark,
      ),
      errorStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: errorDark,
      ),
      prefixIconColor: textSecondaryDark,
      suffixIconColor: textSecondaryDark,
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return textSecondaryDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark.withValues(alpha: 0.5);
        }
        return borderDark;
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryDark),
      side: const BorderSide(color: borderDark, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return borderDark;
      }),
    ),

    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: secondaryDark,
      linearTrackColor: borderDark,
      circularTrackColor: borderDark,
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryDark,
      thumbColor: secondaryDark,
      overlayColor: secondaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: borderDark,
      valueIndicatorColor: primaryDark,
      valueIndicatorTextStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: onPrimaryDark,
      ),
    ),

    // Tab bar theme
    tabBarTheme: TabBarThemeData(
      labelColor: primaryDark,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: secondaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: onSurfaceDark,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Snackbar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: onSurfaceDark,
      ),
      actionTextColor: secondaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
    ),

    // Bottom sheet theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceDark,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      backgroundColor: dialogDark,
      elevation: 4.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimaryDark,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimaryDark,
      ),
    ),
  );

  /// Helper method to build text theme based on brightness
  /// Uses Inter for body text and captions, with Space Grotesk replaced by Inter for headings
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;

    return TextTheme(
      // Display styles - Large headings (using Inter instead of Space Grotesk)
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Section headers (using Inter with bold weight)
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Card headers and list items
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Main content text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Buttons and small text
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Animation durations following design specifications
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 400);

  /// Animation curves
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;

  /// Border radius values
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;

  /// Elevation values (subtle as per aerospace minimalism)
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;

  /// Spacing values
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  /// Touch target sizes (optimized for aviation professionals)
  static const double minTouchTarget = 44.0;
  static const double emergencyTouchTarget = 56.0;
}


/// A class that contains all theme configurations for the aviation safety reporting application.
class AppTheme {
  AppTheme._();

  // Aviation-themed color palette - Institutional Night Operations
  // Primary colors
  static const Color primaryLight =
      Color(0xFF0A1A3A); // Deep institutional blue
  static const Color primaryVariantLight =
      Color(0xFF0056B3); // Supporting institutional blue
  static const Color secondaryLight =
      Color(0xFF00C6FF); // Strategic cyan accent
  static const Color secondaryVariantLight = Color(0xFF0056B3);
  static const Color backgroundLight = Color(0xFF0F1B2F); // Primary background
  static const Color surfaceLight = Color(0xFF1A2B4A); // Elevated surface
  static const Color errorLight = Color(0xFFFF4757); // Prohibition red
  static const Color onPrimaryLight = Color(0xFFF8FAFC); // High contrast white
  static const Color onSecondaryLight = Color(0xFF0A1A3A);
  static const Color onBackgroundLight = Color(0xFFF8FAFC);
  static const Color onSurfaceLight = Color(0xFFF8FAFC);
  static const Color onErrorLight = Color(0xFFF8FAFC);

  // Dark theme colors (optimized for OLED displays)
  static const Color primaryDark = Color(0xFF0A1A3A);
  static const Color primaryVariantDark = Color(0xFF0056B3);
  static const Color secondaryDark = Color(0xFF00C6FF);
  static const Color secondaryVariantDark = Color(0xFF0056B3);
  static const Color backgroundDark = Color(0xFF0F1B2F);
  static const Color surfaceDark = Color(0xFF1A2B4A);
  static const Color errorDark = Color(0xFFFF4757);
  static const Color onPrimaryDark = Color(0xFFF8FAFC);
  static const Color onSecondaryDark = Color(0xFF0A1A3A);
  static const Color onBackgroundDark = Color(0xFFF8FAFC);
  static const Color onSurfaceDark = Color(0xFFF8FAFC);
  static const Color onErrorDark = Color(0xFFF8FAFC);

  // Semantic colors
  static const Color successColor = Color(0xFF00D95A); // Radar green
  static const Color warningColor = Color(0xFFFFB347); // Runway orange
  static const Color neutralColor =
      Color(0xFF2A4A80); // Balanced cold blue-gray

  // Card and dialog colors
  static const Color cardLight = Color(0xFF1A2B4A);
  static const Color cardDark = Color(0xFF1A2B4A);
  static const Color dialogLight = Color(0xFF1A2B4A);
  static const Color dialogDark = Color(0xFF1A2B4A);

  // Shadow colors with cyan tint (20% opacity)
  static const Color shadowLight = Color(0x3300C6FF);
  static const Color shadowDark = Color(0x3300C6FF);

  // Divider colors (10% opacity)
  static const Color dividerLight = Color(0x1AF8FAFC);
  static const Color dividerDark = Color(0x1AF8FAFC);

  // Text colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(0xFFF8FAFC); // 100% opacity
  static const Color textMediumEmphasisLight = Color(0x99F8FAFC); // 60% opacity
  static const Color textDisabledLight = Color(0x61F8FAFC); // 38% opacity

  static const Color textHighEmphasisDark = Color(0xFFF8FAFC);
  static const Color textMediumEmphasisDark = Color(0x99F8FAFC);
  static const Color textDisabledDark = Color(0x61F8FAFC);

  /// Light theme (optimized for aviation professional credibility)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness
        .dark, // Using dark brightness for institutional night operations
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      secondaryContainer: secondaryVariantLight,
      onSecondaryContainer: onSecondaryLight,
      tertiary: secondaryLight,
      onTertiary: onSecondaryLight,
      tertiaryContainer: secondaryVariantLight,
      onTertiaryContainer: onSecondaryLight,
      error: errorLight,
      onError: onErrorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: textMediumEmphasisLight,
      outline: dividerLight,
      outlineVariant: dividerLight,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: onSurfaceLight,
      elevation: 0,
      shadowColor: shadowLight,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onSurfaceLight,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: dividerLight, width: 1.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: secondaryLight,
      unselectedItemColor: textMediumEmphasisLight,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryLight,
      foregroundColor: onSecondaryLight,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(
            color: secondaryLight.withValues(alpha: 0.5), width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorLight, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return neutralColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight.withValues(alpha: 0.5);
        }
        return neutralColor.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryLight),
      side: BorderSide(color: dividerLight, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryLight;
        }
        return neutralColor;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondaryLight,
      linearTrackColor: neutralColor.withValues(alpha: 0.3),
      circularTrackColor: neutralColor.withValues(alpha: 0.3),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryLight,
      thumbColor: secondaryLight,
      overlayColor: secondaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: neutralColor.withValues(alpha: 0.3),
      valueIndicatorColor: secondaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onSecondaryLight,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: secondaryLight,
      unselectedLabelColor: textMediumEmphasisLight,
      indicatorColor: secondaryLight,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        color: backgroundLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceLight,
      contentTextStyle: GoogleFonts.inter(
        color: textHighEmphasisLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: secondaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8.0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: dialogLight,
      elevation: 8.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisLight,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisLight,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceLight,
      elevation: 8.0,
      shadowColor: shadowLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),
  );

  /// Dark theme (identical to light for consistent night operations)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryVariantDark,
      onSecondaryContainer: onSecondaryDark,
      tertiary: secondaryDark,
      onTertiary: onSecondaryDark,
      tertiaryContainer: secondaryVariantDark,
      onTertiaryContainer: onSecondaryDark,
      error: errorDark,
      onError: onErrorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: textMediumEmphasisDark,
      outline: dividerDark,
      outlineVariant: dividerDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    appBarTheme: AppBarTheme(
      color: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      shadowColor: shadowDark,
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: onSurfaceDark,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: dividerDark, width: 1.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: secondaryDark,
      unselectedItemColor: textMediumEmphasisDark,
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondaryDark,
      foregroundColor: onSecondaryDark,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryDark,
        backgroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side:
            BorderSide(color: secondaryDark.withValues(alpha: 0.5), width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        minimumSize: const Size(88, 48),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: dividerDark, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondaryDark, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorDark, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorDark, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return neutralColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark.withValues(alpha: 0.5);
        }
        return neutralColor.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onSecondaryDark),
      side: BorderSide(color: dividerDark, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return secondaryDark;
        }
        return neutralColor;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: secondaryDark,
      linearTrackColor: neutralColor.withValues(alpha: 0.3),
      circularTrackColor: neutralColor.withValues(alpha: 0.3),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: secondaryDark,
      thumbColor: secondaryDark,
      overlayColor: secondaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: neutralColor.withValues(alpha: 0.3),
      valueIndicatorColor: secondaryDark,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onSecondaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: secondaryDark,
      unselectedLabelColor: textMediumEmphasisDark,
      indicatorColor: secondaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.25,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: GoogleFonts.inter(
        color: backgroundDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: textHighEmphasisDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: secondaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8.0,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: dialogDark,
      elevation: 8.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titleTextStyle: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textHighEmphasisDark,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasisDark,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surfaceDark,
      elevation: 8.0,
      shadowColor: shadowDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Space Grotesk for headings
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),

      // Headline styles - Space Grotesk for headings
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
      ),

      // Title styles - Space Grotesk for headings
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),

      // Body styles - Inter for body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
      ),

      // Label styles - Inter for captions
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textDisabled,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Helper method to get monospace text style for data display
  static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    final Color textColor =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      letterSpacing: 0,
    );
  }

  /// Animation duration constants
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 250);
  static const Duration slowAnimation = Duration(milliseconds: 300);

  /// Animation curves
  static const Curve defaultCurve = Curves.easeOut;
  static const Curve springCurve = Curves.easeInOut;

  /// Border radius constants
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;

  /// Elevation constants
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;

  /// Spacing constants
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  /// Touch target size (minimum 48dp for accessibility)
  static const double minTouchTarget = 48.0;
}
