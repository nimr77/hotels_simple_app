import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:hotel_app/style/common.dart';

class NavigationContainer extends StatelessWidget {
  final Widget child;

  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;

  final Color? color;

  final bool shadow;
  const NavigationContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.shadow = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: CommonThemeBuilders.elevatedButtonThemeDataMain(
          Theme.of(context).colorScheme,
        ),
      ),
      child:
          Container(
            width: double.infinity,
            decoration: CommonThemeBuilders.buttomSheetDecoration.copyWith(
              borderRadius: borderRadius ?? BorderRadius.zero,
              boxShadow: shadow ? null : [],
              color:
                  color ??
                  (CommonThemeBuilders.buttomSheetDecoration.color!).withAlpha(
                    180,
                  ),
            ),
            child: Padding(
              padding:
                  padding ??
                  const EdgeInsets.all(8.0).add(
                    EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom * 0.5,
                    ),
                  ),
              child: child,
            ),
          ).asGlass(
            // enabled: isDarkMode,
            clipBorderRadius: borderRadius?.resolve(null) ?? BorderRadius.zero,
          ),
    );
  }
}
