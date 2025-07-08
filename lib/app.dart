import 'package:flutter/material.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/language/provider.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/font_size.dart';
import 'package:hotel_app/style/themes.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CommonThemeBuilders.context = context;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => getIt<LanguageProvider>()),

          // ChangeNotifierProvider(create: (_) => getIt<DeepLinkingProvider>())
        ],
        builder: (context, _) {
          final currentLanguage = context
              .watch<LanguageProvider>()
              .currentLocal;

          return ToastificationWrapper(
            child: MaterialApp.router(
              title: S.current.appName,
              locale: currentLanguage,
              themeAnimationCurve: Curves.easeInOut,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(getTheTextFactor(context)),
                  ),
                  child: child!,
                );
              },
              localizationsDelegates: const [
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                // S.delegate,
              ],
              key: ValueKey("HotelsApp - ${currentLanguage.languageCode}"),
              theme: buildLightTheme(),
              darkTheme: buildDarkTheme(),
              themeMode: ThemeMode.system,
              // darkTheme: buildDarkTheme(),
              routerConfig: mainRouter,
            ),
          );
        },
      ),
    );
  }
}
