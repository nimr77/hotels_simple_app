# Hotel App

A modern Flutter hotel search app using SerpAPI, BLoC/Provider architecture, and advanced UI/UX.

## Getting Started

### 1. Clone the repository
```sh
git clone <your-repo-url>
cd test_hotel_app
```

### 2. Install dependencies
```sh
flutter pub get
```

### 3. Set up the .env file
Create a `.env` file in the root directory with your SerpAPI key:

```
SERPAPI_KEY=your_serpapi_key_here
```

- You can get a free API key from [SerpAPI](https://serpapi.com/).
- The app loads this key at runtime for hotel search requests.

### 4. Run the app
```sh
flutter run
```

---

## App Structure

- **models/**: Data models (e.g., Hotel, SearchQuery) representing API and app data.
- **logic/repo/**: Repository classes for API, offline storage, and favorites (using SharedPreferences).
- **logic/providers/**: Providers and ValueNotifiers for state management (e.g., hotel search, favorites, language).
- **pages/**: UI pages (Home, Profile, etc.).
- **widgets/**: Reusable UI components (cards, avatar, etc.).
- **style/**: App-wide theming, paddings, and constants.

### State Management: ValueNotifier

- The app uses `ValueNotifier<T>` for lightweight, reactive state management in providers.
- UI widgets listen to changes using `ValueListenableBuilder`, rebuilding only when relevant data changes.
- This approach is simple, efficient, and avoids boilerplate compared to heavier state management solutions.

### Example: FavoriteProvider
```dart
final favoriteList = ValueNotifier<List<Hotel>>([]);

// Add/remove/check favorite
await provider.add(hotel);
await provider.remove(hotel);
bool isFav = provider.check(hotel);

// Listen in UI
ValueListenableBuilder(
  valueListenable: provider.favoriteList,
  builder: (context, favorites, _) {
    // ...
  },
)
```

---

## How the App Works (to be documented)

- Hotel search via SerpAPI
- Offline storage and favorites
- Language selection and localization
- UI/UX patterns and navigation

*More documentation coming soon...*

---

## Search Query Model

The `SearchQuery` model represents the parameters for a hotel search request. It encapsulates all the information needed to perform a search via SerpAPI and is used throughout the app for both online and offline queries.

**Fields:**
- `engine`: The search engine to use (e.g., 'google_hotels').
- `q`: The search query string (e.g., city, hotel name, etc.).
- `gl`: Geolocation/country code (e.g., 'us').
- `hl`: Language code (e.g., 'en').
- `currency`: Currency code (e.g., 'USD').
- `checkInDate`: Check-in date (YYYY-MM-DD).
- `checkOutDate`: Check-out date (YYYY-MM-DD).
- `adults`: Number of adults.
- `children`: Number of children.

**Usage:**
- The app builds a `SearchQuery` object when the user performs a search.
- The query is sent to the repository, which uses it to fetch results from SerpAPI.
- The last search query is saved locally for offline access and quick repeat searches.

**Example:**
```dart
final query = SearchQuery(
  engine: 'google_hotels',
  q: 'Paris Hotels',
  gl: 'fr',
  hl: 'fr',
  currency: 'EUR',
  checkInDate: '2025-12-01',
  checkOutDate: '2025-12-05',
  adults: 2,
  children: 0,
);
```

---
