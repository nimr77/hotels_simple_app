import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';

/// Global utility class for hotel attractiveness calculations
class HotelAttractivenessUtils {
  /// Background computation function for calculating attractiveness scores
  static Future<List<Map<String, dynamic>>>
  calculateAttractivenessScoresInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_calculateAttractivenessScores, hotelMaps);
  }

  /// Get highly attractive hotels from Hotel objects
  static List<Hotel> getHighlyAttractiveHotelsFromObjects(List<Hotel> hotels) {
    return hotels.where((hotel) => hotel.isHighlyAttractive).toList();
  }

  /// Background computation function for getting highly attractive hotels
  static Future<List<Map<String, dynamic>>>
  getHighlyAttractiveHotelsInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getHighlyAttractiveHotels, hotelMaps);
  }

  /// Get hotels by hotel class range from Hotel objects
  static List<Hotel> getHotelsByClassRangeFromObjects(
    List<Hotel> hotels, {
    int? minClass,
    int? maxClass,
  }) {
    return hotels.where((hotel) {
      if (minClass != null && hotel.hotelClass < minClass) return false;
      if (maxClass != null && hotel.hotelClass > maxClass) return false;
      return true;
    }).toList();
  }

  /// Get hotels by price range from Hotel objects
  static List<Hotel> getHotelsByPriceRangeFromObjects(
    List<Hotel> hotels, {
    int? minPrice,
    int? maxPrice,
  }) {
    return hotels.where((hotel) {
      if (minPrice != null && hotel.extracted_price < minPrice) return false;
      if (maxPrice != null && hotel.extracted_price > maxPrice) return false;
      return true;
    }).toList();
  }

  /// Background computation function for getting hotels by price range
  static Future<List<Map<String, dynamic>>> getHotelsByPriceRangeInBackground(
    List<Map<String, dynamic>> hotelMaps, {
    int? minPrice,
    int? maxPrice,
  }) async {
    return compute(_getHotelsByPriceRange, {
      'hotels': hotelMaps,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    });
  }

  /// Get hotels by rating range from Hotel objects
  static List<Hotel> getHotelsByRatingRangeFromObjects(
    List<Hotel> hotels, {
    double? minRating,
    double? maxRating,
  }) {
    return hotels.where((hotel) {
      if (minRating != null && hotel.overall_rating < minRating) return false;
      if (maxRating != null && hotel.overall_rating > maxRating) return false;
      return true;
    }).toList();
  }

  /// Get hotels sorted by price (high to low) from Hotel objects
  static List<Hotel> getHotelsSortedByPriceDescFromObjects(
    List<Hotel> hotels, {
    int limit = 10,
  }) {
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.extracted_price.compareTo(a.extracted_price));
    return sortedHotels.take(limit).toList();
  }

  /// Get hotels sorted by price (low to high) from Hotel objects
  static List<Hotel> getHotelsSortedByPriceFromObjects(
    List<Hotel> hotels, {
    int limit = 10,
  }) {
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => a.extracted_price.compareTo(b.extracted_price));
    return sortedHotels.take(limit).toList();
  }

  /// Get hotels sorted by reviews count from Hotel objects
  static List<Hotel> getHotelsSortedByReviewsFromObjects(
    List<Hotel> hotels, {
    int limit = 10,
  }) {
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.reviews.compareTo(a.reviews));
    return sortedHotels.take(limit).toList();
  }

  /// Get hotels with amenities from Hotel objects
  static List<Hotel> getHotelsWithAmenitiesFromObjects(List<Hotel> hotels) {
    return hotels.where((hotel) => hotel.hasAmenities).toList();
  }

  /// Background computation function for getting hotels with amenities
  static Future<List<Map<String, dynamic>>> getHotelsWithAmenitiesInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getHotelsWithAmenities, hotelMaps);
  }

  /// Get hotels with free cancellation from Hotel objects
  static List<Hotel> getHotelsWithFreeCancellationFromObjects(
    List<Hotel> hotels,
  ) {
    return hotels.where((hotel) => hotel.free_cancellation).toList();
  }

  /// Background computation function for getting hotels with free cancellation
  static Future<List<Map<String, dynamic>>>
  getHotelsWithFreeCancellationInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getHotelsWithFreeCancellation, hotelMaps);
  }

  /// Get hotels with reviews from Hotel objects
  static List<Hotel> getHotelsWithReviewsFromObjects(List<Hotel> hotels) {
    return hotels.where((hotel) => hotel.hasReviews).toList();
  }

  /// Background computation function for getting hotels with reviews
  static Future<List<Map<String, dynamic>>> getHotelsWithReviewsInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getHotelsWithReviews, hotelMaps);
  }

  // Isolated computation functions (these run in separate threads)

  /// Get hotels with specific amenities from Hotel objects
  static List<Hotel> getHotelsWithSpecificAmenitiesFromObjects(
    List<Hotel> hotels,
    List<String> requiredAmenities,
  ) {
    return hotels.where((hotel) {
      return requiredAmenities.every(
        (amenity) => hotel.amenities.contains(amenity),
      );
    }).toList();
  }

  /// Get luxury hotels from Hotel objects
  static List<Hotel> getLuxuryHotelsFromObjects(List<Hotel> hotels) {
    return hotels.where((hotel) => hotel.hotelClass >= 4).toList();
  }

  /// Background computation function for getting luxury hotels
  static Future<List<Map<String, dynamic>>> getLuxuryHotelsInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getLuxuryHotels, hotelMaps);
  }

  /// Get moderately attractive hotels from Hotel objects
  static List<Hotel> getModeratelyAttractiveHotelsFromObjects(
    List<Hotel> hotels,
  ) {
    return hotels.where((hotel) => hotel.isModeratelyAttractive).toList();
  }

  /// Background computation function for getting moderately attractive hotels
  static Future<List<Map<String, dynamic>>>
  getModeratelyAttractiveHotelsInBackground(
    List<Map<String, dynamic>> hotelMaps,
  ) async {
    return compute(_getModeratelyAttractiveHotels, hotelMaps);
  }

  /// Get most attractive hotels from Hotel objects (uses existing attractivenessScore)
  static List<Hotel> getMostAttractiveHotelsFromObjects(
    List<Hotel> hotels, {
    int limit = 10,
  }) {
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.attractivenessScore.compareTo(a.attractivenessScore));

    return sortedHotels.take(limit).toList();
  }

  /// Background computation function for getting most attractive hotels
  static Future<List<Map<String, dynamic>>> getMostAttractiveHotelsInBackground(
    List<Map<String, dynamic>> hotelMaps, {
    int limit = 10,
  }) async {
    return compute(_getMostAttractiveHotels, {
      'hotels': hotelMaps,
      'limit': limit,
    });
  }

  /// Get top rated hotels from Hotel objects
  static List<Hotel> getTopRatedHotelsFromObjects(
    List<Hotel> hotels, {
    int limit = 10,
  }) {
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.overall_rating.compareTo(a.overall_rating));
    return sortedHotels.take(limit).toList();
  }

  /// Background computation function for getting top rated hotels
  static Future<List<Map<String, dynamic>>> getTopRatedHotelsInBackground(
    List<Map<String, dynamic>> hotelMaps, {
    int limit = 10,
  }) async {
    return compute(_getTopRatedHotels, {'hotels': hotelMaps, 'limit': limit});
  }

  /// Convert Hotel objects to list of maps
  static List<Map<String, dynamic>> hotelsToMaps(List<Hotel> hotels) {
    return hotels.map((hotel) => hotel.toMap()).toList();
  }

  // Convenience methods for direct Hotel object operations

  /// Convert single Hotel object to map
  static Map<String, dynamic> hotelToMap(Hotel hotel) {
    return hotel.toMap();
  }

  /// Convert JSON string containing array to list of Hotel objects
  static List<Hotel> jsonArrayToHotels(String jsonArrayString) {
    try {
      final List<dynamic> hotelsList = json.decode(jsonArrayString);
      return hotelsList
          .map((hotelMap) => Hotel.fromMap(hotelMap as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw FormatException('Invalid JSON array format: $e');
    }
  }

  /// Convert list of JSON strings to Hotel objects
  static List<Hotel> jsonListToHotels(List<String> jsonStrings) {
    return jsonStrings.map((jsonString) => jsonToHotel(jsonString)).toList();
  }

  /// Convert JSON string to Hotel object
  static Hotel jsonToHotel(String jsonString) {
    try {
      return Hotel.fromJson(jsonString);
    } catch (e) {
      throw FormatException('Invalid JSON format for hotel: $e');
    }
  }

  /// Convert list of maps to Hotel objects
  static List<Hotel> mapsToHotels(List<Map<String, dynamic>> hotelMaps) {
    return hotelMaps.map((map) => Hotel.fromMap(map)).toList();
  }

  /// Convert single map to Hotel object
  static Hotel mapToHotel(Map<String, dynamic> hotelMap) {
    return Hotel.fromMap(hotelMap);
  }

  /// Isolated function to calculate attractiveness scores for all hotels
  static List<Map<String, dynamic>> _calculateAttractivenessScores(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final hotelsWithScores = hotels.map((hotel) {
      final map = hotel.toMap();
      map['attractivenessScore'] = hotel.attractivenessScore;
      return map;
    }).toList();
    return hotelsWithScores;
  }

  /// Isolated function to get highly attractive hotels
  static List<Map<String, dynamic>> _getHighlyAttractiveHotels(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final highlyAttractive = hotels
        .where((hotel) => hotel.isHighlyAttractive)
        .toList();
    return hotelsToMaps(highlyAttractive);
  }

  /// Isolated function to get hotels by price range
  static List<Map<String, dynamic>> _getHotelsByPriceRange(
    Map<String, dynamic> params,
  ) {
    final List<Map<String, dynamic>> hotelMaps = params['hotels'];
    final int? minPrice = params['minPrice'];
    final int? maxPrice = params['maxPrice'];

    final hotels = mapsToHotels(hotelMaps);
    final filteredHotels = hotels.where((hotel) {
      if (minPrice != null && hotel.extracted_price < minPrice) return false;
      if (maxPrice != null && hotel.extracted_price > maxPrice) return false;
      return true;
    }).toList();

    return hotelsToMaps(filteredHotels);
  }

  // Additional utility methods for Hotel objects

  /// Isolated function to get hotels with amenities
  static List<Map<String, dynamic>> _getHotelsWithAmenities(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final hotelsWithAmenities = hotels
        .where((hotel) => hotel.hasAmenities)
        .toList();
    return hotelsToMaps(hotelsWithAmenities);
  }

  /// Isolated function to get hotels with free cancellation
  static List<Map<String, dynamic>> _getHotelsWithFreeCancellation(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final freeCancellationHotels = hotels
        .where((hotel) => hotel.free_cancellation)
        .toList();
    return hotelsToMaps(freeCancellationHotels);
  }

  /// Isolated function to get hotels with reviews
  static List<Map<String, dynamic>> _getHotelsWithReviews(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final hotelsWithReviews = hotels
        .where((hotel) => hotel.hasReviews)
        .toList();
    return hotelsToMaps(hotelsWithReviews);
  }

  /// Isolated function to get luxury hotels
  static List<Map<String, dynamic>> _getLuxuryHotels(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final luxuryHotels = hotels
        .where((hotel) => hotel.hotelClass >= 4)
        .toList();
    return hotelsToMaps(luxuryHotels);
  }

  /// Isolated function to get moderately attractive hotels
  static List<Map<String, dynamic>> _getModeratelyAttractiveHotels(
    List<Map<String, dynamic>> hotelMaps,
  ) {
    final hotels = mapsToHotels(hotelMaps);
    final moderatelyAttractive = hotels
        .where((hotel) => hotel.isModeratelyAttractive)
        .toList();
    return hotelsToMaps(moderatelyAttractive);
  }

  /// Isolated function to get most attractive hotels
  static List<Map<String, dynamic>> _getMostAttractiveHotels(
    Map<String, dynamic> params,
  ) {
    final List<Map<String, dynamic>> hotelMaps = params['hotels'];
    final int limit = params['limit'] ?? 10;

    final hotels = mapsToHotels(hotelMaps);
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.attractivenessScore.compareTo(a.attractivenessScore));

    final topHotels = sortedHotels.take(limit).toList();
    return hotelsToMaps(topHotels);
  }

  /// Isolated function to get top rated hotels
  static List<Map<String, dynamic>> _getTopRatedHotels(
    Map<String, dynamic> params,
  ) {
    final List<Map<String, dynamic>> hotelMaps = params['hotels'];
    final int limit = params['limit'] ?? 10;

    final hotels = mapsToHotels(hotelMaps);
    final sortedHotels = List<Hotel>.from(hotels)
      ..sort((a, b) => b.overall_rating.compareTo(a.overall_rating));

    final topRatedHotels = sortedHotels.take(limit).toList();
    return hotelsToMaps(topRatedHotels);
  }
}
