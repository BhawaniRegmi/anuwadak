// lib/models/location_model.dart
class LocationModel {
  final double latitude;
  final double longitude;
  final String? address; // Optional, you might add more details like city, country

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  String toString() {
    return 'Latitude: $latitude, Longitude: $longitude, Address: ${address ?? 'N/A'}';
  }
}

// Represents different states of location data
enum LocationStatus {
  initial,
  loading,
  loaded,
  permissionDenied,
  error,
}