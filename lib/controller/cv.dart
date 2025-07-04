// cv_controller.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Often used with ChangeNotifier
import 'cv_model.dart';

class CvController extends ChangeNotifier {
  CV? _cv; // Our CV data

  // A getter to access the CV data from the UI
  CV? get cv => _cv;

  CvController() {
    // Initialize with dummy data for demonstration
    _cv = CV.dummy();
  }

  // Example method to load CV data (e.g., from an API or local storage)
  Future<void> loadCvData() async {
    // Simulate API call or database fetch
    await Future.delayed(const Duration(seconds: 1));
    _cv = CV.dummy(); // Reload dummy data for example
    notifyListeners(); // Notify listeners that data has changed
  }

  // Example method to update professional summary (demonstrates data manipulation)
  void updateProfessionalSummary(String newSummary) {
    if (_cv != null) {
      _cv = CV(
        fullName: _cv!.fullName,
        email: _cv!.email,
        phoneNumber: _cv!.phoneNumber,
        address: _cv!.address,
        professionalSummary: newSummary,
        education: _cv!.education,
        experience: _cv!.experience,
        skills: _cv!.skills,
      );
      notifyListeners(); // Notify listeners
    }
  }

  // You would add more methods here for updating other CV sections
  // e.g., addEducation, removeExperience, updateSkill, etc.
}