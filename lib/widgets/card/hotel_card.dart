import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:hotel_app/pages/hotel/page.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/elements/stars.dart';
import 'package:hotel_app/widgets/hotels/hotel_favoirte.dart';
import 'package:hotel_app/widgets/hotels/price.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToHotel(hotel),

      child: Container(
        decoration: CommonThemeBuilders.boxDecorationTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: outterCardRadius),

                child: Stack(
                  children: [
                    Hero(
                      tag: hotel.thumbnail,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: outterCardRadius,
                        ),

                        child: CachedNetworkImage(
                          imageUrl: hotel.thumbnail,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd.add(
                        const Alignment(0.05, -0.1),
                      ),
                      child: HotelFavoirteButton(
                        hotel: hotel,
                      ).animate(effects: [FadeEffect(), ScaleEffect()]),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: elementsSpacing,
              ).add(EdgeInsets.only(top: kSpacer)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: kSpacer * 0.2,
                children:
                    [
                      Text(
                        hotel.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RatingStars(stars: hotel.hotel_class, size: 14),
                    ].animate(
                      interval: 100.ms,
                      effects: [
                        FadeEffect(duration: 300.ms),
                        SlideEffect(
                          duration: 300.ms,
                          begin: Offset(0, -0.1),
                          curve: Curves.easeInOut,
                        ),
                        BlurEffect(duration: 300.ms, end: Offset(0, 0)),
                      ],
                    ),
              ),
            ),
            Spacer(),

            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: elementsSpacing,
                ).add(EdgeInsets.only(bottom: kSpacer * 0.3)),
                child: HotelPriceCardViewWidget(hotel: hotel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
