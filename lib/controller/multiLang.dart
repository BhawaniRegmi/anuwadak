import 'package:flutter/material.dart';
import 'multilingual_interface_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultilingualInterfaceController extends ChangeNotifier {
  final List<LanguageOption> supportedLanguages = [
    LanguageOption(languageCode: 'en', displayName: 'English'),
    LanguageOption(languageCode: 'es', displayName: 'Spanish'),
    LanguageOption(languageCode: 'ja', displayName: 'Japanese'),
    LanguageOption(languageCode: 'fr', displayName: 'French'),
    LanguageOption(languageCode: 'ne', displayName: 'Nepali'),
  ];

  LanguageOption? _currentLanguage;

  LanguageOption? get currentLanguage => _currentLanguage;

  MultilingualInterfaceController() {
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString('app_language');
    if (savedLanguageCode != null) {
      _currentLanguage = supportedLanguages.firstWhere(
          (lang) => lang.languageCode == savedLanguageCode,
          orElse: () => supportedLanguages.first); // Default to English if not found
    } else {
      _currentLanguage = supportedLanguages.first; // Default to English on first launch
    }
    notifyListeners();
  }

  Future<void> setCurrentLanguage(LanguageOption? newLanguage) async {
    if (newLanguage != null && _currentLanguage != newLanguage) {
      _currentLanguage = newLanguage;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_language', newLanguage.languageCode);
      // In a real app, you would likely trigger a rebuild of the entire UI
      // or use a localization package to update the displayed text.
    }
  }
}