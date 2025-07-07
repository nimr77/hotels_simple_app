import 'package:get_it/get_it.dart';
import 'package:hotel_app/logic/hotel_search/bloc.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/hotel_search/repo.dart';

final GetIt getIt = GetIt.instance;

class Setup {
  static Future<void> init() async {
    await initBlocs();
    await initFetchingData();
  }

  static Future<void> initBlocs() async {
    // Register HotelSearchRepository as a singleton
    getIt.registerLazySingleton<HotelSearchRepository>(
      () => HotelSearchRepository(),
    );

    // Register HotelSearchBloc as a singleton
    getIt.registerLazySingleton<HotelSearchBloc>(() => HotelSearchBloc());
  }

  static Future<void> initFetchingData() async {
    // Get the repository and bloc instances
    final repository = getIt<HotelSearchRepository>();
    final hotelSearchBloc = getIt<HotelSearchBloc>();

    // Try to get the last saved search query
    final lastSearchQuery = await repository.getLastSearchQuery();

    SearchQuery searchQuery;

    if (lastSearchQuery != null) {
      // Use the last saved search query
      searchQuery = lastSearchQuery;
    } else {
      // Create a default search query if no saved query exists
      searchQuery = SearchQuery(
        engine: 'google_hotels',
        q: 'Bali Resorts', // Default search term
        gl: 'us',
        hl: 'en',
        currency: 'USD',
        checkInDate: '2025-11-24',
        checkOutDate: '2025-11-25',
        adults: 2,
        children: 0,
      );
    }

    // Trigger initial data fetch with the search query
    hotelSearchBloc.add(HotelSearchRequested(searchQuery));
  }
}
