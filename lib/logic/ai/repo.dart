import 'package:genui/genui.dart';
import 'package:genui_firebase_ai/genui_firebase_ai.dart';
import 'package:hotel_app/logic/hotel_search/models/hotel.dart';

class AIProvider {
  late final GenUiManager _genUiManager;
  late final GenUiConversation _genUiConversation;
  final Hotel hotel;
  AIProvider(this.hotel) {
    _genUiManager = GenUiManager(catalog: CoreCatalogItems.asCatalog());
  }

  void dispose() {
    _genUiConversation.dispose();
    _genUiManager.dispose();
  }

  void generate({
    required void Function(SurfaceAdded surface) onSurfaceAdded,
    required void Function(ContentGeneratorError error) onError,
    required void Function(SurfaceUpdated) onSurfaceUpdated,
  }) {
    // generate the description for the hotel
    final contentGenerator = FirebaseAiContentGenerator(
      catalog: CoreCatalogItems.asCatalog(),
      systemInstruction:
          '''
            You are a helpful assistant that generates engaging and informative hotel descriptions for users looking to book accommodations. Your descriptions should highlight the unique features, amenities, and attractions of the hotel, while also providing useful information about the location and nearby points of interest.
            When generating the description, consider the following aspects:
            1. Location: Describe the hotel's location, including proximity to popular attractions, transportation options, and local culture.
            2. Amenities: Highlight key amenities such as pools, spas, fitness centers, dining options, and room features.
            3. Unique Selling Points: Emphasize what makes the hotel stand out from others in the area.
            4. Target Audience: Tailor the description to appeal to the intended audience, whether it's families, business travelers, couples, or solo adventurers.
            5. Tone: Use a friendly and inviting tone that encourages potential guests to choose this hotel for their stay.
            Ensure that the description is concise, engaging, and free of any promotional language or exaggerations.

            Here is the information about the hotel:
            Name: ${hotel.toMap().toString()}

            You will make one Widget that has the description of the hotel. bold for some parts. and good design
        ''',
    );
    _genUiConversation = GenUiConversation(
      contentGenerator: contentGenerator,
      genUiManager: _genUiManager,
      onSurfaceAdded: onSurfaceAdded,
      onError: onError,
      onSurfaceUpdated: onSurfaceUpdated,
    );
  }
}
