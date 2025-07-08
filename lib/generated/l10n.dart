// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hotel App`
  String get appName {
    return Intl.message('Hotel App', name: 'appName', desc: '', args: []);
  }

  /// `Search for world's hotels`
  String get searchBarTitle {
    return Intl.message(
      'Search for world\'s hotels',
      name: 'searchBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recommended hotels`
  String get recomandedHotelsTitle {
    return Intl.message(
      'Recommended hotels',
      name: 'recomandedHotelsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hotel added to favorites`
  String get hotelAddedToFavorites {
    return Intl.message(
      'Hotel added to favorites',
      name: 'hotelAddedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Hotel removed from favorites`
  String get hotelRemovedFromFavorites {
    return Intl.message(
      'Hotel removed from favorites',
      name: 'hotelRemovedFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `No hotels are found`
  String get notHotelsAreFound {
    return Intl.message(
      'No hotels are found',
      name: 'notHotelsAreFound',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Error loading data`
  String get errorLoadingData {
    return Intl.message(
      'Error loading data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `Search in your favorites`
  String get searchInYourFavorites {
    return Intl.message(
      'Search in your favorites',
      name: 'searchInYourFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Click on the heart to add to favorites`
  String get clickOnTheHeartToAddToFavorites {
    return Intl.message(
      'Click on the heart to add to favorites',
      name: 'clickOnTheHeartToAddToFavorites',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
