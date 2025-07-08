import 'dart:convert';

import 'brand.dart';
import 'hotel.dart';
import 'search_information.dart';
import 'search_metadata.dart';
import 'search_parameters.dart';

class HotelSearchResponse {
  final SearchMetadata searchMetadata;
  final SearchParameters searchParameters;
  final SearchInformation searchInformation;
  final List<Brand> brands;
  final List<Hotel> hotels;

  HotelSearchResponse({
    required this.searchMetadata,
    required this.searchParameters,
    required this.searchInformation,
    required this.brands,
    required this.hotels,
  });

  factory HotelSearchResponse.fromJson(String source) =>
      HotelSearchResponse.fromMap(json.decode(source));

  factory HotelSearchResponse.fromMap(Map<String, dynamic> map) {
    return HotelSearchResponse(
      searchMetadata: SearchMetadata.fromMap(map['search_metadata'] ?? {}),
      searchParameters: SearchParameters.fromMap(
        map['search_parameters'] ?? {},
      ),
      searchInformation: SearchInformation.fromMap(
        map['search_information'] ?? {},
      ),
      brands: List<Brand>.from(
        (map['brands'] ?? []).map((x) => Brand.fromMap(x)),
      ),
      hotels: List<Hotel>.from((map['ads'] ?? []).map((x) => Hotel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'search_metadata': searchMetadata.toMap(),
      'search_parameters': searchParameters.toMap(),
      'search_information': searchInformation.toMap(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'ads': hotels.map((x) => x.toMap()).toList(),
    };
  }
}
