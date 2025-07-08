import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/style/common.dart';

Color get blurColor => isDarkMode
    ? Theme.of(mainNavigationKey.currentContext!).scaffoldBackgroundColor
    : Colors.grey.shade200;

class HeaderBG extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final List<double>? opacity;
  final bool enalbeGlass;
  final double? progress;
  const HeaderBG({
    super.key,
    this.child,
    this.color,
    this.opacity,
    this.enalbeGlass = true,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    Color c = color ?? blurColor;

    // double glassValue = (progress ?? 1) * 15;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            if (opacity != null) ...[
              for (double o in opacity!) c.withOpacity(o.clamp(0, 1)),
            ] else ...[
              c.withOpacity(0.7),
              c.withOpacity(0.75),
              c.withOpacity(0.8),
              c.withOpacity(0.8),
            ],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      width: double.infinity,
      child: child,
    ).asGlass();
  }
}
