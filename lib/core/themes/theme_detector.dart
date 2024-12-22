import 'dart:developer';

import 'package:flutter/material.dart';

class ThemeDetector {
  const ThemeDetector();

  static void init(BuildContext context) {
    try {
      _listen(context);
      View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
        _listen(context);
      };
    } catch (e) {
      return;
    }
  }

  static void _listen(context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDark = (brightness == Brightness.dark) ? false : true;

    log("_listen isDark :: $isDark");
    // BlocProvider.of<ThemeCubit>(context).setThemeData(isDark);
  }
}
