class PromoModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String callToAction;
  final String? deepLink; // Optional deep link for the promo

  PromoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.callToAction,
    this.deepLink,
  });

  // Factory constructor for creating a PromoModel from a JSON map
  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      callToAction: json['callToAction'] as String,
      deepLink: json['deepLink'] as String?,
    );
  }

  // Method to convert PromoModel to a JSON map (useful for API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'callToAction': callToAction,
      'deepLink': deepLink,
    };
  }
}