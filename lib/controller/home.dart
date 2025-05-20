import 'package:anuwadak/models/language_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslationController {
  List<Language> supportedLanguages = [];

  // Replace with your actual API endpoint and key
  final String _apiKey = 'YOUR_API_KEY';
  final String _baseUrl = 'YOUR_API_BASE_URL';

  TranslationController() {
    // Initialize with some default languages (for demonstration)
    supportedLanguages = [
      Language(code: 'en', name: 'English'),
      Language(code: 'ne', name: 'Nepali'),
      Language(code: 'hi', name: 'Hindi'),
      // Add more languages as needed
    ];
  }

  // In a real app, this would fetch supported languages from the API
  Future<void> fetchSupportedLanguages() async {
    // Simulate fetching languages
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real scenario, you would make an API call here
    // and populate the supportedLanguages list.
  }

  Future<String?> translate(
      String text, String sourceLanguageCode, String targetLanguageCode) async {
    // Replace this with your actual API call
    // Example using a hypothetical API:
    try {
      final Uri uri = Uri.parse('$_baseUrl/translate');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'q': text,
          'source': sourceLanguageCode,
          'target': targetLanguageCode,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['translatedText']; // Adjust based on your API response
      } else {
        print('Translation API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error during translation: $e');
      return null;
    }
  }
}