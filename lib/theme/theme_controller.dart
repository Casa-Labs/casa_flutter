import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/preference_manager.dart';

class ThemeController {
  static Future<void> toggleThemeMode() async {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      // Use PreferenceManager to store the theme preference
      await PreferenceManager.setData(PreferenceManager.keyIsDarkMode, false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      await PreferenceManager.setData(PreferenceManager.keyIsDarkMode, true);
    }
  }

  // Retrieve the preferred theme mode using PreferenceManager
  static ThemeMode prefThemeMode() {
    bool? isDarkMode =
        PreferenceManager.getBool(PreferenceManager.keyIsDarkMode);

    if (isDarkMode != null) {
      return isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
