import 'package:flutter/material.dart';
import 'package:hotel_app/widgets/navigation/container.dart';

class HeaderSliverWidget extends StatelessWidget {
  final Widget? title;
  final double? height;
  const HeaderSliverWidget({super.key, this.title, this.height});

  @override
  Widget build(BuildContext context) {
    double headMedia = MediaQuery.of(context).padding.top;

    double toolbarHeight =
        (title == null ? (headMedia > 30 ? 0 : headMedia) : headMedia) +
        (height ?? 0);

    return SliverAppBar(
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      expandedHeight: toolbarHeight,
      collapsedHeight: toolbarHeight,
      flexibleSpace: NavigationContainer(
        shadow: false,
        padding: const EdgeInsets.only(top: 0),
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        child: title ?? SizedBox(height: headMedia),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
    );
  }
}
