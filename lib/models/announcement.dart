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

  // Factory constructor to create an Announcement from a Map (e.g., from JSON)
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']), // Assuming 'date' is in ISO 8601 format
    );
  }

  // Method to convert an Announcement to a Map (e.g., for sending to an API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}