import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hotel_app/routes/util.dart';
import 'package:hotel_app/widgets/navigation/container.dart';
import 'package:hotel_app/widgets/navigation/item.dart';
import 'package:hotel_app/widgets/navigation/item_widget.dart';

class NavigatorBar extends StatelessWidget {
  final List<NotificationItem> items;
  final bool loading;
  const NavigatorBar({super.key, required this.items, required this.loading});

  @override
  Widget build(BuildContext context) {
    final currentPath = locationRouter;

    bool toShow = items.any((element) => element.routerPath == currentPath);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.6),
          end: const Offset(0, 0),
        ).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: Visibility(
        visible: toShow && !loading,
        key: ValueKey(toShow && !loading),
        child: NavigationContainer(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items
                    .map((item) {
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child: NavigationItemWidget(item: item),
                      );
                    })
                    .toList()
                    .animate(
                      interval: const Duration(milliseconds: 150),
                      effects: const [
                        SlideEffect(
                          begin: Offset(0, 0.2),
                          curve: Curves.easeIn,
                        ),
                        ScaleEffect(
                          begin: Offset(0, -0.1),
                          curve: Curves.easeIn,
                        ),
                        FadeEffect(),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
