import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeModeProvider extends ChangeNotifier {
  static const String _spKeyThemeMode = 'theme_mode';

  late ThemeData lighTheme;
  late ThemeData darkTheme;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    updateThemeMode(mode);
  }

  loadThemeModeFromSp() async {
    final sp = await SharedPreferences.getInstance();
    final themeModeIndex = sp.getInt(_spKeyThemeMode);
    if (themeModeIndex != null) {
      _themeMode = ThemeMode.values[themeModeIndex];
    }
    notifyListeners();
  }

  saveThemeModeToSp() async {
    final sp = await SharedPreferences.getInstance();
    sp.setInt(_spKeyThemeMode, _themeMode.index);
  }

  ThemeData themeData(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return lighTheme;
      case ThemeMode.dark:
        return darkTheme;
      default:
        return MediaQuery.of(context).platformBrightness == Brightness.dark
            ? darkTheme
            : lighTheme;
    }
  }

  updateThemeMode(ThemeMode mode) {
    _themeMode = mode;
    saveThemeModeToSp();
    notifyListeners();
  }
}
