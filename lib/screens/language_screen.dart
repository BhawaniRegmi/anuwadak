// lib/language_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import generated localizations
import 'main.dart'; // Import main.dart to access MyApp.of(context)

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access localized strings
    final localizations = AppLocalizations.of(context)!;

    // Define the list of supported locales for display
    // You can customize these names to be more user-friendly
    final List<Map<String, String>> languages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'es', 'name': 'Español'},
      // Add more languages as needed, ensuring you have corresponding .arb files
      // {'code': 'fr', 'name': 'Français'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.languageSelectionTitle), // Localized title for the screen
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              title: Text(
                lang['name']!,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              trailing: Theme.of(context).platform == TargetPlatform.iOS
                  ? const Icon(Icons.arrow_forward_ios, size: 18.0)
                  : const Icon(Icons.arrow_right, size: 24.0),
              onTap: () {
                // Get the MyAppState and call setLocale to change the app's language
                MyApp.of(context)?.setLocale(Locale(lang['code']!));
                // Navigate back to the previous screen (e.g., MyHomePage)
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}