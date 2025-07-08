import 'package:flutter/foundation.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';

import 'repo.dart';

class FavoriteProvider {
  final repo = FavoriteRepo();
  final ValueNotifier<List<Hotel>> favoriteList = ValueNotifier<List<Hotel>>(
    <Hotel>[],
  );

  FavoriteProvider();

  /// Add a hotel to favorites
  Future<void> add(Hotel hotel) async {
    await repo.add(hotel);
    final favorites = await repo.getFavorites();
    favoriteList.value = favorites;
  }

  /// Check if a hotel is in favorites
  bool check(Hotel hotel) {
    return favoriteList.value.any((fav) => fav.name == hotel.name);
  }

  /// Initialize the provider and load favorites
  Future<void> init() async {
    await repo.init();
    final favorites = await repo.getFavorites();
    favoriteList.value = favorites;
  }

  /// Remove a hotel from favorites
  Future<void> remove(Hotel hotel) async {
    await repo.remove(hotel);
    final favorites = await repo.getFavorites();
    favoriteList.value = favorites;
  }

  Future<bool> set(Hotel hotel) async {
    final isFav = check(hotel);
    if (isFav) {
      await remove(hotel);
    } else {
      await add(hotel);
    }
    return !isFav;
  }
}
