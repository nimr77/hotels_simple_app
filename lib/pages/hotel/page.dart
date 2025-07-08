import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/routes/routes.dart';

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
    return const Placeholder();
  }
}
