import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/colors/app_colors.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  AppTheme() {
    _initializeThemeMode();
    _listenToPlatformBrightnessChanges();
  }

  // Initialize theme mode based on saved preference or platform mode
  Future<void> _initializeThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString('themeMode');
    if (savedThemeMode == null) {
      _themeMode =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
    } else {
      _themeMode = savedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  // Save theme mode to shared preferences
  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  // Listen to system-wide brightness changes
  void _listenToPlatformBrightnessChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      final platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _themeMode = platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
      _saveThemeMode(); // Optionally save the new mode
      notifyListeners();
    };
  }

  void setLightTheme() {
    _themeMode = ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  void setDarkTheme() {
    _themeMode = ThemeMode.dark;
    _saveThemeMode();
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode();
    notifyListeners();
  }

  static get lightTheme => ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.black,
          onPrimary: AppColors.black,
          secondary: AppColors.translucent,
          onSecondary: AppColors.translucent,
          error: Colors.red,
          onError: Colors.red,
          surface: AppColors.white,
          onSurface: AppColors.white,
        ),
        textTheme: TextTheme(
          titleLarge: titleLargeLight,
          titleMedium: titleMediumLight,
          labelLarge: labelLargeLight,
          labelMedium: labelMediumLight,
          headlineLarge: headlineLargeLight,
          headlineSmall: headlineSmallLight,
        ),
      );

  static get headlineLargeLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 96.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get headlineSmallLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 36.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleLargeLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.translucent,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleMediumLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.translucent,
        fontSize: 10.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get labelLargeLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get labelMediumLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get darkTheme => ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.white,
          onPrimary: AppColors.white,
          secondary: AppColors.translucent,
          onSecondary: AppColors.translucent,
          error: Colors.red,
          onError: Colors.red,
          surface: AppColors.black,
          onSurface: AppColors.black,
        ),
        textTheme: TextTheme(
          titleLarge: titleLargeDark,
          titleMedium: titleMediumDark,
          labelLarge: labelLargeDark,
          labelMedium: labelMediumDark,
          headlineLarge: headlineLargeDark,
          headlineSmall: headlineSmallDark,
        ),
      );

  static get headlineSmallDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 36.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get headlineLargeDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      );

  static get titleLargeDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.translucent,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleMediumDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.translucent,
        fontSize: 10.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get labelLargeDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get labelMediumDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );
}
