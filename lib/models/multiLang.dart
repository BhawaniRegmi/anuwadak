class LanguageOption {
  final String languageCode;
  final String displayName;

  LanguageOption({required this.languageCode, required this.displayName});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageOption &&
          runtimeType == other.runtimeType &&
          languageCode == other.languageCode;

  @override
  int get hashCode => languageCode.hashCode;
}