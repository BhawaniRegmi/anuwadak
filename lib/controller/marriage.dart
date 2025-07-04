import 'package:flutter/material.dart';
import '../models/marriage_details.dart';

class MarriageController extends ChangeNotifier {
  MarriageDetails _marriageDetails = MarriageDetails();

  MarriageDetails get marriageDetails => _marriageDetails;

  final TextEditingController partner1NameController = TextEditingController();
  final TextEditingController partner2NameController = TextEditingController();
  final TextEditingController venueController = TextEditingController();

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  MarriageController() {
    // Initialize controllers with existing data if available (e.g., loaded from persistence)
    // For this example, they start empty.
  }

  void setPartner1Name(String name) {
    _marriageDetails.partner1Name = name;
    notifyListeners(); // Notify UI that data has changed
  }

  void setPartner2Name(String name) {
    _marriageDetails.partner2Name = name;
    notifyListeners();
  }

  void setMarriageDate(DateTime? date) {
    _marriageDetails.marriageDate = date;
    _selectedDate = date; // Update the private selectedDate for the date picker
    notifyListeners();
  }

  void setVenue(String venue) {
    _marriageDetails.venue = venue;
    notifyListeners();
  }

  // Method to handle date picking from the UI
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setMarriageDate(picked);
    }
  }

  // Method to submit the marriage details (e.g., save to a database)
  void submitMarriageDetails() {
    // Basic validation
    if (_marriageDetails.partner1Name == null || _marriageDetails.partner1Name!.isEmpty) {
      print('Partner 1 name is required.');
      // In a real app, you'd show a SnackBar or AlertDialog
      return;
    }
    if (_marriageDetails.partner2Name == null || _marriageDetails.partner2Name!.isEmpty) {
      print('Partner 2 name is required.');
      return;
    }
    if (_marriageDetails.marriageDate == null) {
      print('Marriage date is required.');
      return;
    }

    print('Submitting Marriage Details:');
    print(_marriageDetails.toString());

    // Here you would typically send data to a service for persistence
    // Example: saveDataToDatabase(_marriageDetails);

    // After successful submission, you might navigate away or show a success message
  }

  // Dispose of TextEditingControllers when the controller is no longer needed
  @override
  void dispose() {
    partner1NameController.dispose();
    partner2NameController.dispose();
    venueController.dispose();
    super.dispose();
  }
}