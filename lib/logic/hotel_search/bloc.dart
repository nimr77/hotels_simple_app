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

// Background processing type enum
enum BackgroundProcessingType {
  highlyAttractive,
  mostAttractive,
  luxury,
  priceRange,
  freeCancellation,
  topRated,
  moderatelyAttractive,
}

// Background processing events
class GetHighlyAttractiveHotelsRequested extends HotelSearchEvent {}

class GetHotelsByPriceRangeRequested extends HotelSearchEvent {
  final int? minPrice;
  final int? maxPrice;
  GetHotelsByPriceRangeRequested({this.minPrice, this.maxPrice});
}

class GetHotelsWithFreeCancellationRequested extends HotelSearchEvent {}

class GetLuxuryHotelsRequested extends HotelSearchEvent {}

class GetModeratelyAttractiveHotelsRequested extends HotelSearchEvent {}

class GetMostAttractiveHotelsRequested extends HotelSearchEvent {
  final int limit;
  GetMostAttractiveHotelsRequested({this.limit = 10});
}

class GetTopRatedHotelsRequested extends HotelSearchEvent {
  final int limit;
  GetTopRatedHotelsRequested({this.limit = 10});
}

class HotelSearchBackgroundError extends HotelSearchState {
  final HotelSearchResponse response;
  final bool isOfflineData;
  final String error;
  final BackgroundProcessingType processingType;

  const HotelSearchBackgroundError({
    required this.response,
    required this.isOfflineData,
    required this.error,
    required this.processingType,
  }) : super(isLoading: false);

  List<Brand> get brands => response.brands;
  List<Hotel> get hotels => response.hotels;
  SearchMetadata get metadata => response.searchMetadata;
  SearchInformation get searchInfo => response.searchInformation;
  SearchParameters get searchParams => response.searchParameters;
}

// Background processing states
class HotelSearchBackgroundProcessing extends HotelSearchState {
  final HotelSearchResponse response;
  final bool isOfflineData;
  final BackgroundProcessingType processingType;
  final int? limit;
  final int? minPrice;
  final int? maxPrice;

  const HotelSearchBackgroundProcessing({
    required this.response,
    required this.isOfflineData,
    required this.processingType,
    this.limit,
    this.minPrice,
    this.maxPrice,
  }) : super(isLoading: true);

  List<Brand> get brands => response.brands;
  List<Hotel> get hotels => response.hotels;
  SearchMetadata get metadata => response.searchMetadata;
  SearchInformation get searchInfo => response.searchInformation;
  SearchParameters get searchParams => response.searchParameters;
}

class HotelSearchBackgroundSuccess extends HotelSearchState {
  final HotelSearchResponse response;
  final bool isOfflineData;
  final List<Hotel> processedHotels;
  final BackgroundProcessingType processingType;

  const HotelSearchBackgroundSuccess({
    required this.response,
    required this.isOfflineData,
    required this.processedHotels,
    required this.processingType,
  }) : super(isLoading: false);

  List<Brand> get brands => response.brands;
  List<Hotel> get hotels => response.hotels;
  SearchMetadata get metadata => response.searchMetadata;
  SearchInformation get searchInfo => response.searchInformation;
  SearchParameters get searchParams => response.searchParameters;
}

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

    // Background processing events
    on<GetHighlyAttractiveHotelsRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.highlyAttractive,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getHighlyAttractiveHotelsInBackground(
              hotelMaps,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.highlyAttractive,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.highlyAttractive,
          ),
        );
      }
    });

    on<GetMostAttractiveHotelsRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.mostAttractive,
          limit: event.limit,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getMostAttractiveHotelsInBackground(
              hotelMaps,
              limit: event.limit,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.mostAttractive,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.mostAttractive,
          ),
        );
      }
    });

    on<GetLuxuryHotelsRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.luxury,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getLuxuryHotelsInBackground(
              hotelMaps,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.luxury,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.luxury,
          ),
        );
      }
    });

    on<GetHotelsByPriceRangeRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.priceRange,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getHotelsByPriceRangeInBackground(
              hotelMaps,
              minPrice: event.minPrice,
              maxPrice: event.maxPrice,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.priceRange,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.priceRange,
          ),
        );
      }
    });

    on<GetHotelsWithFreeCancellationRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.freeCancellation,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getHotelsWithFreeCancellationInBackground(
              hotelMaps,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.freeCancellation,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.freeCancellation,
          ),
        );
      }
    });

    on<GetTopRatedHotelsRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.topRated,
          limit: event.limit,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getTopRatedHotelsInBackground(
              hotelMaps,
              limit: event.limit,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.topRated,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.topRated,
          ),
        );
      }
    });

    on<GetModeratelyAttractiveHotelsRequested>((event, emit) async {
      if (state is! HotelSearchSuccess) return;

      final currentState = state as HotelSearchSuccess;
      emit(
        HotelSearchBackgroundProcessing(
          response: currentState.response,
          isOfflineData: currentState.isOfflineData,
          processingType: BackgroundProcessingType.moderatelyAttractive,
        ),
      );

      try {
        final hotelMaps = HotelAttractivenessUtils.hotelsToMaps(
          currentState.hotels,
        );
        final resultMaps =
            await HotelAttractivenessUtils.getModeratelyAttractiveHotelsInBackground(
              hotelMaps,
            );
        final resultHotels = HotelAttractivenessUtils.mapsToHotels(resultMaps);

        emit(
          HotelSearchBackgroundSuccess(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            processedHotels: resultHotels,
            processingType: BackgroundProcessingType.moderatelyAttractive,
          ),
        );
      } catch (e) {
        emit(
          HotelSearchBackgroundError(
            response: currentState.response,
            isOfflineData: currentState.isOfflineData,
            error: e.toString(),
            processingType: BackgroundProcessingType.moderatelyAttractive,
          ),
        );
      }
    });
  }

  /// Get background processing error message
  String? get backgroundError {
    if (state is HotelSearchBackgroundError) {
      return (state as HotelSearchBackgroundError).error;
    }
    return null;
  }

  /// Check if background processing failed
  bool get isBackgroundError => state is HotelSearchBackgroundError;

  /// Check if background processing is in progress
  bool get isBackgroundProcessing => state is HotelSearchBackgroundProcessing;

  /// Check if background processing was successful
  bool get isBackgroundSuccess => state is HotelSearchBackgroundSuccess;

  bool get isLoading => _isLoading;

  /// Get background processing type
  BackgroundProcessingType? getBackgroundProcessingType() {
    if (state is HotelSearchBackgroundProcessing) {
      return (state as HotelSearchBackgroundProcessing).processingType;
    }
    if (state is HotelSearchBackgroundSuccess) {
      return (state as HotelSearchBackgroundSuccess).processingType;
    }
    if (state is HotelSearchBackgroundError) {
      return (state as HotelSearchBackgroundError).processingType;
    }
    return null;
  }

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

  /// Get highly attractive hotels in background
  void getHighlyAttractiveHotelsInBackground() {
    add(GetHighlyAttractiveHotelsRequested());
  }

  // Background processing methods (trigger events for background processing)

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

  /// Get hotels by price range in background
  void getHotelsByPriceRangeInBackground({int? minPrice, int? maxPrice}) {
    add(GetHotelsByPriceRangeRequested(minPrice: minPrice, maxPrice: maxPrice));
  }

  /// Get hotels with free cancellation
  List<Hotel> getHotelsWithFreeCancellation() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getHotelsWithFreeCancellationFromObjects(
      hotels,
    );
  }

  /// Get hotels with free cancellation in background
  void getHotelsWithFreeCancellationInBackground() {
    add(GetHotelsWithFreeCancellationRequested());
  }

  /// Get luxury hotels (4-5 stars)
  List<Hotel> getLuxuryHotels() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getLuxuryHotelsFromObjects(hotels);
  }

  /// Get luxury hotels in background
  void getLuxuryHotelsInBackground() {
    add(GetLuxuryHotelsRequested());
  }

  /// Get moderately attractive hotels (score >= 50)
  List<Hotel> getModeratelyAttractiveHotels() {
    if (state is! HotelSearchSuccess) return [];

    final hotels = (state as HotelSearchSuccess).hotels;
    return HotelAttractivenessUtils.getModeratelyAttractiveHotelsFromObjects(
      hotels,
    );
  }

  // Helper methods to get processed results from background states

  /// Get moderately attractive hotels in background
  void getModeratelyAttractiveHotelsInBackground() {
    add(GetModeratelyAttractiveHotelsRequested());
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

  /// Get most attractive hotels in background
  void getMostAttractiveHotelsInBackground({int limit = 10}) {
    add(GetMostAttractiveHotelsRequested(limit: limit));
  }

  /// Get processed hotels from background success state
  List<Hotel> getProcessedHotels() {
    if (state is HotelSearchBackgroundSuccess) {
      return (state as HotelSearchBackgroundSuccess).processedHotels;
    }
    return [];
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

  /// Get top rated hotels in background
  void getTopRatedHotelsInBackground({int limit = 10}) {
    add(GetTopRatedHotelsRequested(limit: limit));
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
