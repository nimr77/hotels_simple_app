import 'package:get_it/get_it.dart';
import 'package:hotel_app/logic/favorite/provider.dart';
import 'package:hotel_app/logic/hotel_search/provider.dart';
import 'package:hotel_app/logic/language/provider.dart';

final GetIt getIt = GetIt.instance;

class Setup {
  static Future<void> init() async {
    await initServices();
    await initFetchingData();
  }

  static Future<void> initFetchingData() async {
    // Get the repository and bloc instances
    final hotelSearchProvider = getIt<HotelsSearchProvider>();

    // Initialize language
    final languageProvider = getIt<LanguageProvider>();

    final favoriteProvider = getIt<FavoriteProvider>();
    await Future.wait([
      languageProvider.init(),
      hotelSearchProvider.init(),
      favoriteProvider.init(),
    ]);

    hotelSearchProvider.loadHotels();
  }

  static Future<void> initServices() async {
    // Register HotelSearchBloc as a singleton
    getIt.registerLazySingleton<HotelsSearchProvider>(
      () => HotelsSearchProvider(),
    );

    // Register LanguageBloc as a singleton
    getIt.registerLazySingleton<LanguageProvider>(() => LanguageProvider());

    getIt.registerLazySingleton(() => FavoriteProvider());
  }
}
