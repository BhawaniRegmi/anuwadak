// controllers/exam_controller.dart
import 'package:flutter/material.dart';
import '../models/exam.dart'; // Import your Exam model

class ExamController with ChangeNotifier {
  List<Exam> _exams = []; // Private list to store exams

  List<Exam> get exams => _exams; // Public getter for exams

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ExamController() {
    // Optionally fetch initial data when the controller is created
    fetchExams();
  }

  // Simulate fetching exams from an API or database
  Future<void> fetchExams() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Dummy data for demonstration
      _exams = [
        Exam(id: 'e1', title: 'Calculus I', date: DateTime(2025, 7, 10), score: 85.5),
        Exam(id: 'e2', title: 'Physics II', date: DateTime(2025, 7, 15), score: 78.0),
        Exam(id: 'e3', title: 'Data Structures', date: DateTime(2025, 7, 20), score: 92.0),
      ];
    } catch (e) {
      _errorMessage = 'Failed to fetch exams: $e';
      debugPrint('Error fetching exams: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has finished
    }
  }

  // Add a new exam
  Future<void> addExam(Exam exam) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      _exams.add(exam);
    } catch (e) {
      _errorMessage = 'Failed to add exam: $e';
      debugPrint('Error adding exam: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Update an existing exam
  Future<void> updateExam(Exam updatedExam) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      final index = _exams.indexWhere((exam) => exam.id == updatedExam.id);
      if (index != -1) {
        _exams[index] = updatedExam;
      }
    } catch (e) {
      _errorMessage = 'Failed to update exam: $e';
      debugPrint('Error updating exam: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete an exam
  Future<void> deleteExam(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate API call
      _exams.removeWhere((exam) => exam.id == id);
    } catch (e) {
      _errorMessage = 'Failed to delete exam: $e';
      debugPrint('Error deleting exam: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}