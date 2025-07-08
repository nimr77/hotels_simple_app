import 'dart:convert';

import 'package:flutter/foundation.dart';

class Hotel {
  final String name;
  final String source;
  final String sourceIcon;
  final String link;
  final String property_token;
  final String serpapi_property_details_link;
  final Map<String, double> gps_coordinates;
  final int hotelClass;
  final String thumbnail;
  final double overall_rating;
  final int reviews;
  final String price;
  final int extracted_price;
  final List<String> amenities;
  final bool free_cancellation;

  Hotel({
    required this.name,
    required this.source,
    required this.sourceIcon,
    required this.link,
    required this.property_token,
    required this.serpapi_property_details_link,
    required this.gps_coordinates,
    required this.hotelClass,
    required this.thumbnail,
    required this.overall_rating,
    required this.reviews,
    required this.price,
    required this.extracted_price,
    required this.amenities,
    required this.free_cancellation,
  });

  factory Hotel.fromJson(String source) => Hotel.fromMap(json.decode(source));

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'] ?? '',
      source: map['source'] ?? '',
      sourceIcon: map['sourceIcon'] ?? '',
      link: map['link'] ?? '',
      property_token: map['property_token'] ?? '',
      serpapi_property_details_link: map['serpapi_property_details_link'] ?? '',
      gps_coordinates: Map<String, double>.from(map['gps_coordinates']),
      hotelClass: map['hotelClass']?.toInt() ?? 0,
      thumbnail: map['thumbnail'] ?? '',
      overall_rating: map['overall_rating']?.toDouble() ?? 0.0,
      reviews: map['reviews']?.toInt() ?? 0,
      price: map['price'] ?? '',
      extracted_price: map['extracted_price']?.toInt() ?? 0,
      amenities: List<String>.from(map['amenities']),
      free_cancellation: map['free_cancellation'] ?? false,
    );
  }

  /// Calculate attractiveness score based on multiple factors
  double get attractivenessScore {
    double score = 0.0;

    // Rating factor (0-5 stars, weighted heavily)
    score += (overall_rating / 5.0) * 40.0;

    // Reviews factor (more reviews = more credibility)
    if (reviews > 0) {
      score += (reviews / 1000.0).clamp(0.0, 20.0); // Max 20 points for reviews
    }

    // Hotel class factor (stars, 1-5)
    score += (hotelClass / 5.0) * 25.0;

    // Amenities factor
    score += (amenities.length / 10.0).clamp(
      0.0,
      10.0,
    ); // Max 10 points for amenities

    // Free cancellation bonus
    if (free_cancellation) {
      score += 5.0;
    }

    return score.clamp(0.0, 100.0); // Ensure score is between 0-100
  }

  bool get hasAmenities => amenities.isNotEmpty;

  @override
  int get hashCode {
    return name.hashCode ^
        source.hashCode ^
        sourceIcon.hashCode ^
        link.hashCode ^
        property_token.hashCode ^
        serpapi_property_details_link.hashCode ^
        gps_coordinates.hashCode ^
        hotelClass.hashCode ^
        thumbnail.hashCode ^
        overall_rating.hashCode ^
        reviews.hashCode ^
        price.hashCode ^
        extracted_price.hashCode ^
        amenities.hashCode ^
        free_cancellation.hashCode;
  }

  bool get hasReviews => reviews > 0;

  /// Check if hotel is highly attractive (score >= 70)
  bool get isHighlyAttractive => attractivenessScore >= 70.0;

  /// Check if hotel is moderately attractive (score >= 50)
  bool get isModeratelyAttractive => attractivenessScore >= 50.0;

  double get latitude => gps_coordinates['latitude'] ?? 0.0;

  double get longitude => gps_coordinates['longitude'] ?? 0.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hotel &&
        other.name == name &&
        other.source == source &&
        other.sourceIcon == sourceIcon &&
        other.link == link &&
        other.property_token == property_token &&
        other.serpapi_property_details_link == serpapi_property_details_link &&
        mapEquals(other.gps_coordinates, gps_coordinates) &&
        other.hotelClass == hotelClass &&
        other.thumbnail == thumbnail &&
        other.overall_rating == overall_rating &&
        other.reviews == reviews &&
        other.price == price &&
        other.extracted_price == extracted_price &&
        listEquals(other.amenities, amenities) &&
        other.free_cancellation == free_cancellation;
  }

  Hotel copyWith({
    String? name,
    String? source,
    String? sourceIcon,
    String? link,
    String? property_token,
    String? serpapi_property_details_link,
    Map<String, double>? gps_coordinates,
    int? hotelClass,
    String? thumbnail,
    double? overall_rating,
    int? reviews,
    String? price,
    int? extracted_price,
    List<String>? amenities,
    bool? free_cancellation,
  }) {
    return Hotel(
      name: name ?? this.name,
      source: source ?? this.source,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      link: link ?? this.link,
      property_token: property_token ?? this.property_token,
      serpapi_property_details_link:
          serpapi_property_details_link ?? this.serpapi_property_details_link,
      gps_coordinates: gps_coordinates ?? this.gps_coordinates,
      hotelClass: hotelClass ?? this.hotelClass,
      thumbnail: thumbnail ?? this.thumbnail,
      overall_rating: overall_rating ?? this.overall_rating,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      extracted_price: extracted_price ?? this.extracted_price,
      amenities: amenities ?? this.amenities,
      free_cancellation: free_cancellation ?? this.free_cancellation,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'source': source});
    result.addAll({'sourceIcon': sourceIcon});
    result.addAll({'link': link});
    result.addAll({'property_token': property_token});
    result.addAll({
      'serpapi_property_details_link': serpapi_property_details_link,
    });
    result.addAll({'gps_coordinates': gps_coordinates});
    result.addAll({'hotelClass': hotelClass});
    result.addAll({'thumbnail': thumbnail});
    result.addAll({'overall_rating': overall_rating});
    result.addAll({'reviews': reviews});
    result.addAll({'price': price});
    result.addAll({'extracted_price': extracted_price});
    result.addAll({'amenities': amenities});
    result.addAll({'free_cancellation': free_cancellation});

    return result;
  }

  @override
  String toString() {
    return 'Hotel(name: $name, source: $source, sourceIcon: $sourceIcon, link: $link, property_token: $property_token, serpapi_property_details_link: $serpapi_property_details_link, gps_coordinates: $gps_coordinates, hotelClass: $hotelClass, thumbnail: $thumbnail, overall_rating: $overall_rating, reviews: $reviews, price: $price, extracted_price: $extracted_price, amenities: $amenities, free_cancellation: $free_cancellation)';
  }
}
