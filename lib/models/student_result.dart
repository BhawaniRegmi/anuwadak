// lib/models/student_result.dart
class StudentResult {
  String id; // Unique identifier for each result
  String studentName;
  String subject;
  int marksObtained;
  int totalMarks;
  String grade; // Calculated or assigned grade

  StudentResult({
    required this.id,
    required this.studentName,
    required this.subject,
    required this.marksObtained,
    required this.totalMarks,
    required this.grade,
  });

  // Helper to calculate percentage (optional, can be done in UI or controller)
  double get percentage {
    if (totalMarks == 0) return 0.0;
    return (marksObtained / totalMarks) * 100;
  }

  // Method to easily copy a StudentResult object (useful for editing)
  StudentResult copyWith({
    String? id,
    String? studentName,
    String? subject,
    int? marksObtained,
    int? totalMarks,
    String? grade,
  }) {
    return StudentResult(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      subject: subject ?? this.subject,
      marksObtained: marksObtained ?? this.marksObtained,
      totalMarks: totalMarks ?? this.totalMarks,
      grade: grade ?? this.grade,
    );
  }
}