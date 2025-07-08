import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/header/bg.dart';

class ImagedHeaderSliverWidget extends StatelessWidget {
  final Widget image;

  final double expandedHeight;

  final List<Widget> actions;

  final Widget title;
  const ImagedHeaderSliverWidget({
    super.key,

    required this.expandedHeight,
    required this.image,
    this.actions = const [],
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double toolBar = 40;

    double totalHight = expandedHeight;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: expandedHeight,
      collapsedHeight: toolBar + 20,
      toolbarHeight: toolBar,
      stretch: true,
      pinned: true,
      stretchTriggerOffset: 100,
      surfaceTintColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withAlpha(100),
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          // Calculate the blur intensity based on the SliverAppBar's height
          double percentage =
              (constraints.maxHeight - toolBar) / ((totalHight) - toolBar);
          double blurIntensity =
              (totalHight * 0.1) * (1.0 - percentage.clamp(0.0, 1.0));

          if (blurIntensity > 10) {
            blurIntensity = 10;
          }

          final bool showTitle = constraints.maxHeight < 170;

          // after the blur intensity is calculated, we can build the header the title
          return Stack(
            children: [
              ClipRRect(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: blurIntensity >= 8
                      ? const HeaderBG()
                      : image.animate().blur(
                          end: Offset(blurIntensity, blurIntensity),
                          begin: Offset(blurIntensity, blurIntensity),
                        ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: pagePadding.add(
                    EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 10,
                    ),
                  ),
                  child: Row(
                    children:
                        [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.navigate_before,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    size: 27,
                                  ),
                                ),
                              ),
                              // .asGlass(
                              //     enabled: isDarkMode,
                              //     tintColor: isDarkMode
                              //         ? Colors.white
                              //         : Colors.grey.withOpacity(0.9)),
                            ),
                          ),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-0.1, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: showTitle
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: title,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          Spacer(),

                          ...actions,
                        ].animate(
                          delay: const Duration(milliseconds: 300),
                          interval: const Duration(milliseconds: 100),
                          effects: [
                            // const ScaleEffect(
                            //     begin: Offset(0, -0.05),
                            //     curve: Curves.easeIn,
                            //     alignment: Alignment.topCenter),
                            const FadeEffect(),
                          ],
                        ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
