// lib/controllers/vehicle_controller.dart

import 'package:flutter/foundation.dart';
import '../models/vehicle.dart';

class VehicleController extends ChangeNotifier {
  List<Vehicle> _vehicles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  VehicleController() {
    fetchVehicles(); // Fetch vehicles when the controller is initialized
  }

  Future<void> fetchVehicles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that loading has started

    try {
      // Simulate an API call or database fetch
      await Future.delayed(const Duration(seconds: 2));

      // Dummy data
      _vehicles = [
        Vehicle(id: 'v1', make: 'Toyota', model: 'Camry', year: 2022, color: 'Silver'),
        Vehicle(id: 'v2', make: 'Honda', model: 'Civic', year: 2023, color: 'Blue'),
        Vehicle(id: 'v3', make: 'Ford', model: 'F-150', year: 2021, color: 'Black'),
        Vehicle(id: 'v4', make: 'Tesla', model: 'Model 3', year: 2024, color: 'White'),
      ];

      _isLoading = false;
      notifyListeners(); // Notify listeners that vehicles have been fetched
    } catch (e) {
      _errorMessage = 'Failed to load vehicles: $e';
      _isLoading = false;
      notifyListeners(); // Notify listeners about the error
    }
  }

  // Example of adding a new vehicle (simulated)
  Future<void> addVehicle(Vehicle vehicle) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      _vehicles.add(vehicle);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add vehicle: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Example of deleting a vehicle (simulated)
  Future<void> deleteVehicle(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      _vehicles.removeWhere((vehicle) => vehicle.id == id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete vehicle: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}