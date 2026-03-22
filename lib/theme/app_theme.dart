import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF111214);
  static const surfaceVariant = Color(0xFF1C1C1E);
  static const divider = Color(0xFF121214);
  static const hint = Color(0xFF8E8E93);
  static const accent = Color(0xFF2D8CFF);
  static const danger = Color(0xFFFE3B30);
  static const bubbleMe = Color(0xFF1F5086);
  static const bubbleOther = Color(0xFF1C1C1E);
  static const unreadBg = Color(0xFF2C2C2E);
  static const avatarFallback = Color(0xFF2A2B2E);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.surface,
          onSurface: Colors.white,
          secondary: AppColors.hint,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 56,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: AppColors.accent),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 0.8,
          space: 0,
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: AppColors.surfaceVariant,
          selectedColor: AppColors.accent,
          secondarySelectedColor: AppColors.accent,
          labelStyle: TextStyle(fontSize: 13, color: AppColors.hint),
          secondaryLabelStyle: TextStyle(fontSize: 13, color: Colors.white),
          side: BorderSide.none,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColors.hint,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: TextStyle(fontSize: 11),
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.hint, fontSize: 14),
        ),
      );
}
