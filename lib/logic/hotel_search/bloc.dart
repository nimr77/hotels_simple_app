import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/logic/hotel_search/models/brand.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel_search_response.dart';
import 'package:hotel_app/logic/hotel_search/models/search_information.dart';
import 'package:hotel_app/logic/hotel_search/models/search_metadata.dart';
import 'package:hotel_app/logic/hotel_search/models/search_parameters.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';
import 'package:hotel_app/logic/hotel_search/utils/hotel_attractiveness_utils.dart';

import 'repo.dart';

class HotelSearchBloc extends Bloc<HotelSearchEvent, HotelSearchState> {
  final repository = HotelSearchRepository();
  bool _isLoading = false;

  HotelSearchBloc() : super(HotelSearchInitial()) {
    on<HotelSearchRequested>((event, emit) async {
      _isLoading = true;
      emit(HotelSearchLoading());

      try {
        // Save the search query for future reference
        await repository.saveSearchQuery(event.query);

        // Try to get data from API
        final response = await repository.searchHotels(event.query);

        // Save successful response to offline storage
        await repository.saveHotels(response);

        _isLoading = false;
        // Emit success with online data
        emit(HotelSearchSuccess(response, isOfflineData: false));
      } catch (e) {
        // If API fails, try to get offline data
        try {
          final offlineResponse = await repository.getOfflineHotels();
          if (offlineResponse != null) {
            _isLoading = false;
            // Emit success with offline data
            emit(HotelSearchSuccess(offlineResponse, isOfflineData: true));
          } else {
            _isLoading = false;
            // No offline data available, emit error
            emit(HotelSearchError(e.toString()));
          }
        } catch (offlineError) {
          _isLoading = false;
          // Both API and offline failed, emit original error
          emit(HotelSearchError(e.toString()));
        }
      }
    });
  }

  bool get isLoading => _isLoading;

  /// Get default search query from repository
  SearchQuery getDefaultSearchQuery() {
    return repository.getDefaultSearchQuery();
  }

  /// Get highly attractive hotels (score >= 70)
  List<Hotel> getHighlyAttractiveHotels() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getHighlyAttractiveHotelsFromObjects(
      hotels,
    );
  }

  /// Get hotels by price range
  List<Hotel> getHotelsByPriceRange({int? minPrice, int? maxPrice}) {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getHotelsByPriceRangeFromObjects(
      hotels,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  /// Get hotels with free cancellation
  List<Hotel> getHotelsWithFreeCancellation() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getHotelsWithFreeCancellationFromObjects(
      hotels,
    );
  }

  /// Get luxury hotels (4-5 stars)
  List<Hotel> getLuxuryHotels() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getLuxuryHotelsFromObjects(hotels);
  }

  /// Get moderately attractive hotels (score >= 50)
  List<Hotel> getModeratelyAttractiveHotels() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getModeratelyAttractiveHotelsFromObjects(
      hotels,
    );
  }

  /// Get the most attractive hotels sorted by attractiveness score
  List<Hotel> getMostAttractiveHotels({int limit = 10}) {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getMostAttractiveHotelsFromObjects(
      hotels,
      limit: limit,
    );
  }

  /// Get top rated hotels (by overall rating)
  List<Hotel> getTopRatedHotels({int limit = 10}) {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getTopRatedHotelsFromObjects(
      hotels,
      limit: limit,
    );
  }
}

class HotelSearchError extends HotelSearchState {
  final String message;

  const HotelSearchError(this.message) : super(isLoading: false);
}

// Events
abstract class HotelSearchEvent {}

class HotelSearchInitial extends HotelSearchState {
  const HotelSearchInitial() : super(isLoading: false);
}

class HotelSearchLoading extends HotelSearchState {
  const HotelSearchLoading() : super(isLoading: true);
}

class HotelSearchRequested extends HotelSearchEvent {
  final SearchQuery query;
  HotelSearchRequested(this.query);
}

// States
abstract class HotelSearchState {
  final bool isLoading;

  const HotelSearchState({this.isLoading = false});
}

class HotelSearchSuccess extends HotelSearchState {
  final HotelSearchResponse response;
  final bool isOfflineData;

  const HotelSearchSuccess(this.response, {required this.isOfflineData})
    : super(isLoading: false);

  List<Brand> get brands => response.brands;
  // Convenience getters for easy access to data
  List<Hotel> get hotels => response.hotels;
  SearchMetadata get metadata => response.searchMetadata;
  SearchInformation get searchInfo => response.searchInformation;
  SearchParameters get searchParams => response.searchParameters;
}
