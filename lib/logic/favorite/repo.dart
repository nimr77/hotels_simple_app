import 'package:hotel_app/logic/hotel_search/models/hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepo {
  static const String _favoritesKey = 'favorite_hotels';

  /// Add a hotel to favorites
  Future<void> add(Hotel hotel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_favoritesKey) ?? <String>[];
    // Avoid duplicates by property_token
    if (!jsonList.any(
      (json) => Hotel.fromJson(json).property_token == hotel.property_token,
    )) {
      jsonList.add(hotel.toJson());
      await prefs.setStringList(_favoritesKey, jsonList);
    }
  }

  /// Get the list of favorite hotels (as Hotel objects)
  Future<List<Hotel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_favoritesKey) ?? <String>[];
    return jsonList.map((json) => Hotel.fromJson(json)).toList();
  }

  /// Initialize favorites if not present
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_favoritesKey)) {
      await prefs.setStringList(_favoritesKey, <String>[]);
    }
  }

  /// Check if a hotel is in favorites
  Future<bool> isFavorite(Hotel hotel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_favoritesKey) ?? <String>[];
    return jsonList.any(
      (json) => Hotel.fromJson(json).property_token == hotel.property_token,
    );
  }

  /// Remove a hotel from favorites
  Future<void> remove(Hotel hotel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_favoritesKey) ?? <String>[];
    jsonList.removeWhere(
      (json) => Hotel.fromJson(json).property_token == hotel.property_token,
    );
    await prefs.setStringList(_favoritesKey, jsonList);
  }
}
