import 'package:flutter/material.dart';
import 'package:hotel_app/style/common.dart';

ThemeData buildDarkTheme() {
  final ColorScheme colorScheme = ColorScheme.dark().copyWith(
    primary: CommonThemeBuilders.primaryColor,
    secondary: CommonThemeBuilders.primaryColor,
    surface: CommonThemeBuilders.sheetBG,
  );
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    colorScheme: colorScheme,
    chipTheme: CommonThemeBuilders.chipThemeData(colorScheme),
    inputDecorationTheme: CommonThemeBuilders.getTextFieldDecoration(),
    primaryColor: CommonThemeBuilders.primaryColor,
    scaffoldBackgroundColor: CommonThemeBuilders.scaffoldBackgroundColor,
    canvasColor: Colors.transparent, // Make the canvas color transparent
    buttonTheme: CommonThemeBuilders.buttonThemeData(colorScheme),
    textButtonTheme: CommonThemeBuilders.textButtonThemeData(colorScheme),
    outlinedButtonTheme: CommonThemeBuilders.outLinedButtonThemeData(
      colorScheme,
    ),
    elevatedButtonTheme: CommonThemeBuilders.elevatedButtonThemeData(
      colorScheme,
    ),
    dialogTheme: CommonThemeBuilders.dialogTheme(),
    cardTheme: CommonThemeBuilders.cardTheme(),
    cardColor: CommonThemeBuilders.cardColor,
    textTheme: CommonThemeBuilders.buildTextTheme(base.textTheme),
    primaryTextTheme: CommonThemeBuilders.buildTextTheme(base.textTheme),
    // platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: CommonThemeBuilders.secondaryTextColor,
    progressIndicatorTheme: CommonThemeBuilders.progressIndicatorThemeData(),
    checkboxTheme: CommonThemeBuilders.checkboxThemeData(colorScheme),
    dividerTheme: DividerThemeData(
      color: CommonThemeBuilders.secondaryTextColor.withOpacity(.4),
    ),
  );
}

ThemeData buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: CommonThemeBuilders.primaryColor,
    secondary: CommonThemeBuilders.primaryColor,
    surface: CommonThemeBuilders.backgroundColor,
  );
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: colorScheme,
    progressIndicatorTheme: CommonThemeBuilders.progressIndicatorThemeData(),

    primaryIconTheme: CommonThemeBuilders.iconThemeData(colorScheme),
    iconButtonTheme: CommonThemeBuilders.iconButtonThemeData(colorScheme),
    iconTheme: CommonThemeBuilders.iconThemeData(colorScheme),
    chipTheme: CommonThemeBuilders.chipThemeData(colorScheme),
    inputDecorationTheme: CommonThemeBuilders.getTextFieldDecoration(),
    primaryColor: CommonThemeBuilders.primaryColor,
    scaffoldBackgroundColor: CommonThemeBuilders.scaffoldBackgroundColor,
    canvasColor: Colors.transparent, // Make the canvas color transparent
    buttonTheme: CommonThemeBuilders.buttonThemeData(colorScheme),
    textButtonTheme: CommonThemeBuilders.textButtonThemeData(colorScheme),
    outlinedButtonTheme: CommonThemeBuilders.outLinedButtonThemeData(
      colorScheme,
    ),
    elevatedButtonTheme: CommonThemeBuilders.elevatedButtonThemeData(
      colorScheme,
    ),
    dialogTheme: CommonThemeBuilders.dialogTheme(),
    cardTheme: CommonThemeBuilders.cardTheme(),
    cardColor: CommonThemeBuilders.cardColor,
    textTheme: CommonThemeBuilders.buildTextTheme(base.textTheme),
    primaryTextTheme: CommonThemeBuilders.buildTextTheme(base.textTheme),
    // platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: CommonThemeBuilders.secondaryTextColor,
    dividerTheme: DividerThemeData(
      color: CommonThemeBuilders.secondaryTextColor.withOpacity(.4),
    ),
  );
}
