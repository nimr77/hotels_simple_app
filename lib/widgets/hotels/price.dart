import 'package:flutter/material.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';

class HotelPriceCardViewWidget extends StatelessWidget {
  final Hotel hotel;
  const HotelPriceCardViewWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Text(
      hotel.price,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
