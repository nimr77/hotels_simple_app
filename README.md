# Hotel App

A modern Flutter hotel search app using SerpAPI, BLoC/Provider architecture, and advanced UI/UX.

## Getting Started

### 1. Clone the repository
```sh
git clone git@github.com:nimr77/hotels_simple_app.git
cd test_hotel_app
```

### 2. Install dependencies
```sh
flutter pub get
```

### 3. Set up the .env file
Create a `.env` file at `assets/env/.env` (not just the root) with your SerpAPI key:

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

---

## Why ValueNotifier + Provider + getIt?

This app uses a combination of `ValueNotifier`, `Provider`, and `getIt` for state management and dependency injection. Here’s why:

- **ValueNotifier**: Provides a lightweight, reactive way to manage and listen to state changes. It’s ideal for simple state (like lists, loading flags, or a selected item) and avoids the boilerplate of more complex state management solutions.
- **Provider**: Makes it easy to expose and listen to `ValueNotifier` (or any class) throughout the widget tree. It enables widgets to rebuild only when relevant data changes, keeping the UI efficient and responsive.
- **getIt**: Handles dependency injection, so you can easily access your providers, repositories, and services from anywhere in the app without manual wiring or context passing.

### Why this approach?
- **Simplicity**: No need for streams, BLoC boilerplate, or heavy state management libraries for most app logic.
- **Performance**: Only widgets that depend on a `ValueNotifier` are rebuilt, minimizing unnecessary UI updates.
- **Testability**: Providers and repositories are easy to mock and test in isolation.
- **Scalability**: You can introduce more advanced patterns (like BLoC or Riverpod) later if needed, but for most business logic, this approach is fast and maintainable.

**Example:**
```dart
final provider = getIt<FavoriteProvider>();
ValueListenableBuilder(
  valueListenable: provider.favoriteList,
  builder: (context, favorites, _) {
    // ...
  },
)
```

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

### Why not use Provider everywhere?

In this app, most data (such as hotel search results, favorites, and language settings) is shared globally across the entire app. For this reason, we use `getIt` to register and access these providers and repositories as singletons, making them available everywhere without needing to pass them down the widget tree.

`Provider` is only used in cases where a provider's lifecycle should be tied to a specific page or subtree (for example, if you want to dispose of a provider when leaving a page). Since most of our state is global and should persist across navigation, we rarely need to use `Provider` for scoping or disposal.

This keeps the app simple and avoids unnecessary widget rebuilds or context passing, while still allowing for local state management with Provider when needed.

## Features

- **Smooth Animations**: The app uses Flutter Animate for beautiful, fluid transitions and effects throughout the UI.
- **Hero Animation**: Seamless shared element transitions between screens (e.g., hotel cards and avatars).
- **Glassmorphism**: Modern glass-like UI elements for a premium look.
- **GoRouter Navigation**: Robust navigation using GoRouter, supporting deep linking and flexible routing.
- **Adaptive Theme**: Automatically adapts to dark and light mode based on system settings.
- **Multi-language Support**: Easily switch between supported languages in the profile page.
- **Caching**: Offline storage of hotel search results and queries for fast, resilient access.
- **Error Handling**: User-friendly error messages and fallback UI for network or API issues.
- **Data Refresh**: Pull-to-refresh and automatic retry mechanisms to keep data up to date, even after errors.
- **Haptic Feedback**: Subtle haptic responses (using Gaimon) for enhanced user interaction.
