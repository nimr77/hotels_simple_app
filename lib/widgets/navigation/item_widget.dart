import 'package:flutter/material.dart';
import 'package:gaimon/gaimon.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/routes/scroll_home.dart';
import 'package:hotel_app/routes/util.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/widgets/navigation/item.dart';

class NavigationItemWidget extends StatelessWidget {
  final NotificationItem item;
  const NavigationItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currentPath = locationRouter;

    final selected = item.routerPath == currentPath;
    return ColorFiltered(
      key: ValueKey(selected),
      colorFilter: ColorFilter.mode(
        selected
            ? Theme.of(context).primaryColor
            : isDarkMode
            ? Colors.white.withAlpha(200)
            : Colors.grey[800]!,
        BlendMode.srcIn,
      ),
      child: InkWell(
        onTap: () {
          if (item.routerPath != currentPath) {
            Gaimon.light();
            context.push(item.routerPath);
          } else {
            final scroll = MyScrollController.currentScrollController;
            if (scroll == null || scroll.positions.isEmpty == true) {
              return;
            }
            if (scroll.offset != 0) {
              scroll.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic,
              );
            }
          }
        },
        child: item.builder(context, selected),
      ),
    );
  }
}
