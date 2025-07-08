import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';
import 'package:hotel_app/logic/hotel_search/utils/hotel_attractiveness_utils.dart';

/// Example usage of HotelAttractivenessUtils with background computation
class HotelAttractivenessExample {
  /// Example hotel data
  static List<Hotel> get sampleHotels => [
    Hotel(
      name: "Luxury Hotel A",
      source: "booking.com",
      sourceIcon: "https://example.com/icon1.png",
      link: "https://booking.com/hotel-a",
      propertyToken: "token1",
      serpapiPropertyDetailsLink: "https://serpapi.com/details1",
      gpsCoordinates: {"latitude": 40.7128, "longitude": -74.0060},
      hotelClass: 5,
      thumbnail: "https://example.com/thumb1.jpg",
      overallRating: 4.8,
      reviews: 1250,
      price: "\$250",
      extractedPrice: 250,
      amenities: ["WiFi", "Pool", "Spa", "Restaurant", "Gym"],
      freeCancellation: true,
    ),
    Hotel(
      name: "Budget Hotel B",
      source: "hotels.com",
      sourceIcon: "https://example.com/icon2.png",
      link: "https://hotels.com/hotel-b",
      propertyToken: "token2",
      serpapiPropertyDetailsLink: "https://serpapi.com/details2",
      gpsCoordinates: {"latitude": 40.7589, "longitude": -73.9851},
      hotelClass: 2,
      thumbnail: "https://example.com/thumb2.jpg",
      overallRating: 3.2,
      reviews: 450,
      price: "\$80",
      extractedPrice: 80,
      amenities: ["WiFi"],
      freeCancellation: false,
    ),
    Hotel(
      name: "Mid-Range Hotel C",
      source: "expedia.com",
      sourceIcon: "https://example.com/icon3.png",
      link: "https://expedia.com/hotel-c",
      propertyToken: "token3",
      serpapiPropertyDetailsLink: "https://serpapi.com/details3",
      gpsCoordinates: {"latitude": 40.7505, "longitude": -73.9934},
      hotelClass: 3,
      thumbnail: "https://example.com/thumb3.jpg",
      overallRating: 4.1,
      reviews: 890,
      price: "\$150",
      extractedPrice: 150,
      amenities: ["WiFi", "Pool", "Restaurant"],
      freeCancellation: true,
    ),
  ];

  /// Example: Convert hotels to maps and process in background
  static Future<void> exampleBackgroundProcessing() async {
    print('=== Background Processing Example ===');

    // Convert hotels to maps
    final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(sampleHotels);
    print('Converted ${hotelMaps.length} hotels to maps');

    try {
      // Get highly attractive hotels in background
      final highlyAttractiveMaps =
          await HotelAttractivenessUtils.getHighlyAttractiveHotelsInBackground(
            hotelMaps,
          );

      print('Highly attractive hotels (background):');
      for (final hotelMap in highlyAttractiveMaps) {
        print(
          '- ${hotelMap['name']} (Score: ${hotelMap['attractivenessScore']})',
        );
      }

      // Get most attractive hotels in background
      final mostAttractiveMaps =
          await HotelAttractivenessUtils.getMostAttractiveHotelsInBackground(
            hotelMaps,
            limit: 2,
          );

      print('\nMost attractive hotels (background):');
      for (final hotelMap in mostAttractiveMaps) {
        print(
          '- ${hotelMap['name']} (Score: ${hotelMap['attractivenessScore']})',
        );
      }

      // Get luxury hotels in background
      final luxuryMaps =
          await HotelAttractivenessUtils.getLuxuryHotelsInBackground(hotelMaps);

      print('\nLuxury hotels (background):');
      for (final hotelMap in luxuryMaps) {
        print('- ${hotelMap['name']} (${hotelMap['hotelClass']} stars)');
      }

      // Get hotels with free cancellation in background
      final freeCancellationMaps =
          await HotelAttractivenessUtils.getHotelsWithFreeCancellationInBackground(
            hotelMaps,
          );

      print('\nHotels with free cancellation (background):');
      for (final hotelMap in freeCancellationMaps) {
        print('- ${hotelMap['name']}');
      }

      // Get hotels by price range in background
      final priceRangeMaps =
          await HotelAttractivenessUtils.getHotelsByPriceRangeInBackground(
            hotelMaps,
            minPrice: 100,
            maxPrice: 200,
          );

      print('\nHotels in price range \$100-\$200 (background):');
      for (final hotelMap in priceRangeMaps) {
        print('- ${hotelMap['name']} (\$${hotelMap['extractedPrice']})');
      }

      // Calculate attractiveness scores in background
      final hotelsWithScores =
          await HotelAttractivenessUtils.calculateAttractivenessScoresInBackground(
            hotelMaps,
          );

      print('\nAll hotels with attractiveness scores (background):');
      for (final hotelMap in hotelsWithScores) {
        print('- ${hotelMap['name']}: ${hotelMap['attractivenessScore']}');
      }
    } catch (e) {
      print('Error in background processing: $e');
    }
  }

  /// Example: Direct Hotel object operations (no background processing)
  static void exampleDirectOperations() {
    print('\n=== Direct Operations Example ===');

    // Get highly attractive hotels directly
    final highlyAttractive =
        HotelAttractivenessUtils.getHighlyAttractiveHotelsFromObjects(
          sampleHotels,
        );

    print('Highly attractive hotels (direct):');
    for (final hotel in highlyAttractive) {
      print(
        '- ${hotel.name} (Score: ${hotel.attractivenessScore.toStringAsFixed(1)})',
      );
    }

    // Get most attractive hotels directly
    final mostAttractive =
        HotelAttractivenessUtils.getMostAttractiveHotelsFromObjects(
          sampleHotels,
          limit: 2,
        );

    print('\nMost attractive hotels (direct):');
    for (final hotel in mostAttractive) {
      print(
        '- ${hotel.name} (Score: ${hotel.attractivenessScore.toStringAsFixed(1)})',
      );
    }

    // Get luxury hotels directly
    final luxuryHotels = HotelAttractivenessUtils.getLuxuryHotelsFromObjects(
      sampleHotels,
    );

    print('\nLuxury hotels (direct):');
    for (final hotel in luxuryHotels) {
      print('- ${hotel.name} (${hotel.hotelClass} stars)');
    }

    // Get hotels with free cancellation directly
    final freeCancellationHotels =
        HotelAttractivenessUtils.getHotelsWithFreeCancellationFromObjects(
          sampleHotels,
        );

    print('\nHotels with free cancellation (direct):');
    for (final hotel in freeCancellationHotels) {
      print('- ${hotel.name}');
    }

    // Get hotels by price range directly
    final priceRangeHotels =
        HotelAttractivenessUtils.getHotelsByPriceRangeFromObjects(
          sampleHotels,
          minPrice: 100,
          maxPrice: 200,
        );

    print('\nHotels in price range \$100-\$200 (direct):');
    for (final hotel in priceRangeHotels) {
      print('- ${hotel.name} (\$${hotel.extractedPrice})');
    }
  }

  /// Example: Convert between formats
  static void exampleFormatConversion() {
    print('\n=== Format Conversion Example ===');

    // Convert hotels to maps
    final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(sampleHotels);
    print(
      'Converted ${sampleHotels.length} hotels to ${hotelMaps.length} maps',
    );

    // Convert maps back to hotels
    final convertedHotels = HotelAttractivenessUtils.mapsToHotels(hotelMaps);
    print(
      'Converted ${hotelMaps.length} maps back to ${convertedHotels.length} hotels',
    );

    // Convert single hotel to map
    final singleHotelMap = HotelAttractivenessUtils.hotelToMap(
      sampleHotels.first,
    );
    print('Single hotel to map: ${singleHotelMap['name']}');

    // Convert single map to hotel
    final singleHotel = HotelAttractivenessUtils.mapToHotel(singleHotelMap);
    print('Single map to hotel: ${singleHotel.name}');
  }

  /// Run all examples
  static Future<void> runAllExamples() async {
    await exampleBackgroundProcessing();
    exampleDirectOperations();
    exampleFormatConversion();
  }
}
