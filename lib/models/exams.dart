// models/exam.dart
class Exam {
  final String id;
  String title;
  DateTime date;
  double score;

  Exam({
    required this.id,
    required this.title,
    required this.date,
    this.score = 0.0,
  });

  // Factory constructor to create an Exam from a Map (e.g., from JSON)
  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      score: json['score'].toDouble(),
    );
  }

  // Convert an Exam object to a Map (e.g., for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'score': score,
    };
  }
}