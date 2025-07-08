import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass/glass.dart';
import 'package:hotel_app/logic/favorite/provider.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:hotel_app/setup.dart';
import 'package:hotel_app/style/common.dart';

class HotelFavoirteButton extends StatelessWidget {
  final Hotel hotel;
  const HotelFavoirteButton({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final provider = getIt<FavoriteProvider>();

    final isFav = provider.check(hotel);

    final valueListenable = ValueNotifier(isFav);
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        return Container(
          decoration: CommonThemeBuilders.boxDecorationTap.copyWith(
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                value ? "assets/icons/heart.svg" : "assets/icons/heart (1).svg",
                key: ValueKey(value),
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  value
                      ? Colors.red
                      : isDarkMode
                      ? Colors.white
                      : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onPressed: () {
              valueListenable.value = !valueListenable.value;
              provider.set(hotel);
            },
          ),
        ).asGlass(clipBorderRadius: BorderRadius.circular(100));
      },
    );
  }
}
