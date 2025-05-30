// lib/controllers/flight_controller.dart

import 'package:flutter/material.dart';
import '../models/flight_model.dart';

class FlightController extends ChangeNotifier {
  List<FlightModel> _availableFlights = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FlightModel> get availableFlights => _availableFlights;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Dummy flight data
  final List<FlightModel> _allDummyFlights = [
    FlightModel(
      flightNumber: 'FL101',
      airline: 'Air Flutter',
      departureAirportCode: 'JFK',
      departureCity: 'New York',
      departureTime: DateTime(2025, 7, 10, 8, 0),
      arrivalAirportCode: 'LAX',
      arrivalCity: 'Los Angeles',
      arrivalTime: DateTime(2025, 7, 10, 11, 0),
      price: 350.00,
    ),
    FlightModel(
      flightNumber: 'FL102',
      airline: 'Dart Airlines',
      departureAirportCode: 'LAX',
      departureCity: 'Los Angeles',
      departureTime: DateTime(2025, 7, 10, 13, 0),
      arrivalAirportCode: 'JFK',
      arrivalCity: 'New York',
      arrivalTime: DateTime(2025, 7, 10, 18, 0),
      price: 320.00,
    ),
    FlightModel(
      flightNumber: 'FL103',
      airline: 'Air Flutter',
      departureAirportCode: 'LHR',
      departureCity: 'London',
      departureTime: DateTime(2025, 7, 15, 9, 30),
      arrivalAirportCode: 'CDG',
      arrivalCity: 'Paris',
      arrivalTime: DateTime(2025, 7, 15, 11, 0),
      price: 120.00,
    ),
    FlightModel(
      flightNumber: 'FL104',
      airline: 'Dart Airlines',
      departureAirportCode: 'CDG',
      departureCity: 'Paris',
      departureTime: DateTime(2025, 7, 15, 12, 0),
      arrivalAirportCode: 'LHR',
      arrivalCity: 'London',
      arrivalTime: DateTime(2025, 7, 15, 13, 30),
      price: 110.00,
    ),
     FlightModel(
      flightNumber: 'FL201',
      airline: 'Nepali Wings',
      departureAirportCode: 'KTM',
      departureCity: 'Kathmandu',
      departureTime: DateTime(2025, 8, 1, 10, 0),
      arrivalAirportCode: 'DXB',
      arrivalCity: 'Dubai',
      arrivalTime: DateTime(2025, 8, 1, 14, 0),
      price: 450.00,
    ),
    FlightModel(
      flightNumber: 'FL202',
      airline: 'Himalayan Air',
      departureAirportCode: 'DXB',
      departureCity: 'Dubai',
      departureTime: DateTime(2025, 8, 5, 18, 0),
      arrivalAirportCode: 'KTM',
      arrivalCity: 'Kathmandu',
      arrivalTime: DateTime(2025, 8, 6, 1, 0),
      price: 420.00,
    ),
    // Add more dummy flights as needed
  ];

  Future<void> searchFlights({
    required String departureCity,
    required String destinationCity,
    required DateTime departureDate,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _availableFlights = []; // Clear previous results
    notifyListeners();

    try {
      // Simulate a network request delay
      await Future.delayed(const Duration(seconds: 2));

      final DateTime searchDateOnly = DateTime(departureDate.year, departureDate.month, departureDate.day);

      _availableFlights = _allDummyFlights.where((flight) {
        // Compare cities case-insensitively
        final bool cityMatch = flight.departureCity.toLowerCase() == departureCity.toLowerCase() &&
                             flight.arrivalCity.toLowerCase() == destinationCity.toLowerCase();

        // Compare dates only (ignore time for the search)
        final DateTime flightDateOnly = DateTime(flight.departureTime.year, flight.departureTime.month, flight.departureTime.day);
        final bool dateMatch = flightDateOnly.isAtSameMomentAs(searchDateOnly);

        return cityMatch && dateMatch;
      }).toList();

      if (_availableFlights.isEmpty) {
        _errorMessage = 'No flights found for this route and date.';
      }

    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to clear search results and error messages
  void clearResults() {
    _availableFlights = [];
    _errorMessage = null;
    notifyListeners();
  }
}