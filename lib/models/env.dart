import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKey => dotenv.env['SERPAPI_KEY'] ?? '';
  static String get baseUrl => 'https://serpapi.com';

  static Future<void> load() async {
    await dotenv.load();
  }
}
