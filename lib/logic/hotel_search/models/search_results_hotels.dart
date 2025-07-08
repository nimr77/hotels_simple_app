import 'dart:convert';

import 'package:flutter/foundation.dart';

class Hotel {
  final String name;
  final String source;
  final String sourceIcon;
  final String link;
  final String propertyToken;
  final String serpapiPropertyDetailsLink;
  final Map<String, double> gpsCoordinates;
  final int hotelClass;
  final String thumbnail;
  final double overallRating;
  final int reviews;
  final String price;
  final int extractedPrice;
  final List<String> amenities;
  final bool freeCancellation;
  Hotel({
    required this.name,
    required this.source,
    required this.sourceIcon,
    required this.link,
    required this.propertyToken,
    required this.serpapiPropertyDetailsLink,
    required this.gpsCoordinates,
    required this.hotelClass,
    required this.thumbnail,
    required this.overallRating,
    required this.reviews,
    required this.price,
    required this.extractedPrice,
    required this.amenities,
    required this.freeCancellation,
  });

  factory Hotel.fromJson(String source) => Hotel.fromMap(json.decode(source));

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      name: map['name'] ?? '',
      source: map['source'] ?? '',
      sourceIcon: map['sourceIcon'] ?? '',
      link: map['link'] ?? '',
      propertyToken: map['propertyToken'] ?? '',
      serpapiPropertyDetailsLink: map['serpapiPropertyDetailsLink'] ?? '',
      gpsCoordinates: Map<String, double>.from(map['gpsCoordinates']),
      hotelClass: map['hotelClass']?.toInt() ?? 0,
      thumbnail: map['thumbnail'] ?? '',
      overallRating: map['overallRating']?.toDouble() ?? 0.0,
      reviews: map['reviews']?.toInt() ?? 0,
      price: map['price'] ?? '',
      extractedPrice: map['extractedPrice']?.toInt() ?? 0,
      amenities: List<String>.from(map['amenities']),
      freeCancellation: map['freeCancellation'] ?? false,
    );
  }

  /// Calculate attractiveness score based on multiple factors
  double get attractivenessScore {
    double score = 0.0;

    // Rating factor (0-5 stars, weighted heavily)
    score += (overallRating / 5.0) * 40.0;

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
    if (freeCancellation) {
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
        propertyToken.hashCode ^
        serpapiPropertyDetailsLink.hashCode ^
        gpsCoordinates.hashCode ^
        hotelClass.hashCode ^
        thumbnail.hashCode ^
        overallRating.hashCode ^
        reviews.hashCode ^
        price.hashCode ^
        extractedPrice.hashCode ^
        amenities.hashCode ^
        freeCancellation.hashCode;
  }

  bool get hasReviews => reviews > 0;

  /// Check if hotel is highly attractive (score >= 70)
  bool get isHighlyAttractive => attractivenessScore >= 70.0;

  /// Check if hotel is moderately attractive (score >= 50)
  bool get isModeratelyAttractive => attractivenessScore >= 50.0;

  double get latitude => gpsCoordinates['latitude'] ?? 0.0;

  double get longitude => gpsCoordinates['longitude'] ?? 0.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hotel &&
        other.name == name &&
        other.source == source &&
        other.sourceIcon == sourceIcon &&
        other.link == link &&
        other.propertyToken == propertyToken &&
        other.serpapiPropertyDetailsLink == serpapiPropertyDetailsLink &&
        mapEquals(other.gpsCoordinates, gpsCoordinates) &&
        other.hotelClass == hotelClass &&
        other.thumbnail == thumbnail &&
        other.overallRating == overallRating &&
        other.reviews == reviews &&
        other.price == price &&
        other.extractedPrice == extractedPrice &&
        listEquals(other.amenities, amenities) &&
        other.freeCancellation == freeCancellation;
  }

  Hotel copyWith({
    String? name,
    String? source,
    String? sourceIcon,
    String? link,
    String? propertyToken,
    String? serpapiPropertyDetailsLink,
    Map<String, double>? gpsCoordinates,
    int? hotelClass,
    String? thumbnail,
    double? overallRating,
    int? reviews,
    String? price,
    int? extractedPrice,
    List<String>? amenities,
    bool? freeCancellation,
  }) {
    return Hotel(
      name: name ?? this.name,
      source: source ?? this.source,
      sourceIcon: sourceIcon ?? this.sourceIcon,
      link: link ?? this.link,
      propertyToken: propertyToken ?? this.propertyToken,
      serpapiPropertyDetailsLink:
          serpapiPropertyDetailsLink ?? this.serpapiPropertyDetailsLink,
      gpsCoordinates: gpsCoordinates ?? this.gpsCoordinates,
      hotelClass: hotelClass ?? this.hotelClass,
      thumbnail: thumbnail ?? this.thumbnail,
      overallRating: overallRating ?? this.overallRating,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      extractedPrice: extractedPrice ?? this.extractedPrice,
      amenities: amenities ?? this.amenities,
      freeCancellation: freeCancellation ?? this.freeCancellation,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'source': source});
    result.addAll({'sourceIcon': sourceIcon});
    result.addAll({'link': link});
    result.addAll({'propertyToken': propertyToken});
    result.addAll({'serpapiPropertyDetailsLink': serpapiPropertyDetailsLink});
    result.addAll({'gpsCoordinates': gpsCoordinates});
    result.addAll({'hotelClass': hotelClass});
    result.addAll({'thumbnail': thumbnail});
    result.addAll({'overallRating': overallRating});
    result.addAll({'reviews': reviews});
    result.addAll({'price': price});
    result.addAll({'extractedPrice': extractedPrice});
    result.addAll({'amenities': amenities});
    result.addAll({'freeCancellation': freeCancellation});

    return result;
  }

  @override
  String toString() {
    return 'SearchResultsHotel(name: $name, source: $source, sourceIcon: $sourceIcon, link: $link, propertyToken: $propertyToken, serpapiPropertyDetailsLink: $serpapiPropertyDetailsLink, gpsCoordinates: $gpsCoordinates, hotelClass: $hotelClass, thumbnail: $thumbnail, overallRating: $overallRating, reviews: $reviews, price: $price, extractedPrice: $extractedPrice, amenities: $amenities, freeCancellation: $freeCancellation)';
  }
}
