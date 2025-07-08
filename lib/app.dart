import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/logic/language/bloc.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/font_size.dart';
import 'package:hotel_app/style/themes.dart';
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
      child: BlocProvider(
        create: (_) => getIt<LanguageBloc>(),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return ToastificationWrapper(
              child: MaterialApp.router(
                title: 'Hotel App',
                locale: state.currentLocale,
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
                key: ValueKey("HotelApp - ${state.currentLocale.languageCode}"),
                theme: buildLightTheme(),
                darkTheme: buildDarkTheme(),
                themeMode: ThemeMode.system,
                // darkTheme: buildDarkTheme(),
                routerConfig: mainRouter,
              ),
            );
          },
        ),
      ),
    );
  }
}
