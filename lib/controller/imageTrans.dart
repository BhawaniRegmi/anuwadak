import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_advertisement_example/models/image_translation_model.dart'; // Adjust import path

class ImageTranslationController extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  ImageTranslationState _state = ImageTranslationState();

  ImageTranslationState get state => _state;

  Future<void> selectImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _state = _state.copyWith(imagePath: pickedFile.path, originalText: null, translatedText: null);
        notifyListeners();
        // Simulate OCR and translation after image selection
        _performImageTranslation(pickedFile.path);
      }
    } catch (e) {
      _state = _state.copyWith(errorMessage: 'Failed to pick image: $e');
      notifyListeners();
    }
  }

  Future<void> captureImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _state = _state.copyWith(imagePath: pickedFile.path, originalText: null, translatedText: null);
        notifyListeners();
        // Simulate OCR and translation after image capture
        _performImageTranslation(pickedFile.path);
      }
    } catch (e) {
      _state = _state.copyWith(errorMessage: 'Failed to capture image: $e');
      notifyListeners();
    }
  }

  // Simulate the image translation process (OCR and translation API call)
  Future<void> _performImageTranslation(String imagePath) async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    // Simulate a delay for processing
    await Future.delayed(const Duration(seconds: 3));

    // Simulate OCR result
    final String simulatedOriginalText = _extractTextFromImage(imagePath);

    // Simulate translation result
    final String simulatedTranslatedText = _translateText(simulatedOriginalText, 'en', 'ne'); // Example: English to Nepali

    _state = _state.copyWith(
      originalText: simulatedOriginalText,
      translatedText: simulatedTranslatedText,
      isLoading: false,
    );
    notifyListeners();
  }

  // Mock OCR function (replace with actual OCR implementation)
  String _extractTextFromImage(String imagePath) {
    // In a real app, this would use a plugin like 'google_mlkit_text_recognition'
    print('Simulating OCR on image: $imagePath');
    return "This is some text in the image.";
  }

  // Mock translation function (replace with actual translation API call)
  String _translateText(String text, String sourceLanguage, String targetLanguage) {
    // In a real app, this would call a translation API (e.g., Google Translate API)
    print('Simulating translation of "$text" from $sourceLanguage to $targetLanguage');
    return "यो छविमा केही पाठ हो।"; // Nepali translation
  }
}