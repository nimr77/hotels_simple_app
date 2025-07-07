import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/pages/home/page.dart';
import 'package:hotel_app/pages/hotel/page.dart';

/// Enum representing different routes in the application
enum Routes {
  /// Main home screen and its the search screen
  home,

  /// User profile screen
  hotel;

  /// List of routes that require authentication.
  static List<Routes> get authRoutes => [];

  static List<Routes> get globalRoutes => [];

  /// List of routes that are part of the main shell (excluding auth routes).
  static List<Routes> get shellRoutes => [
    ...Routes.values.where((element) => !authRoutes.contains(element)),
  ];

  /// Map of routes to their corresponding builder functions.
  static Map<Routes, Function(BuildContext, GoRouterState)> get _builder => {
    Routes.home: (context, state) => const HomePage(),
    Routes.hotel: (context, state) => const HotelPage(),
  };

  /// Map of route names to their corresponding paths.
  static Map<Routes, String> get _routes => {
    Routes.home: '/',
    Routes.hotel: '/profile',
  };

  /// Checks if the route requires authentication.
  bool get isRequiredAuth {
    // final authRequired = {};

    // return authRequired.contains(this);

    return true;
  }

  /// Gets the route path for the current route.
  String get route => Routes.getRoute(this);

  /// Gets the route name without any parameters.
  String get routeName {
    final route = this.route;

    // split by : and get the first part
    return route.split(':').first;
  }

  /// Builds the widget for the current route.
  Widget build(BuildContext context, GoRouterState state) {
    return _builder[this]!(context, state);
  }

  /// Gets the route path for a given route.
  static String getRoute(Routes route) {
    return _routes[route] ?? '/';
  }

  /// Gets the route enum value for a given route name.
  static Routes getRouteByName(String name) {
    if (!_routes.entries.any((element) => element.value == name)) {
      return Routes.home;
    }
    return _routes.entries.firstWhere((element) => element.value == name).key;
  }
}
