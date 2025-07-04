import 'package:flutter/material.dart';
import 'package:your_app_name/models/city_model.dart'; // Adjust path as needed

class CityController extends ChangeNotifier {
  List<City> _cities = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<City> get cities => _cities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Simulate fetching cities from an API
  Future<void> fetchCities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // This would be your actual API call
      // For demonstration, we'll use dummy data
      _cities = [
        City(id: '1', name: 'New York', country: 'USA'),
        City(id: '2', name: 'London', country: 'UK'),
        City(id: '3', name: 'Paris', country: 'France'),
        City(id: '4', name: 'Tokyo', country: 'Japan'),
        City(id: '5', name: 'Sydney', country: 'Australia'),
        City(id: '6', name: 'Kathmandu', country: 'Nepal'), // Added for local relevance
        City(id: '7', name: 'Berlin', country: 'Germany'),
        City(id: '8', name: 'Rome', country: 'Italy'),
        City(id: '9', name: 'Cairo', country: 'Egypt'),
        City(id: '10', name: 'Rio de Janeiro', country: 'Brazil'),
      ];
    } catch (e) {
      _errorMessage = 'Failed to fetch cities: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Example of adding a city (you might want to handle this in your service layer)
  void addCity(City newCity) {
    _cities.add(newCity);
    notifyListeners();
  }

  // Example of removing a city
  void removeCity(String id) {
    _cities.removeWhere((city) => city.id == id);
    notifyListeners();
  }
}