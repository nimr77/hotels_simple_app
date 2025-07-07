import 'package:dio/dio.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel_search_response.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/http/endpoints.dart';
import 'package:hotel_app/models/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelSearchRepository {
  static const String _offlineHotelsKey = 'offline_hotels';
  final Dio dio;

  HotelSearchRepository({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: Env.baseUrl));

  /// Clear offline hotels from SharedPreferences
  Future<bool> clearOfflineHotels() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_offlineHotelsKey);
    } catch (e) {
      print('Error clearing offline hotels: $e');
      return false;
    }
  }

  /// Get hotels from SharedPreferences for offline access
  Future<HotelSearchResponse?> getOfflineHotels() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hotelsJson = prefs.getString(_offlineHotelsKey);

      if (hotelsJson != null) {
        return HotelSearchResponse.fromJson(hotelsJson);
      }
      return null;
    } catch (e) {
      print('Error getting offline hotels: $e');
      return null;
    }
  }

  /// Save hotels to SharedPreferences for offline access
  Future<bool> saveHotels(HotelSearchResponse hotels) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hotelsJson = hotels.toJson();
      return await prefs.setString(_offlineHotelsKey, hotelsJson);
    } catch (e) {
      print('Error saving hotels: $e');
      return false;
    }
  }

  Future<HotelSearchResponse> searchHotels(SearchQuery query) async {
    final params = query.toJson();
    params['api_key'] = Env.apiKey;
    final response = await dio.get(
      HotelApiEndpoint.searchHotels.path,
      queryParameters: params,
    );

    return HotelSearchResponse.fromMap(response.data);
  }
}
