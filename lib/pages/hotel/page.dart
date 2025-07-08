import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/routes/routes.dart';
import 'package:hotel_app/style/common.dart';
import 'package:hotel_app/style/constants.dart';
import 'package:hotel_app/style/paddings.dart';
import 'package:hotel_app/widgets/elements/stars.dart';
import 'package:hotel_app/widgets/header/imaged.dart';
import 'package:hotel_app/widgets/hotels/hotel_favoirte.dart';
import 'package:hotel_app/widgets/hotels/price.dart';

void navigateToHotel(Hotel hotel) {
  final context =
      homeNavigationKey.currentContext ?? mainNavigationKey.currentContext!;

  final hotelJson = hotel.toJson();

  final jsonQuery = Uri.encodeQueryComponent(hotelJson);

  final rotue = "${Routes.hotel.route}?hotel=$jsonQuery";

  context.push(rotue);
}

class HotelPage extends StatefulWidget {
  final GoRouterState state;
  const HotelPage({super.key, required this.state});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  Hotel get hotel => Hotel.fromJson(widget.state.uri.queryParameters["hotel"]!);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ImagedHeaderSliverWidget(
          actions: [HotelFavoirteButton(hotel: hotel)],
          expandedHeight: 200,
          image: Hero(
            tag: hotel.thumbnail,

            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: outterCardRadius * 0.6,
              ),
              child: CachedNetworkImage(
                imageUrl: hotel.thumbnail,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  hotel.name,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacer),
              child: Container(
                padding: infoBoxPadding,
                decoration: CommonThemeBuilders.boxDecoration,
                child: Column(
                  spacing: kSpacer * 0.6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(hotel.name),
                    Row(
                      children: [
                        RatingStars(stars: hotel.hotel_class, size: 14),
                        Spacer(),
                        HotelPriceCardViewWidget(hotel: hotel),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: kSpacer),
              child: Container(
                padding: infoBoxPadding,
                decoration: CommonThemeBuilders.boxDecoration,
                child: Column(
                  spacing: kSpacer * 0.6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final a in hotel.amenities)
                      Text(a, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        ].map((e) => SliverPadding(padding: pagePadding, sliver: e)),
      ],
    );
  }
}
