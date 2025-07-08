import 'package:flutter/widgets.dart';
import 'package:hotel_app/generated/l10n.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/hotel_search/repo.dart';
import 'package:hotel_app/logic/hotel_search/utils/hotel_attractiveness_utils.dart';
import 'package:hotel_app/logic/logger/loger.dart';

class HotelsSearchProvider {
  final loadingState = ValueNotifier<bool>(false);

  final loadingRecomandedState = ValueNotifier<bool>(false);

  final listState = ValueNotifier<List<Hotel>>([]);

  final recomandedState = ValueNotifier<List<Hotel>>([]);

  final repo = HotelSearchRepository();
  late SearchQuery? query;

  HotelsSearchProvider();

  Future<void> init() async {
    query = await repo.getLastSearchQuery();

    query ??= repo.getDefaultSearchQuery();
  }

  Future<void> loadHotels() async {
    if (query == null) {
      throw Exception('query is null');
    }
    try {
      loadingState.value = true;

      final r = await repo.searchHotels(query!);
      loadingRecomandedState.value = true;
      final mostAttractive =
          await HotelAttractivenessUtils.getMostAttractiveHotelsInBackground(
            r.hotels.map((e) => e.toMap()).toList(),
            limit: 3,
          );
      recomandedState.value = mostAttractive
          .map((e) => Hotel.fromMap(e))
          .toList();
      listState.value = r.hotels
          .where((e) => !recomandedState.value.any((m) => m.name == e.name))
          .toList();
    } catch (e) {
      recomandedState.value = [];
      listState.value = [];

      logError(S.current.errorLoadingData, error: e);
    } finally {
      loadingState.value = false;
      loadingRecomandedState.value = false;
    }
  }
}
