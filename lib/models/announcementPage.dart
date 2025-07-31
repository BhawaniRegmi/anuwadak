class Announcement {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  // Factory constructor to create an Announcement from a JSON map
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String), // Assuming date is in ISO 8601 format
    );
  }

  // Method to convert an Announcement to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}