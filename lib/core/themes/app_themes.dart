import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/colors/app_colors.dart';
import 'package:weather/injection_container.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  String _selectedTheme = '';
  String get selectedTheme => _selectedTheme;
  final SharedPreferences prefs = locator();

  AppTheme() {
    _initializeThemeMode();
    _listenToPlatformBrightnessChanges();
  }

  // Initialize theme mode based on saved preference or platform mode
  Future<void> _initializeThemeMode() async {
    final savedThemeMode = prefs.getString('themeMode');
    if (savedThemeMode == null) {
      _themeMode =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light;
      _updateStatusBar(
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark
              ? Brightness.light
              : Brightness.dark);
      _selectedTheme = 'system';
    } else {
      _selectedTheme = savedThemeMode;
      _themeMode = savedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _updateStatusBar(
          savedThemeMode == 'dark' ? Brightness.light : Brightness.dark);
    }

    notifyListeners();
  }

  void setThemeBaseOnsystem() async {
    _themeMode =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;
    _updateStatusBar(
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? Brightness.light
            : Brightness.dark);

    prefs.remove('themeMode');
    _listenToPlatformBrightnessChanges();
    _selectedTheme = 'system';
    notifyListeners();
  }

  // Save theme mode to shared preferences
  Future<void> _saveThemeMode() async {
    await prefs.setString(
        'themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  // Listen to system-wide brightness changes
  void _listenToPlatformBrightnessChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      final platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;

      final savedThemeMode = prefs.getString('themeMode');
      if (savedThemeMode == null) {
        _themeMode = platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light;

        _updateStatusBar(platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
        notifyListeners();
      }
    };
  }

  void setLightTheme() {
    _themeMode = ThemeMode.light;
    _saveThemeMode();
    _updateStatusBar(Brightness.dark);
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        null;
    _selectedTheme = 'light';
    notifyListeners();
  }

  void setDarkTheme() {
    _themeMode = ThemeMode.dark;
    _saveThemeMode();
    _updateStatusBar(Brightness.light);
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        null;
    _selectedTheme = 'dark';
    notifyListeners();
  }

  // void toggleTheme() {
  //   _themeMode =
  //       _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  //   _saveThemeMode();
  //   notifyListeners();
  // }

  void _updateStatusBar(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness:
            brightness, // Dark icons for light theme, and vice versa
        statusBarBrightness:
            brightness, // This affects the overall status bar color brightness
      ),
    );
  }

  static get lightTheme => ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.black,
          onPrimary: AppColors.black,
          secondary: AppColors.darkGray,
          onSecondary: AppColors.darkGray,
          error: Colors.red,
          onError: Colors.red,
          surface: AppColors.white,
          onSurface: AppColors.white,
        ),
        textTheme: TextTheme(
          titleLarge: titleLargeLight,
          titleMedium: titleMediumLight,
          titleSmall: titleSmallLight,
          labelLarge: labelLargeLight,
          labelMedium: labelMediumLight,
          labelSmall: labelSmallLight,
          headlineLarge: headlineLargeLight,
          headlineSmall: headlineSmallLight,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: labelStyleLight,
          hintStyle: hintStyleLight,
        ),
      );

  static get hintStyleLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.darkGray,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );
  static get labelStyleLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleSmallLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.darkGray,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get labelSmallLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
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
        color: AppColors.darkGray,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleMediumLight => GoogleFonts.ubuntuCondensed(
        color: AppColors.darkGray,
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
          secondary: AppColors.lightGray,
          onSecondary: AppColors.lightGray,
          error: Colors.red,
          onError: Colors.red,
          surface: AppColors.black,
          onSurface: AppColors.black,
        ),
        textTheme: TextTheme(
          titleLarge: titleLargeDark,
          titleMedium: titleMediumDark,
          titleSmall: titleSmallDark,
          labelLarge: labelLargeDark,
          labelMedium: labelMediumDark,
          labelSmall: labelSmallDark,
          headlineLarge: headlineLargeDark,
          headlineSmall: headlineSmallDark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: labelStyleDark,
          hintStyle: hintStyleDark,
        ),
      );
  static get hintStyleDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.lightGray,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );
  static get labelStyleDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
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
        color: AppColors.lightGray,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleMediumDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.lightGray,
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

  static get labelSmallDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );

  static get titleSmallDark => GoogleFonts.ubuntuCondensed(
        color: AppColors.lightGray,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
      );
}
