class Country {
  final String name;
  final String? capital;
  final String? region;
  final String? flagUrl; // Optional, if you have flag images

  Country({
    required this.name,
    this.capital,
    this.region,
    this.flagUrl,
  });

  // Factory constructor to create a Country from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] as String,
      capital: json['capital'] != null && (json['capital'] as List).isNotEmpty
          ? json['capital'][0] as String
          : null,
      region: json['region'] as String?,
      // Assuming 'flags' field contains a map with 'png' or 'svg'
      flagUrl: json['flags'] != null ? json['flags']['png'] as String? : null,
    );
  }
}