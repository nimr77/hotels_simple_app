import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hotel_app/pages/home/widgets/search_bar.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/avatar/user_avatar.dart';

class HomePageHeaderWidget extends StatelessWidget {
  const HomePageHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            [
              Row(
                spacing: kSpacer * 0.5,
                children: [UserAvatarWidget(), Text("Andry")],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: HomePageSearchBarWidget(),
              ),
            ].animate(
              interval: const Duration(milliseconds: 100),
              effects: const [
                SlideEffect(begin: Offset(0, -0.1), curve: Curves.easeIn),
                FadeEffect(),
              ],
            ),
      ),
    );
  }
}
