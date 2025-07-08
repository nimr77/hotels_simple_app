import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaimon/gaimon.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/language/repo.dart';
import 'package:hotel_app/logic/language/supported_languages.dart';
import 'package:intl/date_symbol_data_local.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanugageRepo _repo = LanugageRepo();

  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageInitialized>(_onLanguageInitialized);
    on<LanguageChanged>(_onLanguageChanged);
  }

  /// Get the appropriate language for the app
  Future<({Locale locale, Languages language})> getAppLanguage() async {
    // Get saved language from shared preferences
    final sharedStrLanguage = await _repo.getSharedPrefLanguage();

    Locale initialLocale;
    Languages initialLanguage;

    if (sharedStrLanguage != null) {
      initialLocale = Locale(sharedStrLanguage);
      initialLanguage = Languages.fromLocale(initialLocale);
    } else {
      // Try to get language from device
      final deviceLanguage = await _repo.getLanguageFromDevice();

      if (deviceLanguage != null) {
        final hasName = deviceLanguage.contains('_');

        if (hasName) {
          final split = deviceLanguage.split('_');
          initialLocale = Locale(split[0], split[1]);
        } else {
          initialLocale = Locale(deviceLanguage);
        }
      } else {
        initialLocale = const Locale('en', 'US');
      }
      initialLanguage = Languages.fromLocale(initialLocale);
    }

    // Check if it's supported, fallback to English if not
    if (!LanguageInitial._supportedLocales.contains(initialLocale)) {
      initialLocale = const Locale('en', 'US');
      initialLanguage = Languages.english;
    }

    return (locale: initialLocale, language: initialLanguage);
  }

  /// Initialize language settings
  Future<void> init() async {
    // Get the appropriate language
    final languageData = await getAppLanguage();

    // Load the initial locale
    await S.load(languageData.locale);
    await initializeDateFormatting();
  }

  /// Change language
  void setLanguage(Languages language) {
    add(LanguageChanged(language));
  }

  Future<void> _onLanguageChanged(
    LanguageChanged event,
    Emitter<LanguageState> emit,
  ) async {
    // Check if the selected language is the same as current
    if (state.currentLanguage == event.language) {
      // Same language, no need to do anything
      return;
    }

    emit(
      LanguageLoading(
        currentLocale: state.currentLocale,
        currentLanguage: state.currentLanguage,
        supportedLocales: state.supportedLocales,
      ),
    );

    try {
      Gaimon.light();

      final newLocale = Locale(event.language.code);

      // Save language preference
      await _repo.setSharedPrefLanguage(event.language.code);

      // Load the new language
      await S.load(newLocale);
      await initializeDateFormatting();

      emit(
        LanguageLoaded(
          currentLocale: newLocale,
          currentLanguage: event.language,
          supportedLocales: state.supportedLocales,
        ),
      );
    } catch (e) {
      emit(
        LanguageError(
          currentLocale: state.currentLocale,
          currentLanguage: state.currentLanguage,
          supportedLocales: state.supportedLocales,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLanguageInitialized(
    LanguageInitialized event,
    Emitter<LanguageState> emit,
  ) async {
    // Language is already loaded in init(), just emit current state
    // This method is kept for compatibility but doesn't need to do anything
  }
}

class LanguageChanged extends LanguageEvent {
  final Languages language;
  LanguageChanged(this.language);
}

class LanguageError extends LanguageState {
  final String message;

  const LanguageError({
    required super.currentLocale,
    required super.currentLanguage,
    required super.supportedLocales,
    required this.message,
  }) : super(isLoading: false);
}

// Events
abstract class LanguageEvent {}

class LanguageInitial extends LanguageState {
  static final List<Locale> _supportedLocales = [
    ...Languages.values.map((e) => Locale(e.code)),
  ];

  LanguageInitial()
    : super(
        currentLocale: const Locale('en', 'US'),
        currentLanguage: Languages.english,
        supportedLocales: _supportedLocales,
      );
}

class LanguageInitialized extends LanguageEvent {}

class LanguageLoaded extends LanguageState {
  const LanguageLoaded({
    required super.currentLocale,
    required super.currentLanguage,
    required super.supportedLocales,
  }) : super(isLoading: false);
}

class LanguageLoading extends LanguageState {
  const LanguageLoading({
    required super.currentLocale,
    required super.currentLanguage,
    required super.supportedLocales,
  }) : super(isLoading: true);
}

// States
abstract class LanguageState {
  final Locale currentLocale;
  final Languages currentLanguage;
  final List<Locale> supportedLocales;
  final bool isLoading;

  const LanguageState({
    required this.currentLocale,
    required this.currentLanguage,
    required this.supportedLocales,
    this.isLoading = false,
  });
}
