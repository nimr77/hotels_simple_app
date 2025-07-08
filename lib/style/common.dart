import 'package:flutter/material.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/style/font_size.dart';

BorderRadius get appBorders => const BorderRadius.all(Radius.circular(16.0));
BorderRadius get buttonBorderRaduis => BorderRadius.all(innerCardRadius);
Radius get buttonRaduis => const Radius.circular(20);
double get cardRadiusValue => isTablet ? 20 : 18;
Radius get innerCardRadius => outterCardRadius * 0.65;

BorderRadius get inputBorderRaduis => BorderRadius.circular(10);

bool get isDarkMode => !CommonThemeBuilders.isLightMode;

double get minimHeight => 40;
Radius get outterCardRadius => Radius.circular(cardRadiusValue);

class CommonThemeBuilders {
  static late BuildContext context;
  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : blackColorBackGround;

  static Color get blackColorBackGround => const Color.fromARGB(255, 15, 12, 0);

  static BoxDecoration get boxDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.all(outterCardRadius),
    border: isLightMode ? Border.all(color: Colors.grey.shade300) : null,

    // boxShadow: <BoxShadow>[
    //   if (isLightMode)
    //     BoxShadow(
    //       color: Theme.of(mainNavigationKey.currentContext!)
    //           .dividerColor
    //           .withOpacity(0.3),
    //       //   offset: Offset(2, 2),
    //       blurRadius: 20,
    //       spreadRadius: 0,
    //     ),
    // ],
  );
  static BoxDecoration get boxDecorationTap => BoxDecoration(
    color: cardColorTap,
    borderRadius: BorderRadius.all(outterCardRadius),
    border: isLightMode ? Border.all(color: Colors.grey.shade300) : null,
  );

  static BoxDecoration get boxDecorationView => BoxDecoration(
    color: cardColorView,
    borderRadius: BorderRadius.all(outterCardRadius),
    border: isLightMode ? Border.all(color: Colors.grey.shade300) : null,
  );
  static BoxDecoration get buttomSheetDecoration => BoxDecoration(
    color: (isDarkMode ? inputFillColor : Colors.grey.shade100).withOpacity(1),
    boxShadow: [
      if (isLightMode)
        BoxShadow(
          color: Theme.of(context).shadowColor.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 40,
          offset: const Offset(0, -1),
        ),
    ],
    borderRadius: buttomSheetRadius,
  );

  static BorderRadius get buttomSheetRadius =>
      BorderRadius.vertical(top: (outterCardRadius * (isTablet ? 1.5 : 0.8)));
  static BorderRadius get buttomSheetRadiusNavigator =>
      BorderRadius.all((outterCardRadius * 1.6));

  static BoxDecoration get buttonDecoration => BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.all(buttonRaduis),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(mainNavigationKey.currentContext!).dividerColor,
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );
  static Color get cardColor =>
      (isLightMode ? Colors.white : cardDarkColor).withAlpha(150);

  static Color get cardColorDarker => const Color.fromARGB(255, 33, 29, 35);

  static Color get cardColorTap => (inputFillColor).withAlpha(150);
  static Color get cardColorView =>
      (isLightMode ? Colors.white : cardDarkColor).withAlpha(150);

  // static Color get cardDarkColor => const Color.fromARGB(255, 30, 28, 33);
  static Color get cardDarkColor => const Color.fromARGB(255, 44, 44, 44);

  static Color get cardLoadingColor =>
      isLightMode ? Colors.grey[50]! : const Color.fromARGB(255, 17, 0, 10);

  static Color get fontcolor => isLightMode
      ? const Color.fromARGB(255, 26, 26, 26)
      : const Color.fromARGB(255, 255, 255, 255);

  static String get fontFamily => 'Zain';

  static Color get inputFillColor =>
      (isDarkMode
              ? const Color.fromARGB(255, 25, 25, 25)
              : const Color.fromARGB(255, 252, 252, 252))
          .withAlpha(150);

  static Color get inputFillColorFocus => isDarkMode
      ? const Color.fromARGB(255, 55, 55, 55)
      : const Color.fromARGB(255, 250, 250, 250);

  static bool get isLightMode {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness != Brightness.dark;

    // return true;
  }

  static BoxDecoration get mapCardDecoration => BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.all(buttonRaduis),
    border: isLightMode ? Border.all(color: Colors.grey.shade300) : null,
  );

  static Color get paymentButtonColor => primaryColor;

  // colors
  static Color get primaryColor {
    return const Color(0xFFFDB614);
  }

  // static Color get primaryColor {
  //   return const Color.fromARGB(255, 146, 0, 204);
  // }

  static Color get primaryTextColor => isLightMode
      ? const Color.fromARGB(255, 16, 9, 0)
      : const Color(0xFFFFFFFF);
  static Color get redErrorColor =>
      isLightMode ? const Color(0xFFF03738) : const Color(0xFFF03738);

  static Color get scaffoldBackgroundColor => backgroundColor;

  static get searchBarDecoration => BoxDecoration(
    color: scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(38)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Theme.of(mainNavigationKey.currentContext!).dividerColor,
        blurRadius: 8,
        // offset: Offset(4, 4),
      ),
    ],
  );

  static Color get seccondaryColor {
    //013047ff
    return const Color.fromARGB(255, 1, 48, 71);
  }

  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get secoundryColor {
    return isDarkMode
        ? const Color.fromARGB(255, 3, 173, 45)
        : const Color.fromARGB(255, 1, 34, 10);
  }

  static Color get sheetBG => isDarkMode
      ? (isTablet
            ? const Color.fromARGB(255, 1, 1, 1)
            : const Color.fromARGB(255, 26, 24, 27))
      : backgroundColor;

  static Color get shimmerColor => isLightMode
      ? const Color.fromARGB(255, 217, 217, 217)
      : const Color(0xFF4D4D4D);

  // static Color get suerfaceColor => isDarkMode
  //     ? const Color.fromARGB(255, 26, 26, 26)
  //     : const Color(0xFFFFFFFF);

  static Color get suerfaceColor => isDarkMode
      ? const Color.fromARGB(255, 22, 15, 2)
      : const Color(0xFFFFFFFF);

  static Color get textButtonColor => primaryColor;

  static Color get whiteColor => const Color(0xFFFFFFFF);

  static TextTheme buildTextTheme(TextTheme base) {
    // FontFamilyType fontType = applicationcontext == null ? FontFamilyType.WorkSans : applicationcontext!.read<ThemeProvider>().fontType;
    // FontFamilyType fontType = FontFamilyType.WorkSans;
    return base.copyWith(
      displayLarge: getTextStyle(
        base.displayLarge!,
      ).copyWith(color: fontcolor), //f-size 96
      displayMedium: getTextStyle(
        base.displayMedium!,
      ).copyWith(color: fontcolor), //f-size 60

      displaySmall: getTextStyle(base.displaySmall!).copyWith(color: fontcolor),
      headlineMedium: getTextStyle(
        base.headlineMedium!,
      ).copyWith(color: fontcolor),
      headlineSmall: getTextStyle(base.headlineSmall!).copyWith(
        color: fontcolor,
        fontSize: isTablet ? 18 : 22,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: getTextStyle(
        base.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: fontcolor,
          fontSize: isTablet ? 18 : 20,
        ),
      ), //f-size 20
      labelLarge: getTextStyle(
        base.labelLarge!,
      ).copyWith(fontSize: 22, color: fontcolor),

      bodySmall: getTextStyle(
        base.bodySmall!,
      ).copyWith(color: fontcolor, fontSize: 18),
      bodyLarge: getTextStyle(
        base.bodyLarge!,
      ).copyWith(color: fontcolor, fontSize: 22),
      bodyMedium: getTextStyle(
        base.bodyMedium!,
      ).copyWith(color: fontcolor, fontSize: 20),
      labelMedium: getTextStyle(
        base.labelMedium!.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: fontcolor,
        ),
      ),

      titleMedium: getTextStyle(
        base.titleMedium!.copyWith(
          color: fontcolor,
          fontSize: isTablet ? 16 : 19,
        ),
      ), //f-size 16
      titleSmall: getTextStyle(
        base.titleSmall!,
      ).copyWith(color: fontcolor, fontSize: 18),
      labelSmall: getTextStyle(base.labelSmall!).copyWith(
        color: primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static ButtonThemeData buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static CardThemeData cardTheme() {
    return CardThemeData(
      clipBehavior: Clip.antiAlias,
      color: cardColorView,
      surfaceTintColor: Colors.transparent,
      shadowColor: secondaryTextColor.withOpacity(0.07),
      shape: RoundedRectangleBorder(borderRadius: appBorders),
      elevation: isDarkMode ? 0 : 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static CheckboxThemeData checkboxThemeData(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary;
        }
        return colorScheme.surface;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return colorScheme.onSurface;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary.withOpacity(0.2);
        }
        return colorScheme.surface.withOpacity(0.2);
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    );
  }

  static ChipThemeData chipThemeData(ColorScheme colorScheme) {
    return ChipThemeData(
      elevation: 1.5,
      checkmarkColor: whiteColor,
      color: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary;
        }
        return colorScheme.surface;
      }),
      backgroundColor: Colors.transparent,
      disabledColor: primaryColor.withOpacity(0.1),
      selectedColor: primaryColor.withOpacity(0.1),
      secondarySelectedColor: primaryColor.withOpacity(0.9),
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      labelStyle: getTextStyle(
        TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: !isDarkMode ? Colors.black87 : Colors.white,
        ),
      ),
      secondaryLabelStyle: getTextStyle(
        TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: !isDarkMode ? Colors.white : Colors.white,
        ),
      ),
    );
  }

  static DialogThemeData dialogTheme() {
    return DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData(
    ColorScheme colorScheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        minimumSize: Size(0, minimHeight),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        textStyle: getTextStyle(
          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: buttonBorderRaduis),
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonThemeDataMain(
    ColorScheme colorScheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        minimumSize: const Size(0, 45),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        textStyle: getTextStyle(
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: buttonBorderRaduis),
      ),
    );
  }

  static InputDecorationTheme getTextFieldDecoration() {
    return InputDecorationTheme(
      focusColor: CommonThemeBuilders.inputFillColorFocus,
      // labelStyle: const TextStyle(fontSize: 10),
      filled: true,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(outterCardRadius),
        borderSide: BorderSide(
          color: isLightMode ? Colors.grey.shade300 : Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(innerCardRadius),
        borderSide: BorderSide(
          color: isLightMode
              ? Colors.grey.shade300
              : CommonThemeBuilders.cardDarkColor.withOpacity(0),
        ),
      ),
      fillColor: CommonThemeBuilders.inputFillColor,
      // filled: true,
      // fillColor: scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      floatingLabelStyle: getTextStyle(
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: fontcolor),
      ),
      labelStyle: getTextStyle(
        TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: fontcolor),
      ),
      hintStyle: getTextStyle(const TextStyle(fontSize: 15)),
      border: OutlineInputBorder(
        borderRadius: inputBorderRaduis,
        borderSide: BorderSide(color: primaryColor.withOpacity(0.1), width: 1),
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      //   borderSide: const BorderSide(
      //     color: Colors.grey,
      //     width: 1,
      //   ),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      //   borderSide: BorderSide(
      //     color: primaryColor,
      //     width: 2,
      //   ),
      // ),
      errorBorder: OutlineInputBorder(
        borderRadius: inputBorderRaduis,
        borderSide: BorderSide(color: redErrorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: inputBorderRaduis,
        borderSide: BorderSide(color: redErrorColor, width: 2),
      ),
    );
  }

  static TextStyle getTextStyle(TextStyle textStyle) {
    return textStyle.copyWith(fontFamily: fontFamily);
    // return GoogleFonts.montserrat(textStyle: textStyle);
    // return GoogleFonts.plusJakartaSans(textStyle: textStyle);
    // return GoogleFonts.openSans(textStyle: textStyle);

    // return GoogleFonts.workSans(textStyle: textStyle);
    // return GoogleFonts.(textStyle: textStyle);
    // return GoogleFonts.varela(textStyle: textStyle);
    // return GoogleFonts.dancingScript(textStyle: textStyle);
    // return GoogleFonts.satisfy(textStyle: textStyle);
    // return GoogleFonts.kaushanScript(textStyle: textStyle);
    // return GoogleFonts.kaushanScript(textStyle: textStyle);
    // return GoogleFonts.roboto(textStyle: textStyle);
    // return GoogleFonts.ubuntu(textStyle: textStyle);
    // return GoogleFonts.flowCircular(textStyle: textStyle);

    // return textStyle;
  }

  static IconButtonThemeData iconButtonThemeData(ColorScheme colorScheme) {
    return IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLightMode ? Colors.grey[400] : Colors.grey[600];
          }
          return isLightMode ? Colors.black87 : Colors.white;
        }),
      ),
    );
  }

  static IconThemeData iconThemeData(ColorScheme colorScheme) {
    return const IconThemeData(color: Colors.black87, size: 24);
  }

  static OutlinedButtonThemeData outLinedButtonThemeData(
    ColorScheme colorScheme,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: cardColorTap,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: buttonBorderRaduis,
          side: BorderSide(color: primaryColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        side: BorderSide.none,
        foregroundColor: primaryColor,
        textStyle: getTextStyle(
          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static progressIndicatorThemeData() => ProgressIndicatorThemeData(
    borderRadius: BorderRadius.circular(10),
    color: primaryColor,
    linearTrackColor: isLightMode ? Colors.grey[300] : Colors.white,
  );

  static TextButtonThemeData textButtonThemeData(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: buttonBorderRaduis),
        minimumSize: const Size(0, 0),
        foregroundColor: textButtonColor,
        textStyle: getTextStyle(
          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
