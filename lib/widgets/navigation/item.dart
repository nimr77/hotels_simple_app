import 'package:flutter/material.dart';
import 'package:hotel_app/routes/routes.dart';

class NotificationItem {
  Routes route;
  Widget Function(BuildContext, bool) builder;
  NotificationItem({required this.route, required this.builder});

  String get routerPath => route.route;
}
