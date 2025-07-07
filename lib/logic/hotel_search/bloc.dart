import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/logic/hotel_search/models/brand.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel_search_response.dart';
import 'package:hotel_app/logic/hotel_search/models/search_information.dart';
import 'package:hotel_app/logic/hotel_search/models/search_metadata.dart';
import 'package:hotel_app/logic/hotel_search/models/search_parameters.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/hotel_search/models/search_results_hotels.dart';

import 'repo.dart';

class HotelSearchBloc extends Bloc<HotelSearchEvent, HotelSearchState> {
  final repository = HotelSearchRepository();
  HotelSearchBloc() : super(HotelSearchInitial()) {
    on<HotelSearchRequested>((event, emit) async {
      emit(HotelSearchLoading());
      try {
        // Try to get data from API
        final response = await repository.searchHotels(event.query);

        // Save successful response to offline storage
        await repository.saveHotels(response);

        // Emit success with online data
        emit(HotelSearchSuccess(response, isOfflineData: false));
      } catch (e) {
        // If API fails, try to get offline data
        try {
          final offlineResponse = await repository.getOfflineHotels();
          if (offlineResponse != null) {
            // Emit success with offline data
            emit(HotelSearchSuccess(offlineResponse, isOfflineData: true));
          } else {
            // No offline data available, emit error
            emit(HotelSearchError(e.toString()));
          }
        } catch (offlineError) {
          // Both API and offline failed, emit original error
          emit(HotelSearchError(e.toString()));
        }
      }
    });
  }
}

class HotelSearchError extends HotelSearchState {
  final String message;
  HotelSearchError(this.message);
}

// Events
abstract class HotelSearchEvent {}

class HotelSearchInitial extends HotelSearchState {}

class HotelSearchLoading extends HotelSearchState {}

class HotelSearchRequested extends HotelSearchEvent {
  final SearchQuery query;
  HotelSearchRequested(this.query);
}

// States
abstract class HotelSearchState {}

class HotelSearchSuccess extends HotelSearchState {
  final HotelSearchResponse response;
  final bool isOfflineData;

  HotelSearchSuccess(this.response, {required this.isOfflineData});

  List<Brand> get brands => response.brands;
  // Convenience getters for easy access to data
  List<Hotel> get hotels => response.hotels;
  SearchMetadata get metadata => response.searchMetadata;
  SearchInformation get searchInfo => response.searchInformation;
  SearchParameters get searchParams => response.searchParameters;
}
