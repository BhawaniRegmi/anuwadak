// lib/models/about_us_model.dart
class AboutUsModel {
  final String appName;
  final String appVersion;
  final String companyName;
  final String websiteUrl;
  final String contactEmail;
  final String description;
  final List<String> teamMembers;

  AboutUsModel({
    required this.appName,
    required this.appVersion,
    required this.companyName,
    required this.websiteUrl,
    required this.contactEmail,
    required this.description,
    required this.teamMembers,
  });

  // You could add a factory constructor here to parse from JSON if needed
  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      appName: json['appName'] ?? '',
      appVersion: json['appVersion'] ?? '',
      companyName: json['companyName'] ?? '',
      websiteUrl: json['websiteUrl'] ?? '',
      contactEmail: json['contactEmail'] ?? '',
      description: json['description'] ?? '',
      teamMembers: List<String>.from(json['teamMembers'] ?? []),
    );
  }

  // You could add a method to convert to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appVersion': appVersion,
      'companyName': companyName,
      'websiteUrl': websiteUrl,
      'contactEmail': contactEmail,
      'description': description,
      'teamMembers': teamMembers,
    };
  }
}