import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/routes/routes.dart';
import 'package:hotel_app/widgets/navigation/item.dart';
import 'package:hotel_app/widgets/navigation/navigator.dart';

class LayoutPage extends StatelessWidget {
  final Widget child;
  const LayoutPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: NavigatorBar(
        items: [
          // Home navigation item
          NotificationItem(
            route: Routes.home,
            builder: (_, selected) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/home.svg", height: 20),

                  Text(
                    S.current.home,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
          // Wishlist navigation item
          NotificationItem(
            route: Routes.favorites,
            builder: (_, selected) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/heart.svg", height: 20),
                  Text(
                    S.current.favorites,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
          // Bookings navigation item
          NotificationItem(
            route: Routes.profile,
            builder: (_, selected) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/circle-user.svg", height: 20),
                  Text(
                    S.current.profile,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
        loading: false,
      ),
    );
  }
}
