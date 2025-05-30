// lib/models/vehicle.dart

class Vehicle {
  final String id;
  final String make;
  final String model;
  final int year;
  final String color;

  Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
  });

  // Factory constructor to create a Vehicle from a JSON map (e.g., from an API)
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      color: json['color'] as String,
    );
  }

  // Method to convert a Vehicle to a JSON map (e.g., for sending to an API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'color': color,
    };
  }
}