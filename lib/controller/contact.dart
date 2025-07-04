import 'package:flutter/material.dart';
import 'package:your_app_name/contact_model.dart'; // Make sure this path is correct

class ContactController extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners(); // Notify listeners to rebuild widgets that depend on this data
  }

  void updateContact(int index, Contact updatedContact) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  void deleteContact(int index) {
    if (index >= 0 && index < _contacts.length) {
      _contacts.removeAt(index);
      notifyListeners();
    }
  }

  // Example: Initialize with some dummy data
  ContactController() {
    _contacts = [
      Contact(name: 'John Doe', phoneNumber: '123-456-7890', email: 'john.doe@example.com', address: '123 Main St'),
      Contact(name: 'Jane Smith', phoneNumber: '987-654-3210', address: '456 Oak Ave'),
      Contact(name: 'Peter Jones', phoneNumber: '555-123-4567'),
    ];
  }
}