import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A repository class for handling language-related operations.
class LanugageRepo {
  /// Retrieves the current device language.
  ///
  /// Returns a [Future] that completes with the current locale as a [String],
  /// or null if the locale couldn't be determined.
  Future<String?> getLanguageFromDevice() async {
    return await Devicelocale.currentLocale;
  }

  /// Retrieves the language stored in SharedPreferences.
  ///
  /// Returns a [Future] that completes with the stored language as a [String],
  /// or null if no language is stored.
  Future<String?> getSharedPrefLanguage() async {
    final sp = await SharedPreferences.getInstance();

    return sp.getString('language');
  }

  /// Stores the given language in SharedPreferences.
  ///
  /// [language] is the language code to be stored.
  ///
  /// Returns a [Future] that completes when the operation is done.
  Future<void> setSharedPrefLanguage(String language) async {
    final sp = await SharedPreferences.getInstance();

    sp.setString('language', language);
  }
}
