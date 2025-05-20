class CulturalContextResult {
  final String originalText;
  final String translatedText;
  final String? culturalNote;
  final List<String>? alternativePhrases;

  CulturalContextResult({
    required this.originalText,
    required this.translatedText,
    this.culturalNote,
    this.alternativePhrases,
  });
}

