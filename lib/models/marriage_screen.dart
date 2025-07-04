import 'package:flutter/foundation.dart';

class MarriageInfo extends ChangeNotifier {
  String _partner1Name;
  String _partner2Name;
  DateTime _marriageDate;
  String _location;
  String _photoUrl; // For a future profile picture or shared album cover

  MarriageInfo({
    String partner1Name = 'Partner 1',
    String partner2Name = 'Partner 2',
    DateTime? marriageDate,
    String location = 'Undisclosed Location',
    String photoUrl = 'https://via.placeholder.com/150', // Default placeholder
  })  : _partner1Name = partner1Name,
        _partner2Name = partner2Name,
        _marriageDate = marriageDate ?? DateTime.now(),
        _location = location,
        _photoUrl = photoUrl;

  // Getters
  String get partner1Name => _partner1Name;
  String get partner2Name => _partner2Name;
  DateTime get marriageDate => _marriageDate;
  String get location => _location;
  String get photoUrl => _photoUrl;

  // Setters (with notifyListeners to update UI)
  set partner1Name(String name) {
    if (_partner1Name != name) {
      _partner1Name = name;
      notifyListeners();
    }
  }

  set partner2Name(String name) {
    if (_partner2Name != name) {
      _partner2Name = name;
      notifyListeners();
    }
  }

  set marriageDate(DateTime date) {
    if (_marriageDate != date) {
      _marriageDate = date;
      notifyListeners();
    }
  }

  set location(String loc) {
    if (_location != loc) {
      _location = loc;
      notifyListeners();
    }
  }

  set photoUrl(String url) {
    if (_photoUrl != url) {
      _photoUrl = url;
      notifyListeners();
    }
  }

  // You can add more methods here, e.g., to load/save data from a database
  // or convert to/from JSON.
}