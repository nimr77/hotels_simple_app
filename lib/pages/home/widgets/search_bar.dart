import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/paddings.dart';

class HomePageSearchBarWidget extends StatelessWidget {
  const HomePageSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          [
            Expanded(
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.all(outterCardRadius),
                child: Hero(
                  tag: "search_bar",
                  child: Container(
                    padding: ineerPaddingSearchPadding,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      // border: Theme.of(context).brightness.isDark
                      //     ? Border.all(
                      //         color: Theme.of(context).dividerColor,
                      //         width: 1,
                      //       )
                      //     : null,
                      boxShadow: [
                        if (!isDarkMode)
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).shadowColor.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                      ],
                      borderRadius: BorderRadius.all(outterCardRadius),
                    ),
                    child: Row(
                      children: [
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            S.current.searchBarTitle,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/icons/search.svg",
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).textTheme.bodyLarge!.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsetsDirectional.only(
            //     start: 10,
            //   ),
            //   child: FilterButton(),
            // )
          ].animate(
            interval: const Duration(milliseconds: 100),
            effects: [
              const SlideEffect(begin: Offset(-0.2, 0), curve: Curves.easeIn),
              const FadeEffect(),
            ],
          ),
    );
  }
}
