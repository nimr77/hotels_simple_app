import 'package:flutter/widgets.dart';

enum Languages {
  english,
  spanish,
  french
  // italian,
  // portuguese,
  // german,
  // russian
  // chinese,
  // japanese,
  // korean,
  // arabic
  ;

  static Map<Languages, String> get languageMap => {
    Languages.english: 'en',
    Languages.spanish: 'es',
    Languages.french: 'fr',
    // Languages.italian: 'it',
    // Languages.portuguese: 'pt',
    // Languages.german: 'de',
    // Languages.russian: 'ru',
    // Languages.chinese: 'zh',
    // Languages.japanese: 'ja',
    // Languages.korean: 'ko',
    // Languages.arabic: 'ar',
  };

  static Map<Languages, String> get namesInLocal => {
    Languages.english: 'English',
    Languages.spanish: 'Español',
    Languages.french: 'Français',
    // Languages.italian: 'Italiano',
    // Languages.portuguese: 'Português',
    // Languages.german: 'Deutsche',
    // Languages.russian: 'русский',
    // Languages.chinese: '中文',
    // Languages.japanese: '日本語',
    // Languages.korean: '한국어',
    // Languages.arabic: 'عربى',
  };

  String get code => languageMap[this] ?? 'en';

  String get name => namesInLocal[this] ?? 'Unknown';

  static Languages fromLocale(Locale locale) {
    final code = locale.languageCode;

    final lang = languageMap.entries.firstWhere(
      (element) => element.value == code,
      orElse: () => const MapEntry(Languages.english, 'en'),
    );

    return lang.key;
  }
}
