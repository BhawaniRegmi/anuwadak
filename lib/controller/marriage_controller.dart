import 'package:flutter/material.dart';
import '../models/marriage_info.dart';

class MarriageController {
  final MarriageInfo _marriageInfo;

  MarriageController(this._marriageInfo);

  // Methods to update the model
  void updatePartner1Name(String name) {
    _marriageInfo.partner1Name = name;
  }

  void updatePartner2Name(String name) {
    _marriageInfo.partner2Name = name;
  }

  Future<void> selectMarriageDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _marriageInfo.marriageDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _marriageInfo.marriageDate) {
      _marriageInfo.marriageDate = pickedDate;
    }
  }

  void updateLocation(String location) {
    _marriageInfo.location = location;
  }

  void updatePhotoUrl(String url) {
    _marriageInfo.photoUrl = url;
  }

  // Potentially more complex logic, e.g., saving data to a backend
  void saveMarriageDetails() {
    // In a real app, you would send _marriageInfo data to a server or local storage
    print('Saving Marriage Details:');
    print('Partner 1: ${_marriageInfo.partner1Name}');
    print('Partner 2: ${_marriageInfo.partner2Name}');
    print('Date: ${_marriageInfo.marriageDate.toLocal().toIso8601String().split('T')[0]}');
    print('Location: ${_marriageInfo.location}');
    print('Photo URL: ${_marriageInfo.photoUrl}');
    // Add actual saving logic here (e.g., API call, database write)
  }
}