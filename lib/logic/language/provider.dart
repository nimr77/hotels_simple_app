/// A provider class for managing language-related functionality in the application.
///
/// This class handles language selection, initialization, and persistence of language preferences.
library;

import 'package:flutter/widgets.dart';
import 'package:gaimon/gaimon.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/language/repo.dart';
import 'package:hotel_app/logic/language/supported_languages.dart';
import 'package:intl/date_symbol_data_local.dart';

class LanguageProvider extends ChangeNotifier {
  /// Repository for language-related operations.
  final repo = LanugageRepo();

  /// The current locale of the application.
  Locale currentLocal = const Locale('en', 'US');

  /// Notifier for the current language.
  final languageNotifier = ValueNotifier<Languages>(Languages.english);

  /// List of supported locales in the application.
  List<Locale> supportedLocales = [
    ...Languages.values.map((e) => Locale(e.code)),
  ];

  /// Initializes the language settings for the application.
  ///
  /// This method attempts to load the language preference from shared preferences,
  /// falls back to the device language if not found, and ensures the selected
  /// language is supported.
  Future<void> init() async {
    // get device language

    final sharedStrLanugage = await repo.getSharedPrefLanguage();

    if (sharedStrLanugage != null) {
      currentLocal = Locale(sharedStrLanugage);
    } else {
      // try to get the lanugage from device
      // if not found then set to default

      final deviceLanguage = await repo.getLanguageFromDevice();

      if (deviceLanguage != null) {
        final hasName = deviceLanguage.contains('_');

        if (hasName) {
          final split = deviceLanguage.split('_');
          currentLocal = Locale(split[0], split[1]);
        } else {
          currentLocal = Locale(deviceLanguage);
        }
      }
    }

    // check if its supported
    if (!supportedLocales.contains(currentLocal)) {
      currentLocal = const Locale('en', 'US');
    }

    languageNotifier.value = Languages.fromLocale(currentLocal);
    await load();
  }

  /// Loads the selected language and initializes date formatting.
  ///
  /// This method should be called after changing the language or during initialization.
  Future<void> load() async {
    await S.load(currentLocal);
    await initializeDateFormatting();

    notifyListeners();
  }

  /// Sets a new language for the application.
  ///
  /// This method updates the language, saves the preference, and reloads the app's localization.
  ///
  /// [language]: The new language to set.
  void setLanguage(Languages language) async {
    Gaimon.light();
    languageNotifier.value = language;
    currentLocal = Locale(language.code);

    await repo.setSharedPrefLanguage(language.code);

    await load();
  }
}
