import 'package:get_it/get_it.dart';
import 'package:hotel_app/logic/hotel_search/bloc.dart';
import 'package:hotel_app/logic/hotel_search/models/search_query.dart';
import 'package:hotel_app/logic/hotel_search/repo.dart';
import 'package:hotel_app/logic/language/bloc.dart';

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

    // Register LanguageBloc as a singleton
    getIt.registerLazySingleton<LanguageBloc>(() => LanguageBloc());
  }

  static Future<void> initFetchingData() async {
    // Get the repository and bloc instances
    final repository = getIt<HotelSearchRepository>();
    final hotelSearchBloc = getIt<HotelSearchBloc>();

    // Initialize language bloc
    final languageBloc = getIt<LanguageBloc>();
    await languageBloc.init();

    // Try to get the last saved search query
    final lastSearchQuery = await repository.getLastSearchQuery();

    SearchQuery searchQuery;

    if (lastSearchQuery != null) {
      // Use the last saved search query
      searchQuery = lastSearchQuery;
    } else {
      // Use the default search query from repository
      searchQuery = repository.getDefaultSearchQuery();
    }

    // Trigger initial data fetch with the search query
    hotelSearchBloc.add(HotelSearchRequested(searchQuery));
  }
}
