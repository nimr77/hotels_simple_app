import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/pages/layout.dart';
import 'package:hotel_app/routes/routes.dart';
import 'package:hotel_app/routes/scroll_home.dart';
import 'package:hotel_app/routes/util.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

// Global navigation keys
final homeNavigationKey = GlobalKey<NavigatorState>();
final mainNavigationKey = GlobalKey<NavigatorState>();

/// Main router configuration
final mainRouter = buildRouter();

// Variable to store the route that required authentication
String? _regusitedRoute;
// Getter for the app context
BuildContext? get appContext => mainNavigationKey.currentContext;

// Getter for the current route before required authentication
String get currentRouteBeforeRequiredAuth => _regusitedRoute ?? '/';

GoRouter buildRouter() {
  return GoRouter(
    navigatorKey: mainNavigationKey,
    initialLocation: "/",
    redirect: (context, state) {
      // if (state.uri.toString().contains("https://") &&
      //     !state.uri.toString().contains("?url")) {
      //   Future.delayed(Duration(seconds: 1), () {
      //     if (kDebugMode) Logger().i("Redirecting to ${state.uri.toString()}");
      //     DeepLinkingProvider.navigateBasedOnTheUri(state.uri);
      //   });
      //   return Routes.home.route;
      // }
      // // Check if app is configured
      // if (!appConfigState.value) {
      //   return Routes.errorConfig.route;
      // }

      // // Check if it's the first time running the app
      // if (FirstTime.runingApp.getAndSet()) {
      //   return Routes.welcome.route;
      // }

      // // final appProvider = getIt<AppProvider>();

      // // Check app version state
      // final versionState = appProvider.versionState.value;
      // if (versionState?.allowAccess == false) {
      //   FirebaseAnalytics.instance.logEvent(name: "app_blocked_user_to_update");
      //   return Routes.releaseNote.route;
      // }

      // // Show update dialog if an update is available
      // if (versionState?.isUpdateAvailable == true &&
      //     versionState?.flagged != true &&
      //     mainNavigationKey.currentContext != null) {
      //   Future.delayed(const Duration(seconds: 1), () {
      //     FirebaseAnalytics.instance.logEvent(name: "app_show_update_dialog");

      //     showOkCancelAlertDialog(
      //             context: mainNavigationKey.currentContext!,
      //             title: S.current.newUpdateIsAvailable,
      //             okLabel: S.current.updateNow,
      //             cancelLabel: S.current.skip)
      //         .then((value) {
      //       if (value == OkCancelResult.ok) {
      //         FirebaseAnalytics.instance
      //             .logEvent(name: "app_user_update_app_from_dialog");

      //         appProvider.openStoreLink();
      //       } else {
      //         versionState?.flagged = true;
      //       }
      //     });
      //   });
      // }

      return null;
    },
    routes: [
      ...Routes.globalRoutes.map(
        (e) => GoRoute(
          path: e.route,
          builder: (context, state) => e.build(context, state),
        ),
      ),
      // Auth routes
      ...Routes.authRoutes.map(
        (e) => GoRoute(
          path: e.route,
          redirect: (context, state) {
            if (kIsWeb) return null;
            return null;
          },
          builder: (context, state) => e.build(context, state),
        ),
      ),

      // Shell routes
      ShellRoute(
        navigatorKey: homeNavigationKey,
        builder: (context, state, child) => LayoutPage(child: child),
        routes: Routes.shellRoutes
            .map(
              (e) => GoRoute(
                path: e.route,
                redirect: (context, state) async {
                  // if (e.isRequiredAuth && authRepo.isAuth) {
                  //   return null;
                  // } else {
                  //   if (!e.isRequiredAuth) {
                  //     return null;
                  //   }
                  //   return null;
                  // }

                  return null;
                },
                pageBuilder: (context, state) => Platform.isIOS
                    ? CupertinoPage(
                        child: ChangeNotifierProvider(
                          create: (context) => MyScrollController(),
                          builder: (contextProvider, _) {
                            final providerScroll = contextProvider
                                .read<MyScrollController>();
                            providerScroll.initOffset();
                            return Material(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: e.build(context, state),
                            );
                          },
                        ),
                      )
                    : _buildPageWithDefaultTransition(
                        child: e.build(context, state),
                        context: context,
                        state: state,
                      ),
              ),
            )
            .toList(),
      ),
    ],
  );
}

// Function to change the initial route
changeInitRoute(String route) async {
  await Future.delayed(const Duration(milliseconds: 300));
  if (locationRouter == route) return;
  mainRouter.push(route);
}

// Function to navigate to the required page after authentication
navigateToRequiredPage() {
  // if (_regusitedRoute == Routes.profile.route) {
  //   mainRouter.go(Routes.home.route);
  //   _regusitedRoute = null;
  //   return;
  // }

  // if (_regusitedRoute == Routes.auth.route) {
  //   mainRouter.go(Routes.home.route);
  //   _regusitedRoute = null;
  //   return;
  // }

  if (_regusitedRoute != null) {
    mainRouter.go(_regusitedRoute!);
  } else {
    // if (locationRouterOriginal == Routes.welcome.route ||
    //     locationRouterOriginal == Routes.auth.route) {
    //   _regusitedRoute = null;
    //   mainRouter.go(Routes.home.route);
    // } else {
    final context =
        homeNavigationKey.currentContext ?? mainNavigationKey.currentContext;
    Navigator.pop(context!);
    // }
  }
}

// Function to reset the last redirect
resetLastRedirect() {
  _regusitedRoute = null;
}

// Function to build a page with default transition
Page<dynamic> _buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return SwipeablePage(
    key: state.pageKey,
    builder: (context) => child,
    backGestureDetectionStartOffset: 0,
    canOnlySwipeFromEdge: true,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder:
        (context, primaryAnimation, secondaryAnimation, v, child) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            child: ChangeNotifierProvider(
              create: (context) => MyScrollController(),
              builder: (contextProvider, _) {
                final providerScroll = contextProvider
                    .read<MyScrollController>();
                providerScroll.initOffset();
                return Material(child: child);
              },
            ),
          );
        },
  );
}

// Custom MaterialPageRoute for fade-in transition
class FadeInTransition extends MaterialPageRoute {
  final ValueKey key;
  FadeInTransition({required this.key, required super.builder});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      fillColor: Colors.transparent,
      key: key,
      child: child,
    );
  }
}
