import 'package:go_router/go_router.dart';
import 'package:hotel_app/routes/router.dart';

/// Returns the current location of the router.
///
/// This function attempts to retrieve the current location from the main router.
/// If the router's configuration is empty, it returns "/".
/// In case of any error, it records the error to Firebase Crashlytics and returns an empty string.
String get locationRouter {
  try {
    GoRouter router = mainRouter;
    if (router.routerDelegate.currentConfiguration.isEmpty) {
      return "/";
    }
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    return location;
  } catch (e) {
    return "";
  }
}

/// Returns the current location of the home router.
///
/// This function attempts to retrieve the current location from the main router.
/// In case of any error, it returns an empty string without recording the error.
String get locationRouterHome {
  try {
    GoRouter router = mainRouter;
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    return location;
  } catch (e) {
    return "";
  }
}

/// Returns the current location of the main router.
///
/// This function attempts to retrieve the current location from the main router.
/// In case of any error, it records the error to Firebase Crashlytics and returns an empty string.
String get locationRouterMain {
  try {
    GoRouter router = mainRouter;
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    return location;
  } catch (e) {
    return "";
  }
}

/// Returns the original full path of the current location.
///
/// This function attempts to retrieve the full path of the current location from the main router.
/// It uses the 'fullPath' property instead of 'uri.toString()'.
/// In case of any error, it records the error to Firebase Crashlytics and returns an empty string.
String get locationRouterOriginal {
  try {
    GoRouter router = mainRouter;
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    final String location = matchList.fullPath;

    return location;
  } catch (e) {
    return "";
  }
}
