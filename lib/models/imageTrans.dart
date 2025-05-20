class ImageTranslationState {
  final String? imagePath;
  final String? originalText;
  final String? translatedText;
  final bool isLoading;
  final String? errorMessage;

  ImageTranslationState({
    this.imagePath,
    this.originalText,
    this.translatedText,
    this.isLoading = false,
    this.errorMessage,
  });

  ImageTranslationState copyWith({
    String? imagePath,
    String? originalText,
    String? translatedText,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ImageTranslationState(
      imagePath: imagePath ?? this.imagePath,
      originalText: originalText ?? this.originalText,
      translatedText: translatedText ?? this.translatedText,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}