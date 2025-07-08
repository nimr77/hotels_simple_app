import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass/glass.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/routes/routes.dart';
import 'package:hotel_app/style/font_size.dart';

class NavigationTitle extends StatelessWidget {
  final String? title;
  final bool showGoback;
  final void Function()? onTap;
  const NavigationTitle({
    super.key,
    this.title,
    this.showGoback = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool canGoBack = context.canPop() && showGoback;

    return InkWell(
      onTap:
          onTap ??
          () {
            try {
              if (canGoBack) {
                context.pop();
              } else {
                context.go(Routes.home.route);
              }
            } catch (e) {
              context.go(Routes.home.route);
            }
          },
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: !canGoBack ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
        child: Row(
          children:
              [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    try {
                      if (canGoBack) {
                        context.pop();
                      } else {
                        context.go(Routes.home.route);
                      }
                    } catch (e) {
                      context.go(Routes.home.route);
                    }
                  },
                  child:
                      Container(
                        decoration: BoxDecoration(
                          color: title != null
                              ? Colors.transparent
                              : Theme.of(
                                  context,
                                ).colorScheme.surface.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.navigate_before),
                        ),
                      ).asGlass(
                        enabled: title == null,
                        clipBorderRadius: BorderRadius.circular(50),
                      ),
                ),
                if (title != null)
                  Text(
                    title!,
                    style: isTablet
                        ? Theme.of(context).textTheme.headlineSmall
                        : Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(fontSize: 19),
                  ),
              ].animate(
                interval: const Duration(milliseconds: 300),
                effects: [
                  const SlideEffect(
                    begin: Offset(-0.2, 0),
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                  ),
                  const FadeEffect(duration: Duration(milliseconds: 300)),
                ],
              ),
        ),
      ),
    );
  }
}
