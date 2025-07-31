// lib/controllers/student_result_controller.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import '../models/student_result.dart';

class StudentResultController with ChangeNotifier {
  final List<StudentResult> _results = [];
  final Uuid _uuid = const Uuid(); // Instantiate Uuid

  List<StudentResult> get results => List.unmodifiable(_results); // Expose an unmodifiable list

  // --- CRUD Operations ---

  void addResult({
    required String studentName,
    required String subject,
    required int marksObtained,
    required int totalMarks,
  }) {
    // Basic grade calculation logic (you can make this more complex)
    String grade;
    double percentage = (marksObtained / totalMarks) * 100;
    if (percentage >= 90) {
      grade = 'A+';
    } else if (percentage >= 80) {
      grade = 'A';
    } else if (percentage >= 70) {
      grade = 'B+';
    } else if (percentage >= 60) {
      grade = 'B';
    } else if (percentage >= 50) {
      grade = 'C';
    } else {
      grade = 'F'; // Fail
    }

    final newResult = StudentResult(
      id: _uuid.v4(), // Generate a unique ID
      studentName: studentName,
      subject: subject,
      marksObtained: marksObtained,
      totalMarks: totalMarks,
      grade: grade,
    );
    _results.add(newResult);
    notifyListeners(); // Notify UI that data has changed
  }

  void updateResult(StudentResult updatedResult) {
    final index = _results.indexWhere((result) => result.id == updatedResult.id);
    if (index != -1) {
      // Re-calculate grade if marks changed during an update
      String newGrade;
      double newPercentage = (updatedResult.marksObtained / updatedResult.totalMarks) * 100;
      if (newPercentage >= 90) {
        newGrade = 'A+';
      } else if (newPercentage >= 80) {
        newGrade = 'A';
      } else if (newPercentage >= 70) {
        newGrade = 'B+';
      } else if (newPercentage >= 60) {
        newGrade = 'B';
      } else if (newPercentage >= 50) {
        newGrade = 'C';
      } else {
        newGrade = 'F';
      }
      _results[index] = updatedResult.copyWith(grade: newGrade);
      notifyListeners();
    }
  }

  void deleteResult(String id) {
    _results.removeWhere((result) => result.id == id);
    notifyListeners();
  }

  // You can add more complex methods here, e.g., filtering, sorting, fetching from API.
}