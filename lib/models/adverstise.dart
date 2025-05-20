class AdModel {
  final String title;
  final String imageUrl;
  final String clickUrl;

  AdModel({required this.title, required this.imageUrl, required this.clickUrl});

  // You can add factory methods for creating AdModel instances
  // from JSON or other data sources if needed.
  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      title: json['title'] ?? 'No Title',
      imageUrl: json['imageUrl'] ?? '',
      clickUrl: json['clickUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'clickUrl': clickUrl,
    };
  }
}