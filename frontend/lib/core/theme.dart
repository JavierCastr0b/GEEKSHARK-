import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Navy
  static const navy900 = Color(0xFF060D1C);
  static const navy800 = Color(0xFF0B1628);
  static const navy700 = Color(0xFF0F2038);
  static const navy600 = Color(0xFF152B4E);
  static const navy500 = Color(0xFF1E3A6E);
  static const navy400 = Color(0xFF2D5490);
  static const navy300 = Color(0xFF4A72B0);

  // Accent Cyan
  static const cyan = Color(0xFF00C9E8);
  static const cyanDark = Color(0xFF009CB3);
  static const cyanLight = Color(0xFFCCF3FA);

  // Success Green
  static const green = Color(0xFF00C896);
  static const greenDark = Color(0xFF009971);
  static const greenLight = Color(0xFFCCF4EC);
  static const greenBg = Color(0xFFE6FBF5);

  // Warning Amber
  static const amber = Color(0xFFFFB134);
  static const amberLight = Color(0xFFFFF4DC);

  // Error Red
  static const red = Color(0xFFFF4B6B);
  static const redLight = Color(0xFFFFECF0);

  // Purple accent
  static const purple = Color(0xFF7C3AED);
  static const purpleLight = Color(0xFFEDE9FE);

  // Orange
  static const orange = Color(0xFFFF7A35);
  static const orangeLight = Color(0xFFFFEEE5);

  // Neutrals
  static const white = Color(0xFFFFFFFF);
  static const gray50 = Color(0xFFF7F9FF);
  static const gray100 = Color(0xFFEEF2FB);
  static const gray200 = Color(0xFFDDE5F5);
  static const gray300 = Color(0xFFC2D0E8);
  static const gray400 = Color(0xFF8FA5C8);
  static const gray500 = Color(0xFF6B85A8);
  static const gray600 = Color(0xFF4F6589);
  static const gray700 = Color(0xFF384D6E);
  static const gray800 = Color(0xFF243652);
  static const gray900 = Color(0xFF152137);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.navy500,
        onPrimary: AppColors.white,
        secondary: AppColors.cyan,
        onSecondary: AppColors.navy900,
        tertiary: AppColors.green,
        onTertiary: AppColors.white,
        error: AppColors.red,
        onError: AppColors.white,
        surface: AppColors.gray50,
        onSurface: AppColors.gray900,
        surfaceContainerHighest: AppColors.gray100,
        outline: AppColors.gray200,
      ),
      scaffoldBackgroundColor: AppColors.gray50,
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cyan, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.gray400,
        ),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColors.gray500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy500,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy500,
          side: const BorderSide(color: AppColors.gray200, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.gray100,
        thickness: 1,
        space: 0,
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.navy800,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.navy800,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.navy800,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.navy800,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.navy800,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.navy800,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.gray800,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gray800,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.gray700,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.gray700,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.gray600,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.gray500,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gray800,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray700,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.gray600,
      ),
    );
  }
}

// Gradient helpers
class AppGradients {
  static const navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.navy600, AppColors.navy800],
  );

  static const navyDeepGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.navy500, AppColors.navy900],
  );

  static const cyanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.cyan, Color(0xFF0099BB)],
  );

  static const greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.green, AppColors.greenDark],
  );

  static const purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.purple, Color(0xFF5B21B6)],
  );

  static const orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.orange, Color(0xFFCC5522)],
  );

  static const amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.amber, Color(0xFFCC8800)],
  );
}
